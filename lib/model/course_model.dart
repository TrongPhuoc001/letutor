import 'dart:ffi';

class CourseModel {
  String description;

  String imageUrl;

  String level;

  String title;

  int totlalLessons;

  CourseModel(
      {required this.imageUrl,
      required this.title,
      required this.description,
      required this.level,
      required this.totlalLessons});
}
