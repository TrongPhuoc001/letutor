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
    return Scaffold(
      body: FutureBuilder(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          Text("Yêu thích",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: tutorDetail.isFavorite!
                                                      ? Colors.red
                                                      : Colors.blue,
                                                  fontWeight: FontWeight.w500))
                                        ],
                                      )),
                                  InkWell(
                                    onTap: () {
                                      report(context, tutorDetail.user!.id);
                                    },
                                    child: IconText(
                                      iconData: Icons.report_outlined,
                                      title: "Báo cáo",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        reviewVisible = true;
                                      });
                                    },
                                    child: IconText(
                                      iconData: Icons.star_outline,
                                      title: "Đánh giá",
                                    ),
                                  ),
                                ],
                              ),
                              TeacherVideo(videoUrl: tutorDetail.video),
                              Text(
                                "Ngôn ngữ",
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
                                "Chuyên ngành",
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
                                "Khóa học tham khảo",
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
                                                                FontWeight
                                                                    .w900)),
                                                    TextButton(
                                                        onPressed: () {},
                                                        child: Text("Tìm hiểu"))
                                                  ]),
                                                ),
                                              )
                                              .toList()
                                        ],
                                      )),
                                ],
                              ),
                              Text(
                                "Sở thích",
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
                                "Kinh nghiệm giảng dạy",
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
          })),
    );
  }

  report(context, tutorId) {
    final TextEditingController textReportController = TextEditingController();
    showBottomSheet(
        context: context,
        builder: (_) => StatefulBuilder(builder: ((context, setState) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                        controller: textReportController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gapPadding: 0),
                          hintText: 'Vui lòng nhập vấn đề bạn gặp phải',
                        ),
                        validator: ((value) {
                          if (value == null) {
                            return '';
                          }
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Báo cáo',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (textReportController.text.length == 0) {
                                  return;
                                } else {
                                  try {
                                    await TutorApi.reportTutor(
                                        textReportController.text, tutorId);
                                    notification(
                                        context: context,
                                        message: 'Báo cáo thành công');
                                    Navigator.pop(context);
                                  } catch (e) {
                                    notification(
                                        context: context,
                                        message: 'Báo cáo thất bại');
                                  }
                                }
                              },
                            ))
                      ],
                    )
                  ],
                ),
              );
            })));
  }
}
