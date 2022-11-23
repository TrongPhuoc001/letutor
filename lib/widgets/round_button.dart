import 'package:flutter/material.dart';

Widget RoundButon({text, onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: Text(text, style: const TextStyle(color: Colors.grey)),
  );
}
