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

class FindTeacher extends StatefulWidget {
  const FindTeacher({super.key});

  @override
  _FindTeacherState createState() => _FindTeacherState();
}

class _FindTeacherState extends State<FindTeacher> {
  Future<TutorMoreResponse> teacherList = TutorApi.getMoreTutors(1);
  int page = 1;

  Future<dynamic> getBannerInfo() async {
    NextScheduleResponse stuSche = await ScheduleApi.getNextSchedule();
    int total = await ScheduleApi.getTotalHours();
    return [stuSche.data!, total];
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FilterProvider>().addListener(() {
      print(FilterProvider.searchController.text);
      if (FilterProvider.searchController.text == '' &&
          FilterProvider.specialties == null) {
        setState(() {
          teacherList = TutorApi.getMoreTutors(page);
        });
      } else {
        setState(() {
          teacherList = TutorApi.searchTutors();
        });
      }
    });
    return FutureBuilder(
        future: teacherList,
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            TutorMoreResponse data = snapshot.data as TutorMoreResponse;

            return MainTheme(
                context: context,
                child: Column(children: [
                  FutureBuilder(
                      future: getBannerInfo(),
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
          }
          return Center(child: CircularProgressIndicator());
        }));
  }
}
