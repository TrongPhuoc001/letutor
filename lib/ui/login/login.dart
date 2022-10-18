import 'package:flutter/material.dart';
import 'package:lettutor/constants/assets.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/login/widgets/login_form.dart';
import 'package:lettutor/ui/login/widgets/login_instruction.dart';
import 'package:lettutor/ui/login/widgets/social_provider.dart';

import '../my_app.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return mainTheme(
      showMenu: false,
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Image.asset(Assets.loginBanner),
                  LoginInstruction(),
                  LoginForm(context),
                  SocialProvider(),
                  Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Bạn chưa có tài khoản?'),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Đăng ký'),
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
