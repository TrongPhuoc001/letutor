import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget LoginInstruction({type = "login"}) {
  return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: Text(type == "login" ? 'Đăng nhập' : 'Đăng ký',
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.bold)),
        ),
        Text(
          'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
          style: TextStyle(fontSize: 16, color: Colors.grey[900]),
          textAlign: TextAlign.center,
        ),
      ]));
}
