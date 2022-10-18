import 'package:flutter/material.dart';
import 'package:lettutor/themes/main_theme.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            gapPadding: 0),
                      ),
                    )),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: () {},
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
