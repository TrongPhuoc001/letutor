import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/model/tutor_short_info.dart';

Widget TeacherShortInfo(TutorShortInfo teacher, {contact = false, size = 60}) {
  return Row(
    children: [
      Container(
        width: size * 1.0,
        height: size * 1.0,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(teacher.avatar!),
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(teacher.name!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 12,
                child: SvgPicture.network(teacher.country!),
              ),
              Text(teacher.country!,
                  style: TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
          contact
              ? TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.message,
                              color: Colors.blue, size: 20)),
                      Text("Nhắn tin",
                          style: TextStyle(color: Colors.blue, fontSize: 14))
                    ],
                  ))
              : RatingBar.builder(
                  initialRating: double.parse(teacher.rating!),
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
