import 'package:flutter/material.dart';
import 'package:lettutor/model/schedule_model.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../../widgets/common/button/round_button_outlined.dart';

Widget ScheduleItem(Schedule scheduleItem) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: const Color.fromRGBO(241, 241, 241, 1),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "T6, 21 Thg 10 22",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text("1 buổi học"),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            color: Colors.white,
            child: TeacherShortInfo(
                scheduleItem.scheduleDetailInfo!.scheduleInfo!.tutorInfo!,
                contact: true),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            color: Colors.white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("18:00 - 18:25", style: TextStyle(fontSize: 18)),
                  RoundButtonOutLined(
                      child: Row(
                        children: const [
                          Icon(
                            Icons.cancel_presentation,
                            color: Colors.red,
                          ),
                          Text(
                            'Hủy',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      round: 0,
                      color: Colors.red)
                ],
              ),
            ]),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.expand_more,
                        size: 15,
                      ),
                      const Text(
                        "Yêu cầu cho buổi học",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Chỉnh sửa yêu cầu",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "ABCD",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Vào buổi học'),
              )
            ],
          )
        ]),
  );
}
