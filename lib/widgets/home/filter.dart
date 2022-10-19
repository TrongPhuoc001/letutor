import 'package:flutter/material.dart';
import 'package:lettutor/widgets/round_text_field.dart';

import '../round_button.dart';
import '../round_button_outlined.dart';

Widget Fliter() {
  List<String> option = [
    "Tất cả",
    "Tiếng Anh cho trẻ em",
    "Tiếng Anh cho công việc",
    "Giao tiếp",
    "STARTERS",
    "MOVERS",
    "FLYERS",
    "KET",
    "PET",
    "IELTS",
    "TOEFL",
    "TOEIC"
  ];
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 30, 30, 10),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text("Tìm kiếm gia sư",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: RoundTextField(hintText: "Nhập tên gia sư...")),
              Expanded(
                  child: RoundTextField(hintText: "Chọn quốc tịch gia sư")),
            ],
          )),
      const Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
        child: Text(
          "Chọn thời gian dạy kèm có lịch trống:",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(child: RoundTextField(hintText: "Chọn ngày")),
              Expanded(child: RoundTextField(hintText: "Chọn giờ")),
            ],
          )),
      Container(
        child: Wrap(
          children:
              option.map((e) => RoundButon(text: e, onPressed: () {})).toList(),
        ),
      ),
      RoundButtonOutLined(text: "Đặt lại bộ tìm kiếm", onPressed: () {})
    ]),
  );
}
