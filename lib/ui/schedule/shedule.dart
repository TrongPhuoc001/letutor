import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/model/teacher.dart';
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
            ScheduleItem(ScheduleItemModel(
              teacher: Teacher(
                  avatarUrl:
                      "https://api.app.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1627913015850.00",
                  name: "Keegan",
                  nation: Nation(
                      flagUrl:
                          "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/fr.svg",
                      name: "France"),
                  rating: 5,
                  tags: [
                    "Tiếng anh cho công việc",
                    "Giao tiếp",
                    "Tiếng anh cho trẻ em",
                    "IELTS",
                    "TOEIC"
                  ],
                  decription:
                      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia."),
            )),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class ScheduleItemModel {
  Teacher teacher;
  ScheduleItemModel({required this.teacher});
}
