import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lettutor/api/auth/auth.api.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/user.dart';
import 'package:lettutor/ui/forget_password/forget_password.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  var type;

  LoginForm({required this.type, super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = Provider.of<SharedPreferences>(context);
    String? token = prefs.getString("tokens");
    String? user = prefs.getString("user");
    if (token != null && user != null) {
      context.read<UserProvider>().login(User.fromJson(jsonDecode(user)),
          TokenModel.fromJson(jsonDecode(token)));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FindTeacher()));
    }

    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'ĐỊA CHỈ EMAIL',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gapPadding: 0),
                  hintText: 'mail@example.com',
                ),
                controller: emailController,
              )),
          const Text(
            'MẬT KHẨU',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.left,
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
              )),
          widget.type == "login"
              ? TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPassword()));
                  },
                  child: const Text('Quên mật khẩu?'))
              : SizedBox(),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () async {
                  if (widget.type == "login") {
                    try {
                      LoginResponse loginResponse = await AuthApi.normalLogin(
                          emailController.text, passwordController.text);
                      context
                          .read<UserProvider>()
                          .login(loginResponse.user!, loginResponse.tokens!);
                      prefs.setString(
                          "tokens", jsonEncode(loginResponse.tokens!.toJson()));
                      prefs.setString(
                          "user", jsonEncode(loginResponse.user!.toJson()));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FindTeacher()));
                    } catch (err) {
                      print(err);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Đăng nhập thất bại")));
                    }
                    ;
                  }
                },
                child: Text(widget.type == "login" ? 'Đăng nhập' : 'Đăng ký',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ))
            ],
          ),
        ]));
  }
}
