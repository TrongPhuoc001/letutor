import 'package:flutter/material.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

class TeacherInfo extends StatefulWidget {
  const TeacherInfo({Key? key, required this.teacher}) : super(key: key);
  final TutorShortInfo teacher;

  @override
  _TeacherInfoState createState() => _TeacherInfoState();
}

class _TeacherInfoState extends State<TeacherInfo> {
  bool showMoreDes = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TeacherShortInfo(widget.teacher, size: 120),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: showMoreDes
                          ? Text(
                              widget.teacher.bio!,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5),
                            )
                          : Text(
                              widget.teacher.bio!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.5),
                            )),
                ],
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      showMoreDes = !showMoreDes;
                    });
                  },
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Text(showMoreDes ? 'Show less' : 'Show more'))
            ],
          )
        ],
      ),
    );
  }
}
