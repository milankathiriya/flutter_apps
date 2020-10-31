import 'package:flutter/material.dart';
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
        drawer: MyDrawer(),
      ),
    );
  }

  validateAndFetchStudentDetail() async {
    if (_gridFormKey.currentState.validate()) {
      _gridFormKey.currentState.save();

      studentController.GRID.value = grid;

      print(studentController.GRID.value);

      setState(() {
        _stackIndex = 1;
      });

      var res = await studentController.fetchStudentDetail(
          grid: studentController.GRID.value);

      String stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";

      try {
        if (res.first.image.toString() == "/Eduzilla_image/rnw.jpg") {
          print("yes");
          stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";
        } else {
          stu_img =
              "http://demo.rnwmultimedia.com/eduzila_api" + res.first.image;
        }
      } catch (e) {
        stu_img = "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";
      }

      studentController.image.value = stu_img;

      Get.toNamed('/basic_info');

      setState(() {
        _stackIndex = 0;
      });
    }
  }
}
