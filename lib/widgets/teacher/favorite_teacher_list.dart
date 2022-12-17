import 'package:flutter/material.dart';
import 'package:lettutor/model/favorite_tutor.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/widgets/teacher/teacher_card.dart';

Widget FavoriteTeacherList(List<FavoriteTutor?> teacherList, context) {
  List<TutorShortInfo?> teacherShortInfoList = teacherList
      .map((teacher) => teacher != null
          ? TutorShortInfo(
              id: teacher.id,
              name: teacher.name,
              avatar: teacher.avatar,
              rating: teacher.tutorInfo!.rating,
              specialties: teacher.tutorInfo!.specialties,
              bio: teacher.tutorInfo!.bio)
          : null)
      .toList();
  List<TutorShortInfo> teacherShortInfoListNotNull = teacherShortInfoList
      .where((element) => element != null)
      .map((e) => e!)
      .toList();
  List<Widget> teacherCardList = teacherShortInfoListNotNull
      .map((teacher) => TeacherCard(
          teacher: teacher,
          isFavorite: teacher.isfavoritetutor == '1' ? true : false))
      .toList();
  return Padding(
    padding: EdgeInsets.all(20),
    child: Column(children: teacherCardList),
  );
}
