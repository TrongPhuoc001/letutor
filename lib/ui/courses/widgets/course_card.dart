import 'package:flutter/material.dart';
import 'package:lettutor/model/course_model.dart';

Widget CourseCard(CourseModel course) {
  return Card(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Image.network(course.imageUrl),
        Text(course.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
          child: Text(course.description),
        ),
        Row(children: [
          Text(course.level),
          Text(" • "),
          Text(course.totlalLessons.toString() + " lessons")
        ])
      ]),
    ),
  );
}
