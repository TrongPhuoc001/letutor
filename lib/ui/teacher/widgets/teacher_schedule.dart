import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeacherSchedule extends StatefulWidget {
  TeacherSchedule({Key? key}) : super(key: key);

  @override
  _TeacherScheduleState createState() => _TeacherScheduleState();
}

class _TeacherScheduleState extends State<TeacherSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Today")),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
            IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
            Text("Thg 10, 2022")
          ],
        ),
        Table(
          border: TableBorder.all(color: Color.fromRGBO(231, 231, 231, 1)),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth(70),
            2: FixedColumnWidth(70),
            3: FlexColumnWidth(70),
            4: FlexColumnWidth(70),
          },
          children: [
            TableRow(children: [
              Container(
                width: 105,
                color: Colors.grey[200],
              ),
              TableCell(child: Text("22/10 T7")),
              TableCell(child: Text("23/10 CN")),
              TableCell(child: Text("24/10 T2")),
              TableCell(child: Text("25/10 T3")),
            ]),
            TableRow(children: [
              Container(
                color: Colors.grey[200],
                child: Text("00:00 - 00:25"),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
            ]),
            TableRow(children: [
              Container(
                color: Colors.grey[200],
                child: Text("00:30 - 00:55"),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
              TableCell(
                child: SizedBox(),
              ),
            ]),
          ],
        )
      ]),
    );
  }
}
