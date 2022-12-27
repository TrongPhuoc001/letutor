import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

Widget SocialProvider() {
  return Column(
    children: [
      const Text('Hoặc tiếp tục với'),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/facebook-logo.png'),
            iconSize: 30,
          ),
          IconButton(
            onPressed: pressGoogle,
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

void pressGoogle() async {
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
  } catch (error) {
    print(error);
  }
}
