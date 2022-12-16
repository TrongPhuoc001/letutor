import 'package:flutter/material.dart';
import 'package:lettutor/model/schedule_model.dart';
import 'package:lettutor/widgets/teacher/book_chedule_item.dart';

Widget HomeBanner({required List<Schedule> schedules, totalLearned}) {
  schedules.sort(
    (a, b) => a.scheduleDetailInfo!.startPeriodTimestamp!
        .compareTo(b.scheduleDetailInfo!.startPeriodTimestamp!),
  );

  return Container(
    padding: const EdgeInsets.all(10),
    height: 150,
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
        schedules.length == 0
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
                    child: Text("Bạn có ${schedules.length} buổi học .",
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
                        "${readTimestamp(schedules[0].scheduleDetailInfo!.startPeriodTimestamp!)} ${schedules[0].scheduleDetailInfo!.startPeriod!}.",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
        Text(
          "Tổng số giờ bạn đã học là ${(totalLearned / 60).floor()} giờ ${totalLearned - (totalLearned / 60).floor() * 60} phút",
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}
