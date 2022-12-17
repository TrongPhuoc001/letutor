import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/model/course_model.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/pdf_view.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({required this.course});
  final CourseModel course;
  @override
  Widget build(BuildContext context) {
    List<Widget>? topics = course.topics
        ?.map((topic) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PdfView(
                            namePdf: topic.nameFile!,
                            name:
                                "${course.topics?.indexOf(topic)}. ${topic.name!}",
                          )));
            },
            child: Row(
              children: [
                Expanded(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: const BorderSide(
                        color: Color.fromARGB(179, 233, 231, 231), width: 1),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                      child: Text(
                          "${course.topics?.indexOf(topic)}. ${topic.name!}")),
                )),
              ],
            )))
        .cast<Widget>()
        .toList();

    return MainTheme(
        context: context,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(
                    color: Color.fromARGB(179, 233, 231, 231), width: 1),
              ),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: CachedNetworkImage(
                      imageUrl: course.imageUrl!,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error)),
                ),
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      Text(course.name!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: Text(course.description!),
                      ),
                      Row(children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            "Khám phá",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
                      ])
                    ]))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(children: const <Widget>[
                SizedBox(width: 20, child: Divider()),
                Text(
                  "Tổng quan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Row(
              children: const [
                Icon(
                  Icons.question_mark_rounded,
                  size: 20,
                  color: Color.fromRGBO(199, 83, 64, 1),
                ),
                Text(
                  "Tại sao bạn nên học khóa học này",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(course.reason!),
            ),
            Row(
              children: const [
                Icon(
                  Icons.question_mark_rounded,
                  size: 20,
                  color: Color.fromRGBO(199, 83, 64, 1),
                ),
                Text(
                  "Bạn có thể làm gì",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(course.purpose!),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(children: const <Widget>[
                SizedBox(width: 20, child: Divider()),
                Text(
                  "Trình độ yêu cầu",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Row(
              children: [
                const Icon(
                  Icons.person_add_alt,
                  size: 20,
                  color: Color.fromRGBO(68, 100, 184, 1),
                ),
                Text(
                  course.level!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(children: const <Widget>[
                SizedBox(width: 20, child: Divider()),
                Text(
                  "Thời lượng khóa học",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Row(
              children: [
                const Icon(
                  Icons.book,
                  size: 20,
                  color: Color.fromRGBO(68, 100, 184, 1),
                ),
                Text(
                  course.topics!.length.toString() + " Chủ đề",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(children: const <Widget>[
                SizedBox(width: 20, child: Divider()),
                Text(
                  "Danh sách chủ đề",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Column(
              children: topics!,
            )
          ]),
        ));
  }
}
