import 'package:flutter/material.dart';

Widget RoundTextField(
    {hintText,
    round = 20.0,
    initValue = "",
    onChanged,
    enabled = true,
    controller}) {
  return TextFormField(
    initialValue: initValue,
    onChanged: onChanged,
    controller: controller,
    enabled: enabled,
    decoration: InputDecoration(
      isDense: true,
      fillColor: enabled ? Colors.white : Color.fromARGB(255, 163, 15, 15),
      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(round * 1.0)),
          gapPadding: 0,
          borderSide:
              const BorderSide(color: Color.fromRGBO(233, 233, 233, 1))),
      hintText: hintText,
      hintStyle: const TextStyle(
          color: Color.fromRGBO(215, 215, 215, 1),
          fontSize: 14,
          fontWeight: FontWeight.w500),
    ),
  );
}
