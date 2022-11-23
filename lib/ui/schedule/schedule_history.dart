import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/schedule/widgets/header.dart';
import 'package:lettutor/ui/schedule/widgets/schedule_history_item.dart';

import '../../model/schedule_model.dart';

class ScheduleHistory extends StatelessWidget {
  const ScheduleHistory({super.key});

  @override
  Widget build(BuildContext context) {
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
                lowerContent: 'Đây là danh sách các bài học bạn đã tham gia',
                upperContent: "Lịch sử các buổi học",
                lowerSubContent:
                    "Bạn có thể xem lại thông tin chi tiết về các buổi học đã tham gia đã tham gia",
              ),
              SizedBox(
                height: 20,
              ),
              ScheduleHistoryItem(Schedule()),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
