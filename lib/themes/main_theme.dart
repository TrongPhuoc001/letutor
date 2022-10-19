import 'package:flutter/material.dart';
import 'package:lettutor/constants/assets.dart';
import 'package:lettutor/ui/menu/menu.dart';
import 'package:lettutor/widgets/border_icon.dart';

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
                            builder: (context) => const Menu(
                                user: User(
                                    id: "f569c202-7bbf-4620-af77-ecc1419a6b28",
                                    avatar:
                                        "https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1657037111897.jpg",
                                    name: "Long Long",
                                    email: 'student@lettutor.com'))));
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
        Image.asset(Assets.logo, height: 40),
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
