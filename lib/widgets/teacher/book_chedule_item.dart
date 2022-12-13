import 'package:flutter/material.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:intl/intl.dart';

import '../common/box_shadow_container.dart';
import '../common/button/loading_button.dart';

class BookingScheduleItem extends StatelessWidget {
  String date = '';
  String time = '';
  bool isDisable = false;
  bool isBooked = false;

  final ScheduleOfTutor element;

  BookingScheduleItem({
    Key? key,
    required this.element,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isDisable = isBeforeNow(element.startTimestamp!);
    date = readTimestamp(element.startTimestamp!);
    time = '${element.startTime} - ${element.endTime}';
    isBooked = element.isBooked!;

    return BoxShadowContainer(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              width: 100,
              height: 30,
              child: LoadingButtonWidget(
                  isDisable: isDisable,
                  submit: () {},
                  isLoading: false,
                  primaryColor: isBooked ? Colors.green : null,
                  label: isBooked ? "Đã đặt" : "Đặt lịch"),
            )
          ],
        ));
  }
}

String readTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return '${DateFormat('dd/MM/yyyy').format(date)}-${weekDay[date.weekday]!}';
}

bool isBeforeNow(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return date.isBefore(DateTime.now());
}

final weekDay = {
  1: 'T2',
  2: 'T3',
  3: 'T4',
  4: 'T5',
  5: 'T6',
  6: 'T7',
  7: 'CN',
};
