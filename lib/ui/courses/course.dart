import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/api/courses/course.api.dart';
import 'package:lettutor/model/course_model.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/widgets/course_card.dart';
import 'package:lettutor/widgets/home/pagination.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int page = 1;
  int limit = 10;
  int tab = 0;

  List<String> urls = ['course', 'e-book', 'material/interactive-e-book'];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CourseApi.getCourseList(page, limit, urls[tab]),
        builder: ((context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            CourseListResponse res = snapshot.data as CourseListResponse;
            List<CourseModel> courses = res.data!.rows!;
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
                              child:
                                  SvgPicture.asset("assets/icons/course.svg")),
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
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0)),
                                        gapPadding: 0,
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1))),
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
                                          color:
                                              Color.fromRGBO(217, 217, 217, 1)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(3),
                                      child: InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.search,
                                            color: Color.fromRGBO(
                                                217, 217, 217, 1),
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
                          buildTab(title: "Khóa học", value: 0),
                          buildTab(title: "E - Book", value: 1),
                          buildTab(title: "Interactive E-book", value: 2)
                        ]),
                      ),
                      Divider(),
                      courses.isNotEmpty
                          ? Column(
                              children: courses
                                  .map((course) => CourseCard(course, context))
                                  .toList(),
                            )
                          : Text('No data'),
                      Pagination(
                          totalPage: (res.data!.count! / limit).ceil(),
                          currentPage: page,
                          onPageChanged: (value) {
                            setState(() {
                              page = value;
                            });
                          })
                    ],
                  ),
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  TextButton buildTab({title, value}) {
    return TextButton(
        onPressed: () {
          setState(() {
            tab = value;
            page = 1;
          });
        },
        child: Text(title,
            style: TextStyle(
                color: tab == value ? Colors.blue : Colors.black,
                fontWeight: FontWeight.w200)));
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
