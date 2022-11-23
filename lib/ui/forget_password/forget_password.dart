import 'package:flutter/material.dart';
import 'package:lettutor/api/auth/auth.api.dart';
import 'package:lettutor/themes/main_theme.dart';

import '../../api/user/user.api.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();
  String message = '';
  var msgColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      context: context,
      hideMenu: true,
      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    'Đặt lại mật khẩu',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'Vui lòng nhập email để tìm kiếm tài khoản của bạn.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const Text(
                  'EMAIL',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gapPadding: 0),
                      ),
                      controller: emailController,
                    )),
                Text(
                  message,
                  style: TextStyle(color: msgColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () async {
                        var email = emailController.text;
                        if (!email.contains('@')) {
                          setState(() {
                            message = 'Email không hợp lệ';
                            msgColor = Colors.red;
                          });
                          return;
                        }
                        try {
                          await UserApi.forgotPassword(emailController.text);
                          setState(() {
                            message =
                                'Vui lòng kiểm tra email để đặt lại mật khẩu';
                            msgColor = Colors.blue;
                          });
                        } catch (err) {
                          setState(() {
                            message = "Gửi mail không thành công.";
                            msgColor = Colors.red;
                          });
                        }
                      },
                      child: const Text('Xác nhận',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ))
                  ],
                ),
              ])),
    );
  }
}
