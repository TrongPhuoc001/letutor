import 'dart:convert';

import 'package:http/http.dart' as http;

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
    print(res.body);
    if (res.statusCode == 200) {
      return 'Success';
    } else {
      throw Exception('Failed to send email');
    }
  }
}
