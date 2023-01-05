import 'dart:convert';

import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/constants/countries.dart';
import 'package:lettutor/model/favorite_tutor.dart';
import 'package:lettutor/model/review_model.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/tutor.dart';
import 'package:http/http.dart' as http;

import '../../ui/my_app.dart';

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
    secondInfo = json['secondInfo'] != null
        ? new FavoriteTutor.fromJson(json['secondInfo'])
        : null;
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

class SearchRequestPayload {
  Filters? filters;
  String? page;
  int? perPage;
  String? search;

  SearchRequestPayload({this.filters, this.page, this.perPage, this.search});

  SearchRequestPayload.fromJson(Map<String, dynamic> json) {
    filters =
        json['filters'] != null ? new Filters.fromJson(json['filters']) : null;
    page = json['page'];
    perPage = json['perPage'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filters != null) {
      data['filters'] = this.filters!.toJson();
    }
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    if (this.search != null) {
      data['search'] = this.search;
    }
    return data;
  }
}

class Filters {
  String? date;
  List<String>? specialties;
  List<int>? tutoringTimeAvailable;
  Map<String, bool>? nationality;

  Filters(
      {this.date,
      this.specialties,
      this.tutoringTimeAvailable,
      this.nationality});

  Filters.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    specialties = json['specialties'].cast<String>();
    tutoringTimeAvailable = json['tutoringTimeAvailable'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['specialties'] = this.specialties;
    data['tutoringTimeAvailable'] = this.tutoringTimeAvailable;
    data['nationality'] = this.nationality;
    return data;
  }
}

class ReviewResponse {
  int? count;
  List<ReviewModel>? rows;

  ReviewResponse({this.count, this.rows});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <ReviewModel>[];
      json['rows'].forEach((v) {
        rows!.add(new ReviewModel.fromJson(v));
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

class TutorApi {
  static String URL = 'tutor/';

  static Future<TutorMoreResponse> getMoreTutors(int page) async {
    String url = '${URL}more?perPage=9&page=$page';
    var res = await BaseApi.get(url);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        var tutorMoreResponse = TutorMoreResponse.fromJson(data);
        return tutorMoreResponse;
      } catch (e) {
        return throw Exception('Failed to load tutors');
      }
    } else {
      throw Exception('Failed to load tutors');
    }
  }

  static Future<TutorMoreResponse> searchTutors() async {
    Map<String, bool> nationality = {};
    if (FilterProvider.nation != null && FilterProvider.nation.length > 0) {
      if (FilterProvider.nation.length == 1) {
        if (NAITON_OPTION[FilterProvider.nation![0]] ==
            NAITON_OPTION["Gia sư Nước Ngoài"]) {
          nationality = {
            "isVietNamese": false,
            "isNative": false,
          };
        } else if (NAITON_OPTION[FilterProvider.nation![0]] ==
            NAITON_OPTION["Gia sư Việt Nam"]) {
          nationality = {
            "isVietNamese": true,
          };
        } else if (NAITON_OPTION[FilterProvider.nation![0]] ==
            NAITON_OPTION["Gia sư Tiếng Anh Bản Ngữ"]) {
          nationality = {
            "isNative": true,
          };
        }
      } else if (FilterProvider.nation.length == 2) {
        if (FilterProvider.nation.contains("Gia sư Nước Ngoài")) {
          if (FilterProvider.nation!.contains("Gia sư Việt Nam")) {
            nationality = {
              "isNative": false,
            };
          } else {
            nationality = {
              "isVietNamese": false,
            };
          }
        } else {
          nationality = {
            "isVietNamese": true,
            "isNative": true,
          };
        }
      }
    }
    var res = await BaseApi.post(
        "${URL}search",
        SearchRequestPayload(
                filters: Filters(
                  specialties: (FilterProvider.specialties != null &&
                          FilterProvider.specialties!.key != null)
                      ? [FilterProvider.specialties!.key!]
                      : [],
                  nationality: nationality,
                ),
                page: '1',
                perPage: 9,
                search: FilterProvider.searchController.text)
            .toJson());
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        var tutorsResponse = Tutors.fromJson(data);
        TutorMoreResponse tutorMoreResponse =
            TutorMoreResponse(tutors: tutorsResponse);
        return tutorMoreResponse;
      } catch (e) {
        return throw Exception('Failed to load tutors');
      }
    } else {
      throw Exception('Failed to load tutors');
    }
  }

  static Future<Tutor> getTutorDetail(String tutorId) async {
    var res = await BaseApi.get("${URL}${tutorId}");
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        var tutor = Tutor.fromJson(data);
        return tutor;
      } catch (e) {
        throw Exception('Failed to load tutors');
      }
    } else {
      throw Exception('Failed to load tutors');
    }
  }

  static Future<ReviewResponse> getTutorReview(String tutorId, int page) async {
    var res = await BaseApi.get("feedback/v2/${tutorId}?perPage=10&page=$page");
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        ReviewResponse reviews = ReviewResponse.fromJson(data["data"]);
        return reviews;
      } catch (e) {
        print(e);
        throw Exception('Failed to load tutors review');
      }
    } else {
      throw Exception('Failed to load tutors review');
    }
  }

  static Future<dynamic> reportTutor(String content, String tutorId) async {
    var res = await BaseApi.post("report", {
      "content": content,
      "tutorId": tutorId,
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      return data;
    } else {
      throw Exception('Failed to report tutor');
    }
  }
}
