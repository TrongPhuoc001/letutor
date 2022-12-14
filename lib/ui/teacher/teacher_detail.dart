import 'package:flutter/material.dart';
import 'package:lettutor/api/tutor/tutor.api.dart';
import 'package:lettutor/api/user/user.api.dart';
import 'package:lettutor/constants/languages.dart';
import 'package:lettutor/constants/specialty.dart';
import 'package:lettutor/model/review_model.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/course_detail.dart';
import 'package:lettutor/ui/teacher/widgets/review.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_info.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_schedule.dart';
import 'package:lettutor/ui/teacher/widgets/teacher_video.dart';
import 'package:lettutor/widgets/notification.dart';

import '../../model/user.dart';
import '../../widgets/icon_text.dart';

List<ReviewModel> rs = [];

class TeacherDetail extends StatefulWidget {
  TeacherDetail({Key? key, required this.teacher}) : super(key: key);

  final TutorShortInfo teacher;

  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail> {
  bool reviewVisible = false;

  handleReviewClose() {
    setState(() {
      reviewVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TutorApi.getTutorDetail(widget.teacher.userId!),
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Tutor tutorDetail = snapshot.data as Tutor;
            return MainTheme(
                context: context,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TeacherInfo(teacher: widget.teacher),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      try {
                                        await UserApi.manageFavoriteTutor(
                                            tutorDetail.user!.id!);
                                        setState(() {
                                          tutorDetail.isFavorite =
                                              !tutorDetail.isFavorite!;
                                        });
                                      } catch (err) {
                                        notification(
                                            context: context,
                                            message:
                                                "Failed to add favorite tutor",
                                            color: Colors.orange);
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        tutorDetail.isFavorite!
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              )
                                            : Icon(
                                                Icons.favorite_border,
                                                color: Colors.blue,
                                              ),
                                        Text("Y??u th??ch",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: tutorDetail.isFavorite!
                                                    ? Colors.red
                                                    : Colors.blue,
                                                fontWeight: FontWeight.w500))
                                      ],
                                    )),
                                IconText(
                                  iconData: Icons.report_outlined,
                                  title: "B??o c??o",
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      reviewVisible = true;
                                    });
                                  },
                                  child: IconText(
                                    iconData: Icons.star_outline,
                                    title: "????nh gi??",
                                  ),
                                ),
                              ],
                            ),
                            TeacherVideo(videoUrl: tutorDetail.video),
                            Text(
                              "Ng??n ng???",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: [
                                ...tutorDetail.languages!
                                    .split(',')
                                    .map((l) => Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Chip(
                                            label: Text(
                                                LANGUAGES[l.toLowerCase()] ??
                                                    ''),
                                            backgroundColor: Color.fromRGBO(
                                                0, 113, 240, 0.1),
                                            labelStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 113, 240, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ))
                                    .toList(),
                              ],
                            ),
                            Text(
                              "Chuy??n ng??nh",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: [
                                ...tutorDetail.specialties!
                                    .split(',')
                                    .map(((e) => Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Chip(
                                            label: Text(SPECIALTIES[e] ?? ''),
                                            backgroundColor: Color.fromRGBO(
                                                0, 113, 240, 0.1),
                                            labelStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    0, 113, 240, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )))
                                    .toList(),
                              ],
                            ),
                            Text(
                              "Kh??a h???c tham kh???o",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...tutorDetail.user!.courses!
                                            .map(
                                              (e) => Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    20, 0, 5, 0),
                                                child: Row(children: [
                                                  Text(e.name!,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w900)),
                                                  TextButton(
                                                      onPressed: () {},
                                                      child: Text("T??m hi???u"))
                                                ]),
                                              ),
                                            )
                                            .toList()
                                      ],
                                    )),
                              ],
                            ),
                            Text(
                              "S??? th??ch",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                tutorDetail.interests!,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Text(
                              "Kinh nghi???m gi???ng d???y",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                tutorDetail.experience!,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TeacherSchedule(tutor: widget.teacher)
                          ]),
                    ),
                    Review(
                      isVisible: reviewVisible,
                      onClose: handleReviewClose,
                      tutorId: tutorDetail.user!.id!,
                    )
                  ],
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
