import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lettutor/api/auth/auth.api.dart';
import 'package:lettutor/model/token_model.dart';
import 'package:lettutor/model/user.dart';
import 'package:lettutor/ui/forget_password/forget_password.dart';
import 'package:lettutor/ui/login/login.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';
import 'package:lettutor/widgets/notification.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gapPadding: 0),
                  hintText: 'mail@example.com',
                ),
                validator: (value) {
                  if (value == null) {
                    return null;
                  }

                  if (!isEmail(value)) {
                    return 'Email bạn nhập không phù hợp';
                  }
                  return null;
                },
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                validator: (value) {
                  if (value == null) {
                    return null;
                  }

                  if (value.length < 6) {
                    return 'Mật khẩu quá ngắn';
                  }
                  return null;
                },
              )),
          widget.type == "login"
              ? TextButton(
                  onPressed: () async {
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
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Đăng nhập thất bại. " + err.toString()),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                      ));
                    }
                    ;
                  } else {
                    try {
                      await AuthApi.register(
                          emailController.text, passwordController.text);
                      notification(
                          context: context,
                          message:
                              "Đăng ký thành công. Kiểm tra email để kích hoạt tài khoản.",
                          color: Colors.green);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    } catch (err) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Đăng ký thất bại. " + err.toString()),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 100,
                            right: 20,
                            left: 20),
                      ));
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
