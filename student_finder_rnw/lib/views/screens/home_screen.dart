import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/auth_controller.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/models/faculty_login_model.dart';

import '../components/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _gridFormKey = GlobalKey<FormState>();
  FocusNode fieldNode = FocusNode();

  String grid;

  int _stackIndex = 0;

  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("RWn. ${facultyDetail.user_name}"),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _stackIndex,
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(
                  flex: 3,
                ),
                Container(
                  width: Get.width * 0.9,
                  child: Form(
                    key: _gridFormKey,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      focusNode: fieldNode,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Enter any GRID";
                        } else if (val.isNotEmpty) {
                          if (val.isNumericOnly) {
                            if (int.parse(val) <= 0) {
                              return "Enter valid GRID";
                            }
                          }
                          if (!val.isNumericOnly) {
                            return "Enter valid GRID";
                          }
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          grid = val;
                        });
                      },
                      onEditingComplete: validateAndFetchStudentDetail,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "GRID",
                        hintText: "Enter GRID",
                        prefixIcon: Icon(Icons.api),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
                FloatingActionButton(
                  onPressed: validateAndFetchStudentDetail,
                  child: Icon(Icons.person_search),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
        drawer: MyDrawer(node: fieldNode,),
      ),
    );
  }

  validateAndFetchStudentDetail() async {

    FocusScope.of(context).unfocus();

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    if (_gridFormKey.currentState.validate()) {
      _gridFormKey.currentState.save();

      studentController.GRID.value = grid;

      print(studentController.GRID.value);

      setState(() {
        _stackIndex = 1;
      });

      var res = await studentController.fetchStudentDetail(
          grid: studentController.GRID.value);

      await setStudentInfo(res);

      Get.toNamed('/basic_info');

      setState(() {
        _stackIndex = 0;
      });
    }
  }

  setStudentInfo(res) {
    String stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";

    try {
      if (res.first.image.toString() == "/Eduzilla_image/rnw.jpg") {
        print("yes");
        stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";
      } else {
        stu_img = "http://demo.rnwmultimedia.com/eduzila_api" + res.first.image;
      }
    } catch (e) {
      stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";
    }

    studentController.image.value = stu_img;
    studentController.fname.value = res.first.fname;
    studentController.lname.value = res.first.lname;
    studentController.total_admissions.value = res.length;
    studentController.email.value =
        res.first.email == "-" ? "-" : res.first.email;
    studentController.mobile.value =
        res.first.mobile == "" ? "-" : res.first.mobile;
    studentController.father_name.value =
        res.first.father_name == "" ? "-" : res.first.father_name;
    studentController.father_mobile.value =
        res.first.father_mobile == "" ? "-" : res.first.father_mobile;
    studentController.address.value =
        res.first.address == "" ? "-" : res.first.address;
    studentController.remarks.value = res.first.remarks;

    studentController.courses.clear();
    res.forEach((e) {
      print(e.course);
      studentController.courses.add(e.course);
    });

    studentController.course_packages.clear();
    res.forEach((e) {
      print(e.course_package);
      if (e.course_package == "" || e.course_package.isEmpty) {
        studentController.course_packages.add("-");
      } else {
        studentController.course_packages.add(e.course_package);
      }
    });

    studentController.branch_names.clear();
    res.forEach((e) {
      print(e.branch_name);
      studentController.branch_names.add(e.branch_name);
    });

    studentController.admission_dates.clear();
    res.forEach((e) {
      print(e.admission_date);
      studentController.admission_dates.add(e.admission_date);
    });

    studentController.admission_codes.clear();
    res.forEach((e) {
      print(e.admission_code);
      studentController.admission_codes.add(e.admission_code);
    });

    studentController.admission_statuses.clear();
    res.forEach((e) {
      print(e.admission_status);
      studentController.admission_statuses.add(e.admission_status);
    });

    studentController.total_fees.clear();
    res.forEach((e) {
      print(e.total_fees);
      studentController.total_fees.add(e.total_fees);
    });

    studentController.paid_fees.clear();
    res.forEach((e) {
      print(e.paid_fees);
      studentController.paid_fees.add(e.paid_fees);
    });
  }
}
