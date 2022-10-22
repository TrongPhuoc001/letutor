import 'package:flutter/material.dart';
import 'package:lettutor/model/teacher.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_info.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_schedule.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_video.dart';

import '../../widgets/icon_text.dart';

class TeacherDetail extends StatelessWidget {
  const TeacherDetail({Key? key, required this.teacher}) : super(key: key);
  final Teacher teacher;

  @override
  Widget build(BuildContext context) {
    return MainTheme(
        context: context,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TeacherInfo(teacher: teacher),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconText(
                  iconData: Icons.favorite_outline,
                  title: "Yêu thích",
                ),
                IconText(
                  iconData: Icons.report_outlined,
                  title: "Báo cáo",
                ),
                InkWell(
                  onTap: () {},
                  child: IconText(
                    iconData: Icons.star_outline,
                    title: "Đánh giá",
                  ),
                ),
              ],
            ),
            TeacherVideo(),
            Text(
              "Ngôn ngữ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Chip(
                    label: Text("English"),
                    backgroundColor: Color.fromRGBO(0, 113, 240, 0.1),
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(0, 113, 240, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Chip(
                    label: Text("Janpanese"),
                    backgroundColor: Color.fromRGBO(0, 113, 240, 0.1),
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(0, 113, 240, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Text(
              "Chuyên ngành",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Chip(
                    label: Text("Tiếng anh cho công việc"),
                    backgroundColor: Color.fromRGBO(0, 113, 240, 0.1),
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(0, 113, 240, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Chip(
                    label: Text("IELTS"),
                    backgroundColor: Color.fromRGBO(0, 113, 240, 0.1),
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(0, 113, 240, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Chip(
                    label: Text("PET"),
                    backgroundColor: Color.fromRGBO(0, 113, 240, 0.1),
                    labelStyle: const TextStyle(
                        color: Color.fromRGBO(0, 113, 240, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
            Text(
              "Khóa học tham khảo",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(children: [
                            Text("Basic Conversation Topics:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900)),
                            TextButton(
                                onPressed: () {}, child: Text("Tìm hiểu"))
                          ]),
                        ),
                      ],
                    )),
              ],
            ),
            Text(
              "Sở thích",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "I loved the weather, the scenery and the laid-back lifestyle of the locals.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Text(
              "Kinh nghiệm giảng dạy",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "I have more than 10 years of teaching english experience",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TeacherSchedule()
          ]),
        ));
  }
}
