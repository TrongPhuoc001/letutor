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

class CategoryResponse {
  int? count;
  List<Category>? rows;

  CategoryResponse({this.count, this.rows});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Category>[];
      json['rows'].forEach((v) {
        rows!.add(new Category.fromJson(v));
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

class Category {
  String? id;
  String? title;
  String? description;
  String? key;
  String? displayOrder;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.title,
      this.description,
      this.key,
      this.displayOrder,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['key'] = this.key;
    data['displayOrder'] = this.displayOrder;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class CourseApi {
  static String URL = "course/";

  static Future<CourseListResponse> getCourseList(
      int page, int limit, String type,
      {dynamic filter}) async {
    String url = type + "?page=$page&size=$limit";
    if (filter != null) {
      if (filter['categories'] != null && filter['categories'].length > 0) {
        filter['categories'].forEach((cate) {
          url += "&categoryId[]=$cate";
        });
      }
      if (filter['levels'] != null && filter['levels'].length > 0) {
        filter['levels'].forEach((level) {
          url += "&level[]=$level";
        });
      }
      if (filter['sort'] != null && filter['sort'].length > 0) {
        url += "&order[]=level&orderBy[]=${filter['sort']}";
      }
      if (filter['search'] != null && filter['search'].length > 0) {
        url += "&q=${filter['search']}";
      }
    }
    var response = await BaseApi.get(url);
    if (response.statusCode == 200) {
      return CourseListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course list');
    }
  }

  static Future<CategoryResponse> getCategories() async {
    var response = await BaseApi.get("content-category");
    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
