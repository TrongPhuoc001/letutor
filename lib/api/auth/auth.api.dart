import 'dart:convert';

import 'package:lettutor/model/token_model.dart';
import 'package:http/http.dart' as http;

import '../../model/user.dart';

class LoginResponse {
  User? user;
  TokenModel? tokens;

  LoginResponse({this.user, this.tokens});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    tokens =
        json['tokens'] != null ? new TokenModel.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }
}

class AuthApi {
  static String URL = 'https://sandbox.api.lettutor.com/auth/';

  static Future<LoginResponse> normalLogin(
      String email, String password) async {
    var response = await http.post(Uri.parse(URL + 'login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }

  static Future<LoginResponse> googleLogin(String googleToken) async {
    var response = await http.post(Uri.parse(URL + 'google'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'access_token': googleToken,
        }));
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  }

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

  static Future<LoginResponse> register(String email, String password) {
    return http
        .post(Uri.parse(URL + 'register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'email': email,
              'password': password,
              "source": null
            }))
        .then((response) {
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(jsonDecode(response.body));
      } else {
        String message = jsonDecode(response.body)['message'];
        throw message;
      }
    });
  }
}
