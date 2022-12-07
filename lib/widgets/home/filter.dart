import 'package:flutter/material.dart';
import 'package:lettutor/ui/my_app.dart';
import 'package:lettutor/widgets/multi_select_dialog.dart';
import 'package:lettutor/widgets/round_text_field.dart';
import 'package:provider/provider.dart';

import '../../constants/specialty.dart';
import '../round_button.dart';
import '../round_button_outlined.dart';

class Fliter extends StatelessWidget {
  const Fliter({super.key});

  @override
  Widget build(BuildContext context) {
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
                        hintText: "Nhập tên gia sư...",
                        onChanged: (v) {
                          context.read<FilterProvider>().updateSearch(v);
                        })),
                Expanded(
                    child: MultiSelectDialog(
                        items: ['Bản ngữ', 'Việt nam', 'Nước ngoài'],
                        onChanged: (v) {
                          context.read<FilterProvider>().updateNation(v[0]);
                        },
                        selectedItems: [],
                        title: "Chọn quốc tịch")),
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
