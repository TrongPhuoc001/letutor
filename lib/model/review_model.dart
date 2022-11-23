import 'package:lettutor/model/user.dart';

class ReviewModel {
  ReviewModel(
      {required this.user,
      required this.rating,
      required this.comment,
      required this.createAt});
  User user;
  double rating;
  String comment;
  DateTime createAt;
}
