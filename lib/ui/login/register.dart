import 'package:flutter/material.dart';
import 'package:lettutor/constants/assets.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/login/login.dart';
import 'package:lettutor/ui/login/widgets/login_form.dart';
import 'package:lettutor/ui/login/widgets/login_instruction.dart';
import 'package:lettutor/ui/login/widgets/social_provider.dart';

import '../my_app.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      hideMenu: true,
      context: context,
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(Assets.loginBanner),
                  LoginInstruction(type: "register"),
                  LoginForm(type: "register"),
                  SocialProvider(),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bạn đã có tài khoản?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Login()));
                        },
                        child: const Text('Đăng nhập'),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
