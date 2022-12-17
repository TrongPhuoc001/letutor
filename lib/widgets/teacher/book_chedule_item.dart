import 'package:flutter/material.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/widgets/notification.dart';

import '../common/box_shadow_container.dart';
import '../common/button/loading_button.dart';

class BookingScheduleItem extends StatefulWidget {
  final ScheduleOfTutor element;

  BookingScheduleItem({
    Key? key,
    required this.element,
  }) : super(key: key);

  @override
  State<BookingScheduleItem> createState() => _BookingScheduleItemState();
}

class _BookingScheduleItemState extends State<BookingScheduleItem> {
  String date = '';

  String time = '';

  bool isDisable = false;

  bool isBooked = false;

  TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDisable = isBeforeNow(widget.element.startTimestamp!);
    DateTime startDatetime =
        DateTime.fromMillisecondsSinceEpoch(widget.element.startTimestamp!);
    DateTime endDatetime =
        DateTime.fromMillisecondsSinceEpoch(widget.element.endTimestamp!);
    date = readTimestamp(widget.element.startTimestamp!);
    time =
        '${startDatetime.hour}:${startDatetime.minute} - ${endDatetime.hour}:${endDatetime.minute}';
    isBooked = widget.element.isBooked!;
  }

  @override
  Widget build(BuildContext context) {
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
                  isDisable: isDisable || isBooked,
                  submit: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: Text("Chi tiết đặt lịch"),
                            contentPadding: EdgeInsets.all(10),
                            content: Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ngày: $date",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Thời gian: $time",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Giá: 1 buổi học",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Divider(),
                                    Text("Notes"),
                                    TextField(
                                      controller: _noteController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                          hintText: "Ghi chú",
                                          border: OutlineInputBorder(
                                              gapPadding: 0,
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                    )
                                  ],
                                )),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Hủy")),
                              TextButton(
                                  onPressed: () async {
                                    try {
                                      var res =
                                          await ScheduleApi.bookingSchedule(
                                              widget.element.scheduleDetails![0]
                                                  .id!,
                                              _noteController.text);
                                      Navigator.pop(context);
                                      setState(() {
                                        isBooked = true;
                                      });
                                      notification(
                                          context: context,
                                          message: res["message"],
                                          color: Colors.green);
                                    } catch (err) {
                                      print(err);
                                      notification(
                                          context: context,
                                          message: err.toString(),
                                          color: Colors.orange);
                                    }
                                  },
                                  child: Text("Đặt lịch"))
                            ],
                          );
                        }));
                  },
                  isLoading: false,
                  primaryColor: isBooked ? Colors.green : null,
                  disablePrimaryColor: isBooked ? Colors.white : null,
                  disableTextColor: isBooked ? Colors.green : null,
                  label: isBooked ? "Đã đặt" : "Đặt lịch"),
            )
          ],
        ));
  }
}

String readTimestamp(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return '${weekDay[date.weekday]!},${DateFormat('dd/MM/yyyy').format(date)}';
}

bool isBeforeNow(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return date.isBefore(DateTime.now());
}

bool isOntheSameDate(int timestamp1, int timestamp2) {
  var date1 = DateTime.fromMillisecondsSinceEpoch(timestamp1);
  var date2 = DateTime.fromMillisecondsSinceEpoch(timestamp2);
  return date1.day == date2.day &&
      date1.month == date2.month &&
      date1.year == date2.year;
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
