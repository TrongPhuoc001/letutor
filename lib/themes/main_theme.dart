import 'package:flutter/material.dart';
import 'package:lettutor/constants/assets.dart';
import 'package:lettutor/ui/menu/menu.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';
import 'package:lettutor/widgets/border_icon.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';

Widget MainTheme({hideMenu = false, child, context, onMenu = false}) {
  Widget headerRight = Row(
    children: [
      borderIcon(Image.asset(Assets.iconVietnam)),
      hideMenu
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.only(left: 10),
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: borderIcon(Image.asset(Assets.iconMenu)),
                onPressed: () {
                  if (onMenu) {
                    Navigator.pop(context);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Menu(
                                user: context.watch<UserProvider>().user!)));
                  }
                },
              )),
    ],
  );

  Widget header = Container(
    height: 200,
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => const FindTeacher()));
            },
            child: Image.asset(Assets.logo, height: 40)),
        Spacer(),
        headerRight,
      ],
    ),
  );

  return Scaffold(
    appBar: AppBar(
      title: header,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
    ),
    body: SingleChildScrollView(child: child),
  );
}
