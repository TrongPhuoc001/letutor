import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/google-logo.png'),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/mobile-logo.png'),
          ),
        ],
      ),
    ],
  );
}
