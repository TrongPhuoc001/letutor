import 'package:flutter/material.dart';
import '../../../model/user.dart';
import '../../../widgets/textfield/label_eng_field.dart';

class WantToLearnWrap extends StatelessWidget {
  final List<LearnTopics> topics;
  WantToLearnWrap({
    required this.topics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey,
          )),
      child: Wrap(spacing: 5.0, runSpacing: 5.0, children: [
        ...topics.map(
          (e) => LabelEnglishType(
            content: e.name!,
          ),
        )
      ]),
    );
  }
}
