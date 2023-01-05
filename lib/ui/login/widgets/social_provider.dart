import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lettutor/api/auth/auth.api.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../my_app.dart';
import '../../teacher/find_teacher.dart';

class SocialProvider extends StatelessWidget {
  void pressGoogle({required BuildContext context}) async {
    SharedPreferences prefs =
        Provider.of<SharedPreferences>(context, listen: false);
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return;
      }
      final data = await googleSignInAccount.authentication;
      print(data.accessToken);
      LoginResponse loginResponse =
          await AuthApi.googleLogin(data.accessToken!);
      context
          .read<UserProvider>()
          .login(loginResponse.user!, loginResponse.tokens!);
      prefs.setString("tokens", jsonEncode(loginResponse.tokens!.toJson()));
      prefs.setString("user", jsonEncode(loginResponse.user!.toJson()));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FindTeacher()));
    } catch (error) {
      print(error);
    }
  }

  void pressFacebook({context}) async {
    try {
      final fb = FacebookLogin();

// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

// Check result status
      switch (res.status) {
        case FacebookLoginStatus.success:
          // Logged in

          // Send access token to server for validation and auth
          final FacebookAccessToken? accessToken = res.accessToken;
          print('Access token: ${accessToken?.token}');
          SharedPreferences prefs =
              Provider.of<SharedPreferences>(context, listen: false);
          LoginResponse loginResponse =
              await AuthApi.facebookLogin(accessToken!.token);
          context
              .read<UserProvider>()
              .login(loginResponse.user!, loginResponse.tokens!);
          prefs.setString("tokens", jsonEncode(loginResponse.tokens!.toJson()));
          prefs.setString("user", jsonEncode(loginResponse.user!.toJson()));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const FindTeacher()));

          break;
        case FacebookLoginStatus.cancel:
          // User cancel log in
          break;
        case FacebookLoginStatus.error:
          // Log in failed
          print('Error while log in: ${res.error}');
          break;
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const Text('Hoặc tiếp tục với'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                pressFacebook(context: context);
              },
              icon: Image.asset('assets/icons/facebook-logo.png'),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {
                pressGoogle(context: context);
              },
              icon: Image.asset('assets/icons/google-logo.png'),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/mobile-logo.png'),
              iconSize: 30,
            ),
          ],
        ),
      ],
    );
  }
}
