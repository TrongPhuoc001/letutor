import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/widgets/lable_text_field.dart';
import 'package:lettutor/widgets/round_text_field.dart';

import '../../model/user.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MainTheme(
        context: context,
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            width: double.infinity,
            child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                      color: Color.fromARGB(179, 233, 231, 231), width: 1),
                ),
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.blue, width: 7))),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(user.avatar!),
                              ),
                            ),
                          ),
                          Text(user.name!,
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            "ID: ${user.id}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text("Người khác đánh giá bạn"))
                        ]),
                      ),
                      const Text("Tài khoản"),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 25.0),
                        child: Column(children: [
                          LabelTextField(
                              title: "Tên",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.name, round: 5.0)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Địa chỉ email",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.email,
                                  round: 5.0,
                                  enabled: false)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Quốc gia",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.country, round: 5.0)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Số điện thoại",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.phone,
                                  round: 5.0,
                                  enabled: false)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Ngày sinh",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.birthday, round: 5.0)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Trình độ",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.level, round: 5.0)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Muốn học",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: user.learnTopics![0].name,
                                  round: 5.0)),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Lịch học",
                              isImportant: true,
                              child: RoundTextField(
                                  round: 5,
                                  hintText:
                                      "Ghi chú thời gian trong tuần mà bạn muốn học trên LetTutor")),
                          const SizedBox(height: 15),
                          //
                          Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                  height: 40,
                                  width: 130,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Lưu thay đổi"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ))),
                        ]),
                      )
                    ])))));
  }
}
