import 'package:flutter/material.dart';

Widget RoundButtonOutLined({child, onPressed}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: const BorderSide(width: 1.0, color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: child,
  );
}
