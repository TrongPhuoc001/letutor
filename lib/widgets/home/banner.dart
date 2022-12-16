import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lettutor/model/schedule_model.dart';
import 'package:lettutor/widgets/teacher/book_chedule_item.dart';

class HomeBanner extends StatefulWidget {
  final List<Schedule> schedules;
  final int totalLearned;
  const HomeBanner(
      {Key? key, required this.schedules, required this.totalLearned})
      : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  int timeLeft = 0;

  @override
  Widget build(context) {
    widget.schedules.sort(
      (a, b) => a.scheduleDetailInfo!.startPeriodTimestamp!
          .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp!),
    );

    DateTime upComming = DateTime.fromMillisecondsSinceEpoch(
        widget.schedules[0].scheduleDetailInfo!.startPeriodTimestamp!);

    DateTime end = DateTime.fromMillisecondsSinceEpoch(
        widget.schedules[0].scheduleDetailInfo!.endPeriodTimestamp!);
    DateTime now = DateTime.now();

    Timer timer = new Timer(new Duration(seconds: 1), () {
      setState(() {
        timeLeft = upComming.difference(now).inSeconds;
      });
    });
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          transform: const GradientRotation(0.5),
          colors: [
            const Color.fromRGBO(12, 61, 223, 1),
            const Color.fromRGBO(5, 23, 157, 1),
          ],
        ),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.schedules.length == 0
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text("Bạn không có buổi học nào.",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500)),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                          "Bạn có ${widget.schedules.length} buổi học .",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text("Buổi học sắp tới :",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                          "${readTimestamp(widget.schedules[0].scheduleDetailInfo!.startPeriodTimestamp!)} ${upComming.hour}:${upComming.minute} - ${end.hour}:${end.minute}.",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                          "Bắt đầu sau: ${(timeLeft / 3600).floor()}h${(timeLeft % 3600 / 60).round()}'${timeLeft % 60}",
                          style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
          Text(
            "Tổng số giờ bạn đã học là ${(widget.totalLearned / 60).floor()} giờ ${widget.totalLearned - (widget.totalLearned / 60).floor() * 60} phút",
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
