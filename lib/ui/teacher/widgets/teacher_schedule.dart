import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:lettutor/model/tutor.dart';
import 'package:lettutor/model/tutor_short_info.dart';
import 'package:lettutor/widgets/teacher/book_chedule_item.dart';

class TeacherSchedule extends StatefulWidget {
  TeacherSchedule({required TutorShortInfo this.tutor, Key? key})
      : super(key: key);

  TutorShortInfo tutor;

  @override
  _TeacherScheduleState createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  DateTime _selectedDate = DateTime.now();

  List<BookingScheduleItem> renderBookingItem(
      DateTime date, List<ScheduleOfTutor> schedules) {
    return schedules
        .map((e) => BookingScheduleItem(element: e, key: Key(e.id!)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startDate =
        DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    BigInt startTimestamp = BigInt.from(startDate.millisecondsSinceEpoch);
    DateTime _endDate = startDate.add(Duration(days: 1));
    BigInt endTimestamp = BigInt.from(_endDate.millisecondsSinceEpoch);
    return FutureBuilder(
        future: ScheduleApi.getTutorSchedule(
            tutorId: widget.tutor.userId!,
            startTimestamp: startTimestamp,
            endTimestamp: endTimestamp),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            ScheduleResponse res = snapshot.data as ScheduleResponse;
            List<ScheduleOfTutor> schedules = res.scheduleOfTutor!;
            schedules.sort(sortSchedule);
            return Container(
              width: double.infinity,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Chọn ngày: "),
                    ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate,
                                  firstDate: _selectedDate
                                      .subtract(Duration(days: 14)),
                                  lastDate:
                                      _selectedDate.add(Duration(days: 14)))
                              .then((value) => {
                                    if (value != null)
                                      {
                                        setState(() {
                                          _selectedDate = value;
                                        })
                                      }
                                  });
                        },
                        child: Text(_selectedDate.day.toString() +
                            "/" +
                            _selectedDate.month.toString() +
                            "/" +
                            _selectedDate.year.toString())),
                  ],
                ),
                ...renderBookingItem(_selectedDate, schedules),
                schedules.length == 0 ? Text("Không có lịch học") : Container()
              ]),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

int sortSchedule(ScheduleOfTutor a, ScheduleOfTutor b) {
  if (a.startTimestamp != null && b.startTimestamp != null) {
    return a.startTimestamp?.compareTo(b.startTimestamp!) ?? 0;
  } else {
    return 0;
  }
}
