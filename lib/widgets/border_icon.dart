import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget borderIcon(Widget icon, {double padding = 10, double size = 10}) {
  return Container(
    padding: EdgeInsets.all(padding),
    decoration:
        BoxDecoration(color: Colors.blueGrey[100], shape: BoxShape.circle),
    child: ClipOval(
      child: SizedBox.fromSize(
        size: Size.fromRadius(size), // Image radius
        child: icon,
      ),
    ),
  );
}
