import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lettutor/api/courses/course.api.dart';
import 'package:lettutor/constants/levels.dart';
import 'package:lettutor/model/course_model.dart';
import 'package:lettutor/themes/main_theme.dart';
import 'package:lettutor/ui/courses/widgets/course_card.dart';
import 'package:lettutor/widgets/home/pagination.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multiselect/multiselect.dart';

import '../../widgets/multi_select_dialog.dart';

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  int page = 1;
  int limit = 10;
  int tab = 0;
  List<Category> categories = [];
  List<String> _selected_categories = [];
  List<int> _selected_levels = [];
  String? _selected_sort = null;
  TextEditingController _searchController = TextEditingController();
  String _search = '';

  List<String> urls = ['course', 'e-book', 'material/interactive-e-book'];
  Future<List<Category>> getCategory() async {
    try {
      CategoryResponse res = await CourseApi.getCategories();
      return res.rows!;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getCategory().then((value) {
      setState(() {
        categories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: CourseApi.getCourseList(page, limit, urls[tab], filter: {
          'categories': _selected_categories,
          'levels': _selected_levels,
          'sort': _selected_sort,
          'search': _search
        }),
        builder: ((context, snapshot) {
          print(_search);
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
                                Expanded(
                                    child: TextField(
                                  controller: _searchController,
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
                                          onTap: () {
                                            setState(() {
                                              _search = _searchController.text;
                                            });
                                          },
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
                          Container(
                            width: 177,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: MultiSelectDialogField(
                                title: Text("Chọn cấp độ"),
                                initialValue: _selected_levels,
                                buttonText: Text(
                                  "Chọn cấp độ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                buttonIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 8,
                                  color: Colors.grey,
                                ),
                                items: LEVELS
                                    .asMap()
                                    .entries
                                    .map((e) => MultiSelectItem(e.key, e.value))
                                    .toList(),
                                onConfirm: (values) {
                                  setState(() {
                                    _selected_levels = values;
                                  });
                                }),
                          ),
                          Container(
                            width: 177,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: MultiSelectDialogField(
                                title: Text("Chọn danh mục"),
                                initialValue: _selected_categories,
                                buttonText: Text(
                                  "Chọn danh mục",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                buttonIcon: Icon(
                                  Icons.arrow_drop_down,
                                  size: 8,
                                  color: Colors.grey,
                                ),
                                items: categories
                                    .map(
                                        (e) => MultiSelectItem(e.id!, e.title!))
                                    .toList(),
                                onConfirm: (values) {
                                  setState(() {
                                    _selected_categories = values;
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 177,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              value: _selected_sort,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Sắp xếp",
                                hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              items: [
                                DropdownMenuItem<String>(
                                  value: "DESC",
                                  child: Text("Độ khó giảm dần"),
                                ),
                                DropdownMenuItem<String>(
                                  value: "ASC",
                                  child: Text("Độ khó tăng dần"),
                                )
                              ],
                              onChanged: (Object? value) {
                                setState(() {
                                  _selected_sort = value as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 177,
                            child: ElevatedButton(
                                child: Text('Đặt lại'),
                                onPressed: () {
                                  setState(() {
                                    _selected_categories = [];
                                    _selected_levels = [];
                                    _selected_sort = null;
                                    _searchController.text = '';
                                    _search = '';
                                  });
                                }),
                          )
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
