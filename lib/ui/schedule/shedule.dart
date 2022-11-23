import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/schedule/widgets/header.dart';
import 'package:lettutor/ui/schedule/widgets/schedule_item.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

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
                child: SvgPicture.asset("assets/icons/calendar-check.svg"),
              ),
              lowerContent: 'Đây là danh sách những khung giờ bạn đã đặt ',
              upperContent: "Lịch đã đặt",
              lowerSubContent:
                  "Bạn có thể theo dõi khi nào buổi học bắt đầu, tham gia buổi học bằng một cú nhấp chuột hoặc có thể hủy buổi học trước 2 tiếng.",
            ),
            SizedBox(
              height: 20,
            ),
            ScheduleItem(Schedule()),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
