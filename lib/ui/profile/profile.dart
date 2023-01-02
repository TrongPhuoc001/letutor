import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lettutor/api/base.api.dart';
import 'package:lettutor/api/user/user.api.dart';
import 'package:lettutor/constants/countries.dart';
import 'package:lettutor/constants/languages.dart';
import 'package:lettutor/constants/level_user.dart';
import 'package:lettutor/constants/specialty.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/profile/widget/want_to_learn.dart';
import 'package:lettutor/widgets/lable_text_field.dart';
import 'package:lettutor/widgets/multi_select_dialog.dart';
import 'package:lettutor/widgets/notification.dart';
import 'package:lettutor/widgets/round_text_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user.dart';
import '../my_app.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user});
  final User user;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final Map<String, TextEditingController> controllers = Map.fromEntries(
    [
      "name",
      "email",
      "country",
      "phone",
      "birthday",
      "level",
      "subject",
      "schedule",
    ].map(
      (value) => MapEntry(
        value,
        TextEditingController(),
      ),
    ),
  );

  String avatar = '';

  List<LearnTopics> learnTopics = [];
  List<LearnTopics> testPreparation = [];

  List<int> _selected_learnTopics = [];
  List<int> _selected_testPreparation = [];

  void getLearnTopics() async {
    var resLearnTopic = await BaseApi.get('learn-topic');
    var resTestPrepare = await BaseApi.get('test-preparation');
    List<dynamic> learnTopicsMap = jsonDecode(resLearnTopic.body);
    List<dynamic> testPreparationMap = jsonDecode(resTestPrepare.body);

    List<LearnTopics> learnTopicsList = [];
    learnTopicsMap.forEach((value) {
      learnTopicsList.add(LearnTopics.fromJson(value));
    });
    List<LearnTopics> testPreparationList = [];
    testPreparationMap.forEach((value) {
      testPreparationList.add(LearnTopics.fromJson(value));
    });
    setState(() {
      learnTopics = learnTopicsList;
      testPreparation = testPreparationList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avatar = widget.user.avatar!;
    controllers["name"]!.text = widget.user.name ?? '';
    controllers["email"]!.text = widget.user.email ?? '';
    controllers["country"]!.text = widget.user.country ?? '';
    controllers["phone"]!.text = widget.user.phone ?? '';
    controllers["birthday"]!.text = widget.user.birthday ?? '';
    controllers["level"]!.text = widget.user.level ?? '';
    controllers["schedule"]!.text = widget.user.avatar ?? '';
    _selected_learnTopics =
        widget.user.learnTopics!.map((e) => e.id!).toList() ?? [];
    _selected_testPreparation =
        widget.user.testPreparations!.map((e) => e.id!).toList() ?? [];
    getLearnTopics();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs = Provider.of<SharedPreferences>(context);
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
                          InkWell(
                            onTap: () async {
                              ImagePicker _picker = ImagePicker();
                              XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                try {
                                  var bytes = await image.readAsBytes();
                                  Map<String, dynamic> userResponse =
                                      await UserApi.uploadAvatar(bytes);
                                  User user =
                                      context.read<UserProvider>().currentUser;
                                  user.avatar = userResponse["avatar"];
                                  context.read<UserProvider>().setUser(user);
                                  prefs.setString("user", jsonEncode(user));
                                  setState(() {
                                    avatar = userResponse["avatar"];
                                  });
                                } catch (err) {
                                  print(err);
                                  notification(
                                      context: context,
                                      message: err.toString(),
                                      color: Colors.red);
                                }
                              } else {
                                print('No image selected.');
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(avatar),
                                ),
                              ),
                            ),
                          ),
                          Text(widget.user.name!,
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            "ID: ${widget.user.id}",
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
                                round: 5.0, controller: controllers["name"]),
                          ),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Địa chỉ email",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: widget.user.email,
                                  round: 5.0,
                                  enabled: false,
                                  controller: controllers["email"])),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Quốc gia",
                              isImportant: true,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                value: controllers["country"]?.text,
                                items: COUNTRIES.entries.map((entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    controllers["country"]!.text =
                                        value.toString();
                                  });
                                },
                              )),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Số điện thoại",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: widget.user.phone,
                                  round: 5.0,
                                  enabled: false,
                                  controller: controllers["phone"])),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Ngày sinh",
                              isImportant: true,
                              child: RoundTextField(
                                  initValue: widget.user.birthday,
                                  isReadOnly: true,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.parse(
                                                controllers['birthday']!.text),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100))
                                        .then((value) {
                                      if (value != null) {
                                        setState(() {
                                          controllers['birthday']!.text =
                                              value.toString().split(" ")[0];
                                        });
                                      }
                                    });
                                  },
                                  round: 5.0,
                                  controller: controllers['birthday'])),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Trình độ",
                              isImportant: true,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                value: controllers["level"]!.text,
                                items: LEVELS_USER.entries.map((entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    controllers["level"]!.text =
                                        value.toString();
                                  });
                                },
                              )),
                          const SizedBox(height: 15),
                          LabelTextField(
                              title: "Muốn học",
                              isImportant: true,
                              child: Container()),
                          MultiSelectDialog(
                            items: learnTopics,
                            selectedItems: _selected_learnTopics,
                            title: "Subject",
                            onChanged: (value) {
                              setState(() {
                                _selected_learnTopics = value;
                              });
                            },
                          ),
                          MultiSelectDialog(
                              items: testPreparation,
                              selectedItems: _selected_testPreparation,
                              title: "Luyện thi",
                              onChanged: (value) {
                                setState(() {
                                  _selected_testPreparation = value;
                                });
                              }),
                          const SizedBox(height: 15),
                          //
                          LabelTextField(
                              title: "Lịch học",
                              isImportant: true,
                              child: RoundTextField(
                                  round: 5,
                                  hintText:
                                      "Ghi chú thời gian trong tuần mà bạn muốn học trên LetTutor",
                                  controller: controllers["schedule"])),
                          const SizedBox(height: 15),
                          //
                          Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                  height: 40,
                                  width: 130,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      UserApi.updateUser(
                                        name: controllers["name"]!.text,
                                        country: controllers["country"]!.text,
                                        birthday: controllers["birthday"]!.text,
                                        level: controllers["level"]!.text,
                                        learnTopics: _selected_learnTopics
                                            .map((e) => e.toString())
                                            .toList(),
                                        testPreparations:
                                            _selected_testPreparation
                                                .map((e) => e.toString())
                                                .toList(),
                                      ).then((value) {
                                        prefs.setString(
                                            "user", jsonEncode(value.toJson()));
                                        Provider.of<UserProvider>(context,
                                                listen: false)
                                            .setUser(value);
                                        notification(
                                            context: context,
                                            message: "Cập nhật thành công");
                                      }).catchError((error) => notification(
                                          context: context,
                                          message: error.toString()));
                                    },
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
