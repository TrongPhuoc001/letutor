import 'package:lettutor/model/user.dart';

class Tutor {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  User? user;
  bool? isFavorite;
  double? avgRating;
  int? totalFeedback;

  Tutor(
      {this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.user,
      this.isFavorite,
      this.avgRating,
      this.totalFeedback});

  Tutor.fromJson(Map<String, dynamic> json) {
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    isFavorite = json['isFavorite'];
    avgRating = json['avgRating'];
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['accent'] = this.accent;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['rating'] = this.rating;
    data['isNative'] = this.isNative;
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    data['isFavorite'] = this.isFavorite;
    data['avgRating'] = this.avgRating;
    data['totalFeedback'] = this.totalFeedback;
    return data;
  }
}
