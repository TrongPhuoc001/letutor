import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/constants/languages.dart';
import 'package:lettutor/model/tutor_short_info.dart';

Widget TeacherShortInfo(TutorShortInfo teacher, {contact = false, size = 60}) {
  return Row(
    children: [
      Padding(
        padding: EdgeInsets.only(right: 10),
        child: ClipOval(
          child: Image.network(
            teacher.avatar != null
                ? teacher.avatar!
                : 'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg',
            width: 50,
            height: 50,
            fit: BoxFit.scaleDown,
            errorBuilder: (context, error, stackTrace) {
              return Image.network(
                  'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill);
            },
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
              teacher.country != null
                  ? Flag.fromString(teacher.country!.toLowerCase(),
                      height: 20, width: 30)
                  : SizedBox(width: 30, height: 20),
              Text(
                  teacher.country != null
                      ? (LANGUAGES[teacher.country!.toLowerCase()] ?? '')
                      : 'Vietnam',
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
              : teacher.rating != null
                  ? RatingBar.builder(
                      initialRating: teacher.rating!,
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber, size: 15),
                      onRatingUpdate: (r) {},
                      ignoreGestures: true,
                      itemSize: 20,
                    )
                  : Text('No rating'),
        ],
      )
    ],
  );
}
