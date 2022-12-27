import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/model/user.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:http_parser/http_parser.dart';

class UserApi {
  static String URL = 'https://sandbox.api.lettutor.com/user/';

  static Future<String> forgotPassword(String email) async {
    var res = await http.post(Uri.parse(URL + 'forgotPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }));
    if (res.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Failed to send email');
    }
  }

  static Future<User> updateUser(
      {name, country, birthday, level, learnTopics, testPreparations}) async {
    try {
      var res = await BaseApi.put("user/info", {
        'name': name,
        'country': country,
        'birthday': birthday,
        'level': level,
        'learnTopics': learnTopics,
        'testPreparations': testPreparations
      });
      if (res.statusCode == 200) {
        try {
          User u = User.fromJson(jsonDecode(res.body)['user']);
          return u;
        } catch (err) {
          print(err);
          throw Exception('Failed to update user');
        }
      } else {
        throw Exception('Failed to update user');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to update user');
    }
  }

  static Future<dynamic> manageFavoriteTutor(String tutorId) async {
    String url = 'user/manageFavoriteTutor';

    try {
      var res = await BaseApi.post(url, {'tutorId': tutorId});
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception('Failed to manage favorite tutor');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to manage favorite tutor');
    }
  }

  static Future<Map<String, dynamic>> uploadAvatar(dynamic bytes) async {
    String url = 'user/uploadAvatar';

    try {
      StreamedResponse resStream = await BaseApi.postFormData(
          url,
          http.MultipartFile.fromBytes('avatar', bytes,
              filename: 'avatar.png', contentType: MediaType('image', 'png')));
      var res = await http.Response.fromStream(resStream);
      if (res.statusCode == 200) {
        try {
          Map<String, dynamic> u = jsonDecode(res.body);
          return u;
        } catch (err) {
          print(err);
          throw Exception('Failed to upload avatar');
        }
      } else {
        Map<String, dynamic> u = jsonDecode(res.body);
        throw u['message'];
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
