import 'package:flutter/material.dart';
import 'package:lettutor/widgets/teacher/teacher_card.dart';

import '../../model/tutor.dart';

Widget TeacherList(List<Tutor> teacherList, context) {
  List<Widget> teacherCardList =
      teacherList.map((teacher) => TeacherCard(teacher, context)).toList();
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(children: teacherCardList),
  );
}
