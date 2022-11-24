import 'dart:convert';

import 'package:lettutor/model/favorite_tutor.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/tutor.dart';
import 'package:http/http.dart' as http;

class TutorMoreResponse {
  Tutors? tutors;
  List<FavoriteTutorResponse>? favoriteTutor;

  TutorMoreResponse({this.tutors, this.favoriteTutor});

  TutorMoreResponse.fromJson(Map<String, dynamic> json) {
    tutors =
        json['tutors'] != null ? new Tutors.fromJson(json['tutors']) : null;
    if (json['favoriteTutor'] != null) {
      favoriteTutor = <FavoriteTutorResponse>[];
      json['favoriteTutor'].forEach((v) {
        favoriteTutor!.add(new FavoriteTutorResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tutors != null) {
      data['tutors'] = this.tutors!.toJson();
    }
    if (this.favoriteTutor != null) {
      data['favoriteTutor'] =
          this.favoriteTutor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tutors {
  int? count;
  List<TutorShortInfo>? rows;

  Tutors({this.count, this.rows});

  Tutors.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <TutorShortInfo>[];
      json['rows'].forEach((v) {
        rows!.add(new TutorShortInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteTutorResponse {
  String? id;
  String? firstId;
  String? secondId;
  String? createdAt;
  String? updatedAt;
  FavoriteTutor? secondInfo;

  FavoriteTutorResponse(
      {this.id,
      this.firstId,
      this.secondId,
      this.createdAt,
      this.updatedAt,
      this.secondInfo});

  FavoriteTutorResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstId = json['firstId'];
    secondId = json['secondId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    secondInfo = FavoriteTutor.fromJson(json['secondInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstId'] = this.firstId;
    data['secondId'] = this.secondId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['secondInfo'] = this.secondInfo;
    return data;
  }
}

class TutorApi {
  String URL = 'https://sandbox.api.lettutor.com/tutor/';

  Future<TutorMoreResponse> getTutors(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokens = prefs.getString('tokens');
    TokenModel tokenModel = TokenModel.fromJson(jsonDecode(tokens!));
    var res = await http
        .get(Uri.parse(URL + 'tutor/more?perPage=9&page=$page'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer${tokenModel.access?.token}',
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      var tutorMoreResponse = TutorMoreResponse.fromJson(data);
      return tutorMoreResponse;
    } else {
      throw Exception('Failed to load tutors');
    }
  }
}
