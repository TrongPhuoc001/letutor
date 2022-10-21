import 'package:flutter/material.dart';

Widget RoundButtonOutLined(
    {child, onPressed, round = 32.0, color = Colors.blue}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(width: 1.0, color: color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(round * 1.0),
      ),
    ),
    child: child,
  );
}
