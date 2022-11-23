import 'package:flutter/material.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/widgets/home/banner.dart';
import 'package:lettutor/widgets/home/filter.dart';
import 'package:lettutor/widgets/teacher/teacher_list.dart';

class FindTeacher extends StatelessWidget {
  const FindTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    List<Tutor> teacherList = [];
    return MainTheme(
        context: context,
        child: Column(children: [
          HomeBanner(courseNumber: 0, totalLearned: 9275),
          Fliter(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Divider(),
          ),
          Text(
            "Gia sư được đề xuất",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          TeacherList(teacherList, context)
        ]));
  }
}
