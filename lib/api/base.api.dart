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
    headers['authorization'] = 'Bearer ${tokenModel.access?.token}';
    return http.get(Uri.parse(URL + url), headers: headers);
  }

  static post(String url, dynamic data) {
    headers['authorization'] = 'Bearer ${tokenModel.access?.token}';
    return http.post(Uri.parse(URL + url),
        headers: headers, body: jsonEncode(data));
  }

  static postFormData(String url, dynamic data) {
    headers['authorization'] = 'Bearer ${tokenModel.access?.token}';
    Map<String, String> newHeader = BaseApi.headers;
    newHeader['Content-Type'] = 'multipart/form-data';
    var request = http.MultipartRequest('POST', Uri.parse(URL + url));
    request.headers.addAll(newHeader);
    request.files.add(data);
    return request.send();
  }

  static put(String url, dynamic data) {
    headers['authorization'] = 'Bearer ${tokenModel.access?.token}';
    return http.put(Uri.parse(URL + url),
        headers: headers, body: jsonEncode(data));
  }
}
