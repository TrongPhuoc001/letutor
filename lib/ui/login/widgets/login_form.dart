import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/ui/forget_password/forget_password.dart';
import 'package:lettutor/ui/teacher/find_teacher.dart';

import '../../my_app.dart';

Widget LoginForm(context) {
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
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    gapPadding: 0),
                hintText: 'mail@example.com',
              ),
            )),
        const Text(
          'MẬT KHẨU',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.left,
        ),
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            )),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgetPassword()));
            },
            child: const Text('Quên mật khẩu?')),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FindTeacher()));
              },
              child: const Text('Đăng nhập',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ))
          ],
        ),
      ]));
}
