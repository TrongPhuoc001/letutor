import 'package:flutter/material.dart';
import 'package:lettutor/model/teacher.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/widgets/home/banner.dart';
import 'package:lettutor/widgets/home/filter.dart';
import 'package:lettutor/widgets/teacher/teacher_list.dart';

class FindTeacher extends StatelessWidget {
  const FindTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    List<Teacher> teacherList = [
      Teacher(
          avatarUrl:
              "https://api.app.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1627913015850.00",
          name: "Keegan",
          nation: Nation(
              flagUrl:
                  "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/fr.svg",
              name: "France"),
          rating: 5,
          tags: [
            "Tiếng anh cho công việc",
            "Giao tiếp",
            "Tiếng anh cho trẻ em",
            "IELTS",
            "TOEIC"
          ],
          decription:
              "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia."),
      Teacher(
          avatarUrl:
              "https://api.app.lettutor.com/avatar/83802576-70fe-4394-b27a-3d9e8b50f1b7avatar1649512219387.jpg",
          name: "April Baldo",
          nation: Nation(
            flagUrl:
                "https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/flags/4x3/ph.svg",
            name: "Philippines (the)",
          ),
          rating: -1,
          tags: [
            "Tiếng anh cho công việc",
            "IELTS",
            "PET",
            "KET",
          ],
          decription:
              "Hello! My name is April Baldo, you can just call me Teacher April. I am an English teacher and currently teaching in senior high school. I have been teaching grammar and literature for almost 10 years. I am fond of reading and teaching literature as one way of knowing one’s beliefs and culture. I am friendly and full of positivity. I love teaching because I know each student has something to bring on. Molding them to become an individual is a great success.")
    ];
    return MainTheme(
        context: context,
        child: Column(children: [
          HomeBanner(courseNumber: 0, totalLearned: 9275),
          Fliter(),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Divider(),
          ),
          Text(
            "Gia sư được đề xuất",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          TeacherList(teacherList)
        ]));
  }
}
