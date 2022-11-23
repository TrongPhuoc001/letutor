import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/buy_course.dart';
import 'package:lettutor/ui/courses/course.dart';
import 'package:lettutor/ui/login/login.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/ui/profile/profile.dart';
import 'package:lettutor/ui/schedule/schedule_history.dart';
import 'package:lettutor/ui/schedule/shedule.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';
import 'package:lettutor/widgets/border_icon.dart';

import '../../model/user.dart';

class Menu extends StatelessWidget {
  const Menu({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    List<MenuItem> menuItems = [
      const MenuItem(
          title: 'Mua buổi học', icon: Icons.book, navigate: BuyCourses()),
      const MenuItem(
          title: 'Đổi mật khuẩu', icon: Icons.key, navigate: FindTeacher()),
      const MenuItem(
          title: 'Gia sư', icon: Icons.assessment, navigate: FindTeacher()),
      const MenuItem(
          title: 'Lịch học', icon: Icons.today, navigate: Schedule()),
      const MenuItem(
          title: 'Lịch sử', icon: Icons.history, navigate: ScheduleHistory()),
      const MenuItem(title: 'Khóa học', icon: Icons.school, navigate: Course()),
      const MenuItem(
          title: 'Khóa học của tôi',
          icon: Icons.auto_stories,
          navigate: FindTeacher()),
      const MenuItem(
          title: 'Đăng ký làm gia sư',
          icon: Icons.assessment,
          navigate: FindTeacher()),
      const MenuItem(title: 'Đăng xuất', icon: Icons.logout, navigate: Login()),
    ];

    List<Widget> menuItemsWidget = [
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  borderIcon(Image.network(user.avatar), padding: 0, size: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Profile(user: user)));
            },
          )
        ] +
        menuItems
            .map((item) => InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          color: Colors.blue[400],
                          size: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Text(item.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => item.navigate));
                  },
                ))
            .toList();
    return MainTheme(
        context: context,
        onMenu: true,
        child: Container(
          color: Colors.grey[100],
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 100,
          ),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: menuItemsWidget,
          ),
        ));
  }
}

class MenuItem {
  const MenuItem(
      {required this.title, required this.icon, required this.navigate});
  final String title;
  final IconData icon;
  final Widget navigate;
}
