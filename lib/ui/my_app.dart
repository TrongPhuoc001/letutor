import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/user.dart';
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
        print(snapshot);
        if (snapshot.hasData && snapshot.data != null) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => UserProvider()),
                Provider<SharedPreferences>.value(value: snapshot.data!)
              ],
              child: MaterialApp(
                theme: ThemeData(
                    textTheme: GoogleFonts.poppinsTextTheme(
                        Theme.of(context).textTheme)),
                home: Login(),
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
