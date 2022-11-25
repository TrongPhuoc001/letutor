import 'package:flutter/material.dart';
import 'package:lettutor/api/tutor/tutor.api.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/widgets/home/banner.dart';
import 'package:lettutor/widgets/home/filter.dart';
import 'package:lettutor/widgets/teacher/teacher_list.dart';

class FindTeacher extends StatefulWidget {
  const FindTeacher({super.key});

  @override
  _FindTeacherState createState() => _FindTeacherState();
}

class _FindTeacherState extends State<FindTeacher> {
  Future<TutorMoreResponse> teacherList = TutorApi.getMoreTutors(1);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: teacherList,
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            TutorMoreResponse data = snapshot.data as TutorMoreResponse;
            return MainTheme(
                context: context,
                child: Column(children: [
                  HomeBanner(courseNumber: 0, totalLearned: 9275),
                  Fliter(),
                  const Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Text(
                    "Gia sư được đề xuất",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  TeacherList(data.tutors!.rows!, context)
                ]));
          }
          return Center(child: CircularProgressIndicator());
        }));
  }
}
