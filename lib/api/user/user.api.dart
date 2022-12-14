import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/model/user.dart';
import 'package:lettutor/ui/my_app.dart';

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

  static Future<User> updateUser({name, country, birthday, level}) async {
    try {
      var res = await BaseApi.put("user/info", {
        'name': name,
        'country': country,
        'birthday': birthday,
        'level': level,
      });
      if (res.statusCode == 200) {
        print(jsonDecode(res.body));
        try {
          User u = User.fromJson(jsonDecode(res.body));
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
}
