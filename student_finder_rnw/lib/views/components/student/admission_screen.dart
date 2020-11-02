import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';

class Admission extends StatefulWidget {
  @override
  _AdmissionState createState() => _AdmissionState();
}

class _AdmissionState extends State<Admission> with TickerProviderStateMixin {
  StudentController studentController = Get.find();

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(
        length: studentController.total_admissions.value, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Top Black Part of Student Detail
          Container(
            height: Get.height * 0.32,
            width: Get.width,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Stack(
                  alignment: Alignment(Get.width * 0.002, 0),
                  children: [
                    Container(
                      height: Get.height * 0.18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(studentController.image.value),
                        ),
                      ),
                    ),
                    Chip(
                      autofocus: true,
                      elevation: 2,
                      shadowColor: Colors.tealAccent,
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        "Admissions: " +
                            studentController.total_admissions.value.toString(),
                        style: TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  studentController.fname.value +
                      " " +
                      studentController.lname.value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Chip(
                  autofocus: true,
                  elevation: 2,
                  shadowColor: Colors.amber,
                  backgroundColor: Theme.of(context).primaryColor,
                  label: Text(
                    "GRID: " + studentController.GRID.value.toString(),
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),

          // No of Student Admissions
          DefaultTabController(
            length: studentController.total_admissions.value,
            child: Column(
              children: [
                TabBar(
                  tabs: List.generate(studentController.total_admissions.value,
                      (i) {
                    return Tab(
                      child: Text("Ad. ${i + 1}"),
                    );
                  }),
                  labelColor: Colors.black,
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
                Container(
                  height: Get.height * 0.42,
                  // color: Colors.red[100],
                  child: TabBarView(
                    children: List.generate(
                        studentController.total_admissions.value, (i) {
                      List courses = studentController.courses[i].split(",");
                      var course = courses.join(",\n");

                      var course_package = studentController.course_packages[i];
                      var branch_name = studentController.branch_names[i];
                      var admission_date = studentController.admission_dates[i];
                      var admission_code = studentController.admission_codes[i];
                      var admission_status =
                          studentController.admission_statuses[i];
                      var total_fee = studentController.total_fees[i];
                      var paid_fee = studentController.paid_fees[i];
                      var remaining_fee = int.parse(studentController.total_fees[i]) - int.parse(studentController.paid_fees[i]);
                      return ListView(
                        children: [
                          ListTile(
                            leading: Icon(Icons.assignment_turned_in),
                            title: Text(
                              "Course Package",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(course_package),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.assignment),
                            title: Text(
                              "Course",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(course),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.location_city),
                            title: Text(
                              "Branch Name",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(branch_name),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.calendar_today),
                            title: Text(
                              "Admission Date",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(admission_date),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.code),
                            title: Text(
                              "Admission Code",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(admission_code),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.flag),
                            title: Text(
                              "Admission Status",
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text(admission_status),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.monetization_on),
                            title: Text(
                              "Total Fees",
                              style: TextStyle(color: Colors.purple),
                            ),
                            subtitle: Text(total_fee),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.attach_money),
                            title: Text(
                              "Paid Fees",
                              style: TextStyle(color: Colors.purple),
                            ),
                            subtitle: Text(paid_fee),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                                Icon(Icons.attach_money),
                            title: Text(
                              "Remaining Fees",
                              style: TextStyle(color: Colors.purple),
                            ),
                            subtitle: Text(remaining_fee.toString()),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
