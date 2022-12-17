import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/constants/specialty.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/user.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          String? userData = snapshot.data!.getString("user");
          String? tokensData = snapshot.data!.getString("tokens");
          User? user;
          TokenModel? tokens;
          if (userData != null && tokensData != null) {
            user = User.fromJson(jsonDecode(userData));
            tokens = TokenModel.fromJson(jsonDecode(tokensData));
            if (tokens.access != null && tokens.access!.expires != null) {
              String accessExpries = tokens.access!.expires!;
              if (DateTime.parse(accessExpries).isBefore(DateTime.now())) {
                user = null;
                tokens = null;
              }
            }
          } else {
            user = null;
            tokens = null;
          }
          BaseApi.tokenModel = tokens ?? TokenModel();

          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                    create: (context) =>
                        UserProvider(user: user, tokens: tokens)),
                ChangeNotifierProvider(create: (_) => FilterProvider()),
                Provider<SharedPreferences>.value(value: snapshot.data!)
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    textTheme: GoogleFonts.poppinsTextTheme(
                        Theme.of(context).textTheme)),
                home: user != null ? const FindTeacher() : const Login(),
              ));
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? user;
  TokenModel? tokens;
  UserProvider({this.user, this.tokens});

  void login(User user, TokenModel tokens) {
    this.user = user;
    this.tokens = tokens;
    BaseApi.tokenModel = tokens;
    notifyListeners();
  }

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void logout() async {
    this.user = null;
    this.tokens = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("tokens");
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  User get currentUser => user!;

  String? get accessToken => tokens!.access!.token;
}

class FilterProvider extends ChangeNotifier {
  static TextEditingController searchController = TextEditingController();
  static String? nation;
  static DateTime? date;
  static DateTimeRange? time;
  static Specialty? specialties;

  void updateSearch() {
    notifyListeners();
  }

  void updateNation(String? nation) {
    FilterProvider.nation = nation;
    notifyListeners();
  }

  void updateDate(DateTime? date) {
    FilterProvider.date = date;
    notifyListeners();
  }

  void updateTime(DateTimeRange? time) {
    FilterProvider.time = time;
    notifyListeners();
  }

  void updateSpecialties(Specialty? specialties) {
    FilterProvider.specialties = specialties;
    notifyListeners();
  }

  getSearchController() {
    return FilterProvider.searchController;
  }

  void clear() {
    FilterProvider.searchController.text = '';
    FilterProvider.nation = null;
    FilterProvider.date = null;
    FilterProvider.time = null;
    FilterProvider.specialties = null;
    notifyListeners();
  }
}
