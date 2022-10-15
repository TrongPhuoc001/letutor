import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget borderIcon(Widget icon) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration:
        BoxDecoration(color: Colors.blueGrey[100], shape: BoxShape.circle),
    child: ClipOval(
      child: SizedBox.fromSize(
        size: const Size.fromRadius(10), // Image radius
        child: icon,
      ),
    ),
  );
}
