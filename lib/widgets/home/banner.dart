import 'package:flutter/material.dart';

Widget HomeBanner({courseNumber, totalLearned}) {
  return Container(
    padding: const EdgeInsets.all(10),
    height: 150,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        transform: const GradientRotation(0.5),
        colors: [
          const Color.fromRGBO(12, 61, 223, 1)!,
          const Color.fromRGBO(5, 23, 157, 1)!,
        ],
      ),
    ),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        courseNumber == 0
            ? const Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("Bạn không có buổi học nào.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text("Bạn có $courseNumber buổi học .",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
        Text(
          "Tổng số giờ bạn đã học là ${(totalLearned / 60).floor()} giờ ${totalLearned - (totalLearned / 60).floor() * 60} phút",
          style: const TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}
