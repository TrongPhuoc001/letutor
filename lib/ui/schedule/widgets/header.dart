import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Widget img;
  String upperContent;
  String lowerContent;
  String lowerSubContent;
  Header({
    Key? key,
    required this.img,
    required this.upperContent,
    required this.lowerContent,
    required this.lowerSubContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        img,
        SizedBox(
          height: 5,
        ),
        Text(
          upperContent,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: Colors.grey, width: 5)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Text(
                  lowerContent,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Text(
                  lowerSubContent,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 3,
        ),
      ],
    );
  }
}
