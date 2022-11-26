import 'package:flutter/material.dart';
import 'package:lettutor/constants/specialty.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/ui/teacher/teacher_detail.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../model/tutor.dart';
import '../round_button_outlined.dart';

Widget TeacherCard(TutorShortInfo teacher, context, {isFavorite = false}) {
  return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Card(
          margin: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
                color: Color.fromARGB(179, 233, 231, 231), width: 1),
          ),
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        TeacherDetail(teacher: teacher)));
                          },
                          child: TeacherShortInfo(teacher)),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.blue,
                            ),
                            onPressed: () {},
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Wrap(
                        children: teacher.specialties!
                            .split(',')
                            .map((tag) => Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Chip(
                                    label: Text(SPECIALTIES[tag] != null
                                        ? SPECIALTIES[tag]!
                                        : tag),
                                    backgroundColor:
                                        Color.fromRGBO(0, 113, 240, 0.1),
                                    labelStyle: const TextStyle(
                                        color: Color.fromRGBO(0, 113, 240, 1),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ))
                            .toList(),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        teacher.bio!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 14, height: 1.5),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      RoundButtonOutLined(
                        child: Row(children: const [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.blue,
                          ),
                          Text(
                            "Đặt lịch",
                            style: TextStyle(color: Colors.blue),
                          )
                        ]),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ))));
}
