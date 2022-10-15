import 'package:flutter/material.dart';
import 'package:lettutor/constants/assets.dart';
import 'package:lettutor/widgets/border_icon.dart';

Widget mainTheme({showMenu = true, child}) {
  Widget headerRight = Row(
    children: [
      borderIcon(Image.asset(Assets.iconVietnam)),
      showMenu
          ? Container(
              margin: const EdgeInsets.only(left: 10),
              child: borderIcon(Image.asset(Assets.iconMenu)))
          : const SizedBox(),
    ],
  );

  Widget header = Container(
    height: 200,
    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(Assets.logo, height: 40),
        headerRight,
      ],
    ),
  );

  return MaterialApp(
    title: 'Welcome to Flutter',
    home: Scaffold(
      appBar: AppBar(
        title: header,
        backgroundColor: Colors.white,
      ),
      body: child,
    ),
  );
}
