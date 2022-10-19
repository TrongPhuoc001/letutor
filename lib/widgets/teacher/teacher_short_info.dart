import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../model/teacher.dart';

Widget TeacherShortInfo(Teacher teacher) {
  return Row(
    children: [
      Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(teacher.avatarUrl),
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(teacher.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 12,
                child: SvgPicture.network(teacher.nation.flagUrl),
              ),
              Text(teacher.nation.name,
                  style: TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
          RatingBar.builder(
            initialRating: teacher.rating,
            itemBuilder: (context, _) =>
                Icon(Icons.star, color: Colors.amber, size: 15),
            onRatingUpdate: (r) {},
            ignoreGestures: true,
            itemSize: 20,
          ),
        ],
      )
    ],
  );
}
