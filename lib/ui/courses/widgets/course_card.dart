import 'package:flutter/material.dart';
import 'package:lettutor/model/course_model.dart';
import 'package:lettutor/ui/courses/course_detail.dart';

Widget CourseCard(CourseModel course, BuildContext context) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetail(course: course)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(
              color: Color.fromARGB(179, 233, 231, 231), width: 1),
        ),
        child: Column(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(course.imageUrl!),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                Text(course.name!,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  child: Text(course.description!),
                ),
                Row(children: [
                  Text(course.level!),
                  Text(" • "),
                  Text(course.topics!.length.toString() + " lessons")
                ])
              ]))
        ]),
      ));
}
