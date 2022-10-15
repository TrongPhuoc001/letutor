import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/themes/main_theme.dart';

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
            const Text('Login'),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyApp();
                }));
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
