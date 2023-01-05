import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

notification({context, message, color = Colors.blue}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    duration: Duration(seconds: 1),
  ));
}
