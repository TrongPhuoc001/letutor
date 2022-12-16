import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/schedule/widgets/header.dart';
import 'package:lettutor/ui/schedule/widgets/schedule_history_item.dart';
import 'package:lettutor/widgets/home/pagination.dart';

import '../../api/schedule/schedule.api.dart';
import '../../model/schedule_model.dart';

class ScheduleHistory extends StatefulWidget {
  const ScheduleHistory({super.key});

  @override
  State<ScheduleHistory> createState() => _ScheduleHistoryState();
}

class _ScheduleHistoryState extends State<ScheduleHistory> {
  int page = 1;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ScheduleApi.getStudentSchedule(
            page: page,
            timestamp: (now.microsecondsSinceEpoch / 1000).round(),
            isHistory: true),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            StudentScheduleResponse data =
                snapshot.data as StudentScheduleResponse;
            List<Schedule> schedules = data.data!.rows!;
            return MainTheme(
                context: context,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        img: SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset("assets/icons/hsitory.svg"),
                        ),
                        lowerContent:
                            'Đây là danh sách các bài học bạn đã tham gia',
                        upperContent: "Lịch sử các buổi học",
                        lowerSubContent:
                            "Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia đã tham gia",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ...schedules
                          .map((schedule) => ScheduleHistoryItem(schedule)),
                      SizedBox(
                        height: 50,
                      ),
                      Pagination(
                          totalPage: (data.data!.count! / 10).ceil(),
                          currentPage: page,
                          onPageChanged: (value) {
                            setState(() {
                              page = value;
                            });
                          })
                    ],
                  ),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
