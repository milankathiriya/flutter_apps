import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/views/components/my_header.dart';

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
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: new DecorationImage(
                          fit: BoxFit.contain,
                          image:
                              new NetworkImage(studentController.image.value),
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
                            studentController.total_admissions.value
                                .toString(),
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
          // No of Student Admission

          TabBar(
            controller: tabController,
            tabs:
                List.generate(studentController.total_admissions.value, (i) {
              return Tab(
                child: Text("Ad. ${i + 1}"),
              );
            }),
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
          TabBarView(
            controller: tabController,
            // FIXME: fix this issue
            children: [
              Container(child: Text("12")),
              Container(child: Text("12")),
              Container(child: Text("12")),
              Container(child: Text("12")),
            ],
          ),
        ],
      ),
    );
  }
}
