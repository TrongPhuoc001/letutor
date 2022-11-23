import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  String title;
  IconData iconData;
  Color? color;
  IconText({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          size: 30,
          color: color ?? Colors.blue,
        ),
        Text(
          title,
          style: TextStyle(color: color ?? Colors.blue, fontSize: 16),
        )
      ],
    );
  }
}
