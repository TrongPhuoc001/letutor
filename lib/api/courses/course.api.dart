import 'dart:convert';

import 'package:lettutor/model/course_model.dart';

import '../base.api.dart';

class CourseListResponse {
  String? message;
  Data? data;

  CourseListResponse({this.message, this.data});

  CourseListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? count;
  List<CourseModel>? rows;

  Data({this.count, this.rows});

  Data.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <CourseModel>[];
      json['rows'].forEach((v) {
        rows!.add(new CourseModel.fromJson(v));
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

class CourseApi {
  static String URL = "course/";

  static Future<CourseListResponse> getCourseList(
      int page, int limit, String type) async {
    var response = await BaseApi.get(type + "?page=$page&size=$limit");
    if (response.statusCode == 200) {
      return CourseListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }
}
