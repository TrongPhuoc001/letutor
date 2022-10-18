import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/themes/main_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainTheme(
        context: context,
        child: Column(
            children: [Banner(courseNumber: 0, totalLearned: 9275), Fliter()]));
  }
}

Widget Banner({courseNumber, totalLearned}) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 150,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: const GradientRotation(0.5),
        colors: [
          const Color.fromRGBO(12, 61, 223, 1)!,
          const Color.fromRGBO(5, 23, 157, 1)!,
        ],
      ),
    ),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        courseNumber == 0
            ? const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("Bạn không có buổi học nào.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("Bạn có $courseNumber buổi học .",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
        Text(
          "Tổng số giờ bạn đã học là ${(totalLearned / 60).floor()} giờ ${totalLearned - (totalLearned / 60).floor()} phút",
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

Widget RoundTextField({hintText}) {
  return TextField(
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gapPadding: 0,
          borderSide: BorderSide(color: Color.fromRGBO(233, 233, 233, 1))),
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromRGBO(215, 215, 215, 1),
          fontSize: 14,
          fontWeight: FontWeight.w500),
    ),
  );
}

Widget RoundButon({text, onPressed}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: Text(text, style: const TextStyle(color: Colors.grey)),
  );
}

Widget RoundButtonOutLined({text, onPressed}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      side: BorderSide(width: 1.0, color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
    ),
    child: Text(text, style: const TextStyle(color: Colors.blue)),
  );
}

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
    padding: const EdgeInsets.fromLTRB(20, 30, 30, 30),
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
