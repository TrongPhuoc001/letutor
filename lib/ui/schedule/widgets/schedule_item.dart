// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lettutor/api/schedule/schedule.api.dart';
import 'package:lettutor/constants/countries.dart';

import 'package:lettutor/model/schedule_model.dart';
import 'package:lettutor/ui/schedule/shedule.dart';
import 'package:lettutor/widgets/notification.dart';
import 'package:lettutor/widgets/teacher/book_chedule_item.dart';
import 'package:lettutor/widgets/teacher/teacher_short_info.dart';

import '../../../widgets/common/button/round_button_outlined.dart';

class ScheduleItem extends StatelessWidget {
  final List<Schedule> scheduleItems;
  const ScheduleItem({
    Key? key,
    required this.scheduleItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime startDateTime = DateTime.fromMillisecondsSinceEpoch(
        scheduleItems[0].scheduleDetailInfo!.startPeriodTimestamp!);
    DateTime endDateTime = DateTime.fromMillisecondsSinceEpoch(
        scheduleItems[0].scheduleDetailInfo!.endPeriodTimestamp!);
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromRGBO(241, 241, 241, 1),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              readTimestamp(
                  scheduleItems[0].scheduleDetailInfo!.startPeriodTimestamp!),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("${scheduleItems.length} buổi học"),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Colors.white,
              child: TeacherShortInfo(
                  scheduleItems[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!,
                  contact: true),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              color: Colors.white,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                ...scheduleItems.map((scheduleItem) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${scheduleItem.scheduleDetailInfo!.startPeriod!} - ${scheduleItem.scheduleDetailInfo!.endPeriod!}",
                            style: TextStyle(fontSize: 18)),
                        RoundButtonOutLined(
                            onPressed: () {
                              cancelSchedule(
                                  context,
                                  scheduleItem,
                                  readTimestamp(scheduleItems[0]
                                      .scheduleDetailInfo!
                                      .startPeriodTimestamp!));
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.cancel_presentation,
                                  color: Colors.red,
                                ),
                                Text(
                                  'Hủy',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                            round: 0,
                            color: Colors.red)
                      ],
                    )),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.expand_more,
                          size: 15,
                        ),
                        const Text(
                          "Yêu cầu cho buổi học",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Chỉnh sửa yêu cầu",
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ABCD",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Vào buổi học'),
                )
              ],
            )
          ]),
    );
  }

  void cancelSchedule(BuildContext context, Schedule scheduleItem, time) {
    final TextEditingController reportController = TextEditingController();
    final TextEditingController infoController = TextEditingController();
    infoController.text = '1';
    showBottomSheet(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (_, setState) => Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: ClipOval(
                        child: Image.network(
                          scheduleItem.scheduleDetailInfo!.scheduleInfo!
                                  .tutorInfo!.avatar ??
                              'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.scaleDown,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                                'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.fill);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      time,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '*Lý do bạn hủy buổi học này là gì',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      value: infoController.text,
                      items: CANCEL_COURSE.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key.toString(),
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (Object? value) {
                        setState(() {
                          infoController.text = value.toString();
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        controller: reportController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              gapPadding: 0),
                          hintText: 'Vui lòng nhập vấn đề bạn gặp phải',
                        ),
                        validator: ((value) {
                          if (value == null) {
                            return '';
                          }
                          if (value.isEmpty) {
                            return '';
                          }
                          return null;
                        }),
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                        const SizedBox(width: 10),
                        SizedBox(
                            width: 100,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Báo cáo',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                try {
                                  await ScheduleApi.cancelSchedule(
                                      int.parse(infoController.text),
                                      reportController.text,
                                      scheduleItem.id!);
                                  notification(
                                      context: context,
                                      message: 'Hủy buổi học thành công');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ScheduleScreen()));
                                } catch (e) {
                                  notification(
                                      context: context,
                                      message: 'Hủy buổi học thất bại');
                                }
                              },
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
