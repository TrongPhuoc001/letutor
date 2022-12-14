import 'package:flutter/material.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../../model/schedule_model.dart';
import '../../../widgets/common/button/round_button_outlined.dart';

Widget ScheduleHistoryItem(Schedule scheduleItem) {
  return Container(
    padding: const EdgeInsets.all(10),
    margin: EdgeInsets.only(top: 20),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Thời gian bài học: 18:00 - 18:25",
                    style: TextStyle(fontSize: 18),
                  ),
                  Row(
                    children: [
                      RoundButtonOutLined(
                          child: Row(
                            children: const [
                              Icon(
                                Icons.video_library,
                                color: Colors.blue,
                              ),
                              Text(
                                'Bản ghi',
                                style: TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                          round: 0,
                          color: Colors.blue)
                    ],
                  )
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
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Yêu cầu cho buổi học",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Đánh giá cho buổi học",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, child: Text("Đánh giá")),
                      TextButton(onPressed: () {}, child: Text("Báo cáo")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
  );
}
