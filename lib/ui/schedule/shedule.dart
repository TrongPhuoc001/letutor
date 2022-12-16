import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:lettutor/model/schedule_model.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/schedule/widgets/header.dart';
import 'package:lettutor/ui/schedule/widgets/schedule_item.dart';
import 'package:lettutor/widgets/teacher/book_chedule_item.dart';

import '../../widgets/home/pagination.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleState();
}

class _ScheduleState extends State<ScheduleScreen> {
  int page = 1;
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ScheduleApi.getStudentSchedule(
            page: page,
            timestamp: (now.microsecondsSinceEpoch / 1000).round(),
            isHistory: false),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            StudentScheduleResponse data =
                snapshot.data as StudentScheduleResponse;
            List<Schedule> schedules = data.data!.rows!;
            schedules.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp!
                .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp!));
            Map<String, List<Schedule>> scheduleMap = {};
            schedules.forEach((schedule) {
              String date = readTimestamp(
                  schedule.scheduleDetailInfo!.startPeriodTimestamp!);
              if (scheduleMap[date] == null) {
                scheduleMap[date] = [];
              }
              scheduleMap[date]!.add(schedule);
            });
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
                        child:
                            SvgPicture.asset("assets/icons/calendar-check.svg"),
                      ),
                      lowerContent:
                          'Đây là danh sách những khung giờ bạn đã đặt ',
                      upperContent: "Lịch đã đặt",
                      lowerSubContent:
                          "Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ...scheduleMap.entries.map((e) => ScheduleItem(e.value)),
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
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
