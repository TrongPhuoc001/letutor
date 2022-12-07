import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/api/tutor/tutor.api.dart';
import 'package:lettutor/model/review_model.dart';
import 'package:lettutor/widgets/home/pagination.dart';

import '../../../model/user.dart';

class Review extends StatefulWidget {
  Review(
      {Key? key,
      required this.isVisible,
      required this.tutorId,
      required this.onClose})
      : super(key: key);

  final bool isVisible;

  String tutorId;

  final Function onClose;

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget.isVisible,
        child: FutureBuilder(
          future: TutorApi.getTutorReview(widget.tutorId, page),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              List<ReviewModel> reviews =
                  snapshot.data!.rows as List<ReviewModel>;
              int totalPage = (snapshot.data!.count! / 12).ceil();
              return Positioned(
                child: Container(
                  width: 300,
                  height: 400,
                  margin: EdgeInsets.only(top: 100),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        )
                      ]),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Reviews"),
                            IconButton(
                                onPressed: () {
                                  widget.onClose();
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: reviews
                              .map((e) => ReviewItem(review: e))
                              .toList(),
                        ),
                      ),
                      Pagination(
                          totalPage: totalPage,
                          currentPage: page,
                          onPageChanged: (value) {
                            setState(() {
                              page = value;
                            });
                          })
                    ],
                  )),
                ),
              );
            } else {
              return Positioned(
                  child: Container(
                      width: 300,
                      height: 400,
                      margin: EdgeInsets.only(top: 100),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: Offset(0, 0),
                            )
                          ]),
                      child: Center(child: CircularProgressIndicator())));
            }
          },
        ));
  }
}

Widget ReviewItem({required ReviewModel review}) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(review.firstInfo!.avatar!),
                  fit: BoxFit.cover)),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('${review.firstInfo!.name} ',
                      style: TextStyle(color: Colors.grey)),
                  Text(
                    DateTime.now()
                            .difference(DateTime.parse(review!.createdAt!))
                            .inHours
                            .toString() +
                        " hours ago",
                    style: TextStyle(color: Colors.grey[300]),
                  )
                ],
              ),
              RatingBar.builder(
                initialRating: review.rating!,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber, size: 15),
                onRatingUpdate: (r) {},
                ignoreGestures: true,
                itemSize: 10,
              ),
              Text(
                review.content!,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
