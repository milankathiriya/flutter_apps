import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:student_finder_rnw/controllers/course_controller.dart';
import 'package:student_finder_rnw/controllers/dept_branch_controller.dart';

class CourseDetailsScreen extends StatefulWidget {
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  DepartmentItem _singleCourseDeptValueFirst =
      DepartmentItem(dept_id: 0.toString());
  DeptBranchController deptBranchController = Get.put(DeptBranchController());
  CourseController courseController = Get.put(CourseController());

  List<DepartmentItem> _singleCourseDeptDropdownMenuItems = List();

  String selectedSingleCourseDeptName = "";

  SingleCourseItem _singleCourseValueFirst =
      SingleCourseItem(course_id: 0.toString());
  String selectedSingleCourseName = "";
  List<SingleCourseItem> _singleCourseDropdownMenuItems = List();

  @override
  void initState() {
    super.initState();
    _initDeptBranch();
    _initSingleCourse();
  }

  _initDeptBranch() async {
    await deptBranchController.getDeptBranchInfo();
    print(deptBranchController.departments.value);

    setState(() {
      _singleCourseDeptDropdownMenuItems.add(
        DepartmentItem(
            dept_id: "0",
            dept_name: "Select Department"),
      );

      deptBranchController.departments.value.forEach((element) {
        _singleCourseDeptDropdownMenuItems.add(
          DepartmentItem(
              dept_id: element['department_id'],
              dept_name: element['department_name']),
        );
      });
    });
  }

  _initSingleCourse() async {
    await courseController.getCourseInfo();

    courseController.singleCourses.value.forEach((list) {
      list.forEach((element) {
        _singleCourseDropdownMenuItems.add(
          SingleCourseItem(
              course_id: element.course_id, course_name: element.course_name),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Detail"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Single Course",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FlatButton.icon(
                  icon: Icon(Icons.refresh),
                  label: Text("Reset"),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                        selectedSingleCourseDeptName = "";
                        selectedSingleCourseName = "";
                        _singleCourseDeptValueFirst = DepartmentItem(
                            dept_id: "0",
                            dept_name: "Select Department");
                        // _singleCourseDeptValueFirst.deptId = 0.toString();
                    });

                  },
                )
              ],
            ),
            Divider(),
            singleCourseDeptDropDown(),
            Divider(),
            (int.parse(_singleCourseDeptValueFirst.deptId) != 0)
                ? singleCourseDropDown()
                : Text(""),
          ],
        ),
      ),
    );
  }

  Widget singleCourseDeptDropDown() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SearchableDropdown(
        dialogBox: true,
        hint: "Select Department",
        label: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 8, left: 8),
          child: Text(
            "Department",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        underline: "",
        isExpanded: true,
        value: _singleCourseDeptValueFirst,
        isCaseSensitiveSearch: false,
        searchHint: "Choose Department",
        displayItem: (item, selected) {
          return (Row(children: [
            selected
                ? Icon(
                    Icons.radio_button_checked,
                    color: Colors.redAccent,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                  ),
            SizedBox(width: 7),
            Expanded(
              child: item,
            ),
          ]));
        },
        doneButton: "Done",
        items: _singleCourseDeptDropdownMenuItems
            .map(
              (e) => DropdownMenuItem<DepartmentItem>(
                child: Text(e.dept_name),
                value: e,
              ),
            )
            .toList(),
        onChanged: (val) {
          setState(() {
            _singleCourseDeptValueFirst = val;
            deptBranchController.departments.value.forEach((element) {
              if (element['department_id'] ==
                  _singleCourseDeptValueFirst.deptId) {
                selectedSingleCourseDeptName = element['department_name'];
              }
            });
          });
        },
      ),
    );
  }

  Widget singleCourseDropDown() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SearchableDropdown(
        hint: "Select Course",
        label: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 8, left: 8),
          child: Text(
            "Course",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        underline: "",
        isExpanded: true,
        value: _singleCourseValueFirst,
        isCaseSensitiveSearch: false,
        searchHint: "Choose Course",
        displayItem: (item, selected) {
          return (Row(children: [
            selected
                ? Icon(
                    Icons.radio_button_checked,
                    color: Colors.redAccent,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                  ),
            SizedBox(width: 7),
            Expanded(
              child: item,
            ),
          ]));
        },
        doneButton: "Done",
        items: _singleCourseDropdownMenuItems
            .map(
              (e) => DropdownMenuItem<SingleCourseItem>(
                child: Text(e.courseName),
                value: e,
              ),
            )
            .toList(),
        onChanged: (val) {
          setState(() {
            _singleCourseValueFirst = val;
            courseController.singleCourses.value.forEach((list) {
              list.forEach((element) {
                if (_singleCourseValueFirst.courseId == element.course_id) {
                  selectedSingleCourseName = element.course_name;
                }
              });
            });
          });
        },
      ),
    );
  }
}

class DepartmentItem {
  String dept_id;
  String dept_name;

  String get deptId => dept_id;

  set deptId(dynamic id) => dept_id = id;

  String get deptName => dept_name;

  DepartmentItem({this.dept_id, this.dept_name});

  @override
  String toString() {
    return "${dept_name} ${dept_id}";
  }
}

class SingleCourseItem {
  final String course_id;
  final String course_name;

  String get courseId => course_id;

  String get courseName => course_name;

  SingleCourseItem({this.course_id, this.course_name});

  @override
  String toString() {
    return "${course_name} ${course_id}";
  }
}
