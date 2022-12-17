// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PdfView extends StatelessWidget {
  final String namePdf;
  final String name;
  const PdfView({
    Key? key,
    required this.namePdf,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(name),
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios))),
      body: const PDF(
        swipeHorizontal: false,
      ).cachedFromUrl(namePdf),
    );
  }
}
