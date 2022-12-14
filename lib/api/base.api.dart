import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/token_model.dart';

class BaseApi {
  static TokenModel tokenModel = TokenModel();
  static String URL = 'https://sandbox.api.lettutor.com/';

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'authorization': 'Bearer ${tokenModel.access?.token}',
  };

  static get(String url) {
    return http.get(Uri.parse(URL + url), headers: headers);
  }

  static post(String url, dynamic data) {
    return http.post(Uri.parse(URL + url),
        headers: headers, body: jsonEncode(data));
  }

  static put(String url, dynamic data) {
    return http.put(Uri.parse(URL + url),
        headers: headers, body: jsonEncode(data));
  }
}
