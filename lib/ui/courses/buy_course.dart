import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/themes/main_theme.dart';

class BuyCourses extends StatelessWidget {
  const BuyCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainTheme(
      context: context,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Mua khóa học",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  )),
              const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Chọn khoá học phù hợp nhất và bắt đầu cải thiện tiếng Anh của bạn ngay hôm nay!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Đặt lịch hàng tuần"),
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: const Center(
                          child: Text("1 buổi học mỗi ngày",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white)))),
                  const Text("Mỗi buổi học 25 phút"),
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      child: const Center(
                          child: Text("3 ngày mỗi tuần",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white)))),
                  const Text("Thời gian khoá học"),
                  Row(
                    children: [
                      Expanded(
                          child: TimeButton(text: "1 tháng", isSelected: true)),
                      Expanded(child: TimeButton(text: "3 tháng")),
                      Expanded(child: TimeButton(text: "6 tháng")),
                      Expanded(child: TimeButton(text: "12 tháng")),
                    ],
                  ),
                  const Text("Mã khuyến mãi"),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                        ),
                      )),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(5)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                          child: const Center(
                              child: Text("Áp dụng",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)))),
                    ],
                  ),
                  const Divider(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "1.200.000 ₫",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.greenAccent),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              fixedSize: MaterialStateProperty.all(const Size(
                                  double.infinity, double.infinity))),
                          child: const Text("Thanh toán",
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white))))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

Widget TimeButton({text, isSelected = false}) {
  return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(isSelected ? Colors.blue : Colors.white),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
      child: Center(
          child: Text(text,
              style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black))));
}
