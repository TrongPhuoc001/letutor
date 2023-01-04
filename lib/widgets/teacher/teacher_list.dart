import 'package:flutter/material.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/widgets/teacher/teacher_card.dart';

Widget TeacherList(List<TutorShortInfo> teacherList, context) {
  List<Widget> teacherCardList = teacherList.isEmpty
      ? [Text('Không có kết quả tìm kiếm ')]
      : teacherList
          .map((teacher) => TeacherCard(
                teacher: teacher,
                isFavorite: teacher.isfavoritetutor != null
                    ? teacher.isfavoritetutor!
                    : false,
              ))
          .toList();
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(children: teacherCardList),
  );
}
