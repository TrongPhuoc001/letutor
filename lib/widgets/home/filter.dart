import 'package:flutter/material.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/widgets/common/button/round_button.dart';
import 'package:lettutor/widgets/common/button/round_button_outlined.dart';
import 'package:lettutor/widgets/multi_select_dialog.dart';
import 'package:lettutor/widgets/round_text_field.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../../constants/specialty.dart';

class Fliter extends StatefulWidget {
  Fliter({super.key});

  @override
  State<Fliter> createState() => _FliterState();
}

class _FliterState extends State<Fliter> {
  final FocusNode focusNode = FocusNode();
  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        context.read<FilterProvider>().updateSearch();
      }
    });
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 30, 30, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text("Tìm kiếm gia sư",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    child: RoundTextField(
                        focusNode: focusNode,
                        hintText: "Nhập tên gia sư...",
                        controller: FilterProvider.searchController)),
                Expanded(
                    child: DropDownMultiSelect(
                  onChanged: (List<String> x) {
                    setState(() {
                      selectedItems = x;
                    });
                  },
                  whenEmpty: "Chọn quốc gia",
                  options: ['Bản ngữ', "Việt Nam", 'Nước ngoài'],
                  selectedValues: selectedItems,
                  hintStyle: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), gapPadding: 0),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), gapPadding: 0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20), gapPadding: 0),
                    isDense: true,
                    isCollapsed: true,
                  ),
                )),
              ],
            )),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
          child: Text(
            "Chọn thời gian dạy kèm có lịch trống:",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(child: RoundTextField(hintText: "Chọn ngày")),
                Expanded(child: RoundTextField(hintText: "Chọn giờ")),
              ],
            )),
        Container(
          child: Wrap(
            children: SPECIALTIES_OPTION
                .map((e) => Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: RoundButon(
                        text: e.name,
                        onPressed: () {
                          context.read<FilterProvider>().updateSpecialties(e);
                        },
                        isSelected: (FilterProvider.specialties == null &&
                                e.key == null) ||
                            (FilterProvider.specialties != null &&
                                FilterProvider.specialties!.key == e.key))))
                .toList(),
          ),
        ),
        RoundButtonOutLined(
            child: TextButton(
              child: Text(
                "Đặt lại bộ tìm kiếm",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                context.read<FilterProvider>().clear();
              },
            ),
            onPressed: () {})
      ]),
    );
  }
}
