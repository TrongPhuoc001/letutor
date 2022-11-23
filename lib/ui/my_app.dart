import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/user.dart';
import 'package:provider/provider.dart';
import 'login/login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        theme: ThemeData(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        home: Login(),
      ),
    );
  }
}

class UserProvider extends ChangeNotifier {
  User? user;
  TokenModel? tokens;

  void login(User user, TokenModel tokens) {
    this.user = user;
    this.tokens = tokens;
    notifyListeners();
  }

  void logout() {
    this.user = null;
    this.tokens = null;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  User get currentUser => user!;

  String? get accessToken => tokens!.access!.token;
}
