import 'package:flutter/material.dart';

class LabelTextField extends StatelessWidget {
  String title;
  bool isImportant;
  Widget child;
  LabelTextField({
    Key? key,
    required this.title,
    required this.child,
    this.isImportant = false,
  }) : super(key: key);
  @override
  Widget build(Object context) {
    return Column(
      children: [
        Row(
          children: [
            if (isImportant)
              const Icon(Icons.label_important, color: Colors.red, size: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              width: 1.0,
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        child
      ],
    );
  }
}
