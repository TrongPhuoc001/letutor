import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../model/teacher.dart';
import '../round_button_outlined.dart';

Widget TeacherCard(Teacher teacher) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 10,
                offset: Offset(0, 1),
                blurStyle: BlurStyle.outer // changes position of shadow
                ),
          ]),
      child: Card(
          margin: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(
                color: Color.fromARGB(179, 233, 231, 231), width: 1),
          ),
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Stack(
                    children: [
                      TeacherShortInfo(teacher),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.blue,
                            ),
                            onPressed: () {},
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Wrap(
                        children: teacher.tags
                            .map((tag) => Chip(
                                  label: Text(tag),
                                  backgroundColor: Colors.blue[100],
                                  labelStyle: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ))
                            .toList(),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        teacher.decription,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 14, height: 1.5),
                      ))
                    ],
                  ),
                  RoundButtonOutLined(
                    text: "Đặt lịch",
                    onPressed: () {},
                  )
                ],
              ))));
}
