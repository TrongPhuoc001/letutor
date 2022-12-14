import 'package:flutter/material.dart';

class LabelEnglishType extends StatelessWidget {
  String content;
  LabelEnglishType({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          content,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(
          width: 10,
        ),
        const Icon(
          Icons.close,
          size: 15,
        )
      ]),
    );
  }
}
