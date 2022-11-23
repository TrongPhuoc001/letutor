import 'dart:ffi';

class CourseModel {
  String description;

  String imageUrl;

  String level;

  String name;

  List<TopicModel> topics;

  String purpose;

  String reason;

  CourseModel(
      {required this.imageUrl,
      required this.name,
      required this.description,
      required this.level,
      required this.topics,
      required this.purpose,
      required this.reason});
}

class TopicModel {
  String name;

  TopicModel({required this.name});
}
