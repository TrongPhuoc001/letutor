import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/model/course_model.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/widgets/course_card.dart';
import 'package:lettutor/widgets/round_text_field.dart';

class Course extends StatelessWidget {
  const Course({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CourseModel> courses = [
      CourseModel(
          imageUrl: "assets/images/course1.png",
          name: "Life in the Internet Age",
          description:
              "Let's discuss how technology is changing the way we live",
          level: "Intermediate",
          topics: [
            TopicModel(name: 'The Internet'),
            TopicModel(name: "Artidicial Intelligence"),
            TopicModel(name: "Social Media"),
            TopicModel(name: "Internet Privacy")
          ],
          purpose:
              "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
          reason:
              "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor."),
      CourseModel(
          imageUrl: "assets/images/course2.png",
          name: "Caring for Our Planet",
          description:
              "Let's discuss our relationship as humans with our planet, Earth",
          level: "Intermediate",
          topics: [],
          purpose:
              "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
          reason:
              "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor."),
    ];
    return MainTheme(
        context: context,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
          child: Column(
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: SvgPicture.asset("assets/icons/course.svg")),
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text("Khám phá các khóa học",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        const Expanded(
                            child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)),
                                gapPadding: 0,
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(217, 217, 217, 1))),
                            hintText: "Khóa học",
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(217, 217, 217, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(217, 217, 217, 1)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                  )),
                            )),
                      ],
                    ),
                  ],
                )),
              ]),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Text(
                  "LiveTutor đã xây dựng nên các khóa học của các lĩnh vực trong cuộc sống chất lượng, bài bản và khoa học nhất cho những người đang có nhu cầu trau dồi thêm kiến thức về các lĩnh vực.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FixedTextField(hintText: "Chọn cấp độ"),
                  FixedTextField(hintText: "Chọn danh mục"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FixedTextField(hintText: "Sắp xếp theo độ khó"),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                child: Row(children: [
                  TextButton(onPressed: () {}, child: Text("Khóa học")),
                  TextButton(
                      onPressed: () {},
                      child: Text("E-book",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200))),
                  TextButton(
                      onPressed: () {},
                      child: Text("Interactive E-book",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200)))
                ]),
              ),
              Divider(),
              Text("English For Traveling",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Column(
                children: courses
                    .map((course) => CourseCard(course, context))
                    .toList(),
              )
            ],
          ),
        ));
  }
}

Widget FixedTextField({hintText}) {
  return SizedBox(
      width: 177,
      child: TextField(
        decoration: InputDecoration(
          //suffixIcon: const Icon(Icons.arrow_drop_down),
          suffixIconColor: const Color.fromRGBO(217, 217, 217, 1),
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromRGBO(217, 217, 217, 1)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: const BorderSide(
              color: Color.fromRGBO(217, 217, 217, 1),
            ),
          ),
        ),
      ));
}
