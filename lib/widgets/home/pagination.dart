import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  final int totalPage;
  final int currentPage;
  final Function(int) onPageChanged;

  const Pagination(
      {Key? key,
      required this.totalPage,
      required this.currentPage,
      required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> pages = [];
    if (totalPage < 4) {
      for (int i = 1; i <= totalPage; i++) {
        pages.add(i);
      }
    } else {
      for (int i = 1; i <= 4; i++) {
        if (currentPage + 3 > totalPage) {
          pages.add(totalPage - (4 - i));
        } else if (currentPage - 2 < 0) {
          pages.add(i);
        } else {
          pages.add(currentPage - 2 + i);
        }
      }
    }

    List<Widget> pageButton = pages
        .map((e) => IconButton(
            onPressed: () {
              onPageChanged(e);
            },
            icon: Text(
              e.toString(),
              style: TextStyle(
                  color: e == currentPage ? Colors.blue : Colors.grey),
            )))
        .toList();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                onPageChanged(1);
              },
              icon: Icon(Icons.first_page)),
          ...pageButton,
          IconButton(
              onPressed: () {
                onPageChanged(totalPage);
              },
              icon: Icon(Icons.last_page)),
        ],
      ),
    );
  }
}
