import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/themes/main_theme.dart';

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
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.blue, width: 7))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(user.avatar),
                              ),
                            ),
                          ),
                          Text(user.name, style: TextStyle(fontSize: 20)),
                          Text(
                            "ID: ${user.id}",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text("Người khác đánh giá bạn"))
                        ]),
                      )
                    ],
                  ))),
        ));
  }
}
