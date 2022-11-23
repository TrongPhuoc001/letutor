import 'dart:convert';

import '../../model/tutor.dart';
import 'package:http/http.dart' as http;

class TutorApi {
  String URL = 'https://sandbox.api.lettutor.com/tutor/';

  Future<List<Tutor>> getTutors() async {
    var res = await http.get(Uri.parse(URL + 'tutors'));
    if (res.statusCode == 200) {
      var tutors = jsonDecode(res.body) as List;
      return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
    } else {
      throw Exception('Failed to load tutors');
    }
  }
}
