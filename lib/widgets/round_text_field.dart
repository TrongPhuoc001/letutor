import 'package:flutter/material.dart';

Widget RoundTextField({hintText}) {
  return TextField(
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gapPadding: 0,
          borderSide: BorderSide(color: Color.fromRGBO(233, 233, 233, 1))),
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromRGBO(215, 215, 215, 1),
          fontSize: 14,
          fontWeight: FontWeight.w500),
    ),
  );
}
