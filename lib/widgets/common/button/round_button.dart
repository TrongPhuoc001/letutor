import 'package:flutter/material.dart';

Widget RoundButon({text, onPressed, isSelected}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: isSelected ? Colors.blue[100] : Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: Text(text,
        style: TextStyle(color: isSelected ? Colors.blue : Colors.grey)),
  );
}
