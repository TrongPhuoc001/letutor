import 'dart:convert';

import 'package:lettutor/model/favorite_tutor.dart';
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

  Filters({this.date, this.specialties, this.tutoringTimeAvailable});

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
    return data;
  }
}

class TutorApi {
  static String URL = 'https://sandbox.api.lettutor.com/tutor/';

  static Future<TutorMoreResponse> getMoreTutors(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokens = prefs.getString('tokens');
    TokenModel tokenModel = TokenModel.fromJson(jsonDecode(tokens!));
    String url = '${URL}more?perPage=9&page=$page';
    var res = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization': 'Bearer ${tokenModel.access?.token}',
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        var tutorMoreResponse = TutorMoreResponse.fromJson(data);
        return tutorMoreResponse;
      } catch (e) {
        print(e);
        return throw Exception('Failed to load tutors');
      }
    } else if (res.statusCode == 401) {
      prefs.remove("tokens");
      prefs.remove("user");
      throw Exception('Unauthorized');
    } else {
      print(res.body);
      throw Exception('Failed to load tutors');
    }
  }

  static Future<TutorMoreResponse> searchTutors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokens = prefs.getString('tokens');
    TokenModel tokenModel = TokenModel.fromJson(jsonDecode(tokens!));
    print(SearchRequestPayload(
            filters: Filters(
              specialties: FilterProvider.specialties != null
                  ? [FilterProvider.specialties!.key!]
                  : null,
            ),
            page: '1',
            perPage: 9,
            search: FilterProvider.search)
        .toJson());
    var res = await http.post(Uri.parse("${URL}search"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'authorization': 'Bearer ${tokenModel.access?.token}',
        },
        body: jsonEncode(SearchRequestPayload(
                filters: Filters(
                  specialties: FilterProvider.specialties != null
                      ? [FilterProvider.specialties!.key!]
                      : null,
                ),
                page: '1',
                perPage: 9,
                search: FilterProvider.search)
            .toJson()));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      try {
        var tutorsResponse = Tutors.fromJson(data);
        print(tutorsResponse.rows!.length);
        TutorMoreResponse tutorMoreResponse =
            TutorMoreResponse(tutors: tutorsResponse);
        return tutorMoreResponse;
      } catch (e) {
        print(e);
        return throw Exception('Failed to load tutors');
      }
    } else if (res.statusCode == 401) {
      prefs.remove("tokens");
      prefs.remove("user");
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load tutors');
    }
  }
}
