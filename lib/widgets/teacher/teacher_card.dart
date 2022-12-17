// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lettutor/api/user/user.api.dart';

import 'package:lettutor/constants/specialty.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/ui/teacher/teacher_detail.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../model/tutor.dart';
import '../common/button/round_button_outlined.dart';

class TeacherCard extends StatefulWidget {
  final TutorShortInfo teacher;
  bool isFavorite;
  TeacherCard({
    Key? key,
    required this.teacher,
    required this.isFavorite,
  }) : super(key: key);

  @override
  State<TeacherCard> createState() => _TeacherCardState();
}

class _TeacherCardState extends State<TeacherCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
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
                                      builder: (builder) => TeacherDetail(
                                          teacher: widget.teacher)));
                            },
                            child: TeacherShortInfo(widget.teacher)),
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
                              onPressed: () async {
                                try {
                                  await UserApi.manageFavoriteTutor(
                                      widget.teacher.userId!);
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                } catch (e) {}
                              },
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Wrap(
                          children: widget.teacher.specialties!
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
                          widget.teacher.bio!,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => TeacherDetail(
                                        teacher: widget.teacher)));
                          },
                        )
                      ],
                    )
                  ],
                ))));
  }
}
