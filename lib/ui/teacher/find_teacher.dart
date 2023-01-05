import 'package:flutter/material.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:lettutor/api/tutor/tutor.api.dart';
import 'package:lettutor/model/favorite_tutor.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/widgets/home/banner.dart';
import 'package:lettutor/widgets/home/filter.dart';
import 'package:lettutor/widgets/home/pagination.dart';
import 'package:lettutor/widgets/teacher/teacher_list.dart';
import 'package:provider/provider.dart';

import '../../model/user.dart';

class FindTeacher extends StatefulWidget {
  const FindTeacher({super.key});

  @override
  _FindTeacherState createState() => _FindTeacherState();
}

class _FindTeacherState extends State<FindTeacher> {
  Future<TutorMoreResponse> teacherList = TutorApi.getMoreTutors(1);
  List<String> favoriteTutors = [];
  int page = 1;

  Future<dynamic> getBannerInfo(User user) async {
    NextScheduleResponse stuSche = await ScheduleApi.getNextSchedule();
    int total = await ScheduleApi.getTotalHours();
    return [stuSche.data!, total];
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FilterProvider>().addListener(() {
      if (FilterProvider.searchController.text == '' &&
          FilterProvider.specialties == null &&
          FilterProvider.nation.length == 0) {
        setState(() {
          teacherList = TutorApi.getMoreTutors(page);
        });
      } else {
        setState(() {
          teacherList = TutorApi.searchTutors();
        });
      }
    });
    User user = context.watch<UserProvider>().currentUser;
    return FutureBuilder(
        future: teacherList,
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            TutorMoreResponse data = snapshot.data as TutorMoreResponse;
            if (data.favoriteTutor != null) {
              favoriteTutors = data.favoriteTutor!.map((e) {
                if (e.secondInfo != null && e.secondInfo?.tutorInfo != null) {
                  if (e.secondInfo!.tutorInfo!.id != null) {
                    return e.secondInfo!.tutorInfo!.id!;
                  } else {
                    return '';
                  }
                } else {
                  return '';
                }
              }).toList();
            }
            data.tutors!.rows!.forEach((element) {
              if (favoriteTutors.contains(element.id)) {
                element.isfavoritetutor = true;
              }
            });
            return MainTheme(
                context: context,
                child: Column(children: [
                  FutureBuilder(
                      future: getBannerInfo(user),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          List<dynamic> bannerInfo =
                              snapshot.data as List<dynamic>;
                          return HomeBanner(
                              schedules: bannerInfo[0],
                              totalLearned: bannerInfo[1]);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                  Fliter(),
                  const Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Text(
                    "Gia sư được đề xuất",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  TeacherList(data.tutors!.rows!, context),
                  Pagination(
                      totalPage: (data.tutors!.count! / 9).ceil(),
                      currentPage: page,
                      onPageChanged: (p) {
                        setState(() {
                          page = p;
                          teacherList = TutorApi.getMoreTutors(page);
                        });
                      })
                ]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }));
  }
}
