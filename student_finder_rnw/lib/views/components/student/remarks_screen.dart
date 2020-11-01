import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';

class Remarks extends StatefulWidget {
  @override
  _RemarksState createState() => _RemarksState();
}

class _RemarksState extends State<Remarks> {
  StudentController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
            // List of Student Remarks
            Divider(),
            studentController.remarks.length == 1
                ? Container(
                    height: Get.height * 0.5,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.searchengin,
                          color: Colors.teal,
                          size: 35,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "No Any Remarks...",
                          style: TextStyle(color: Colors.teal, fontSize: 22),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children:
                        List.generate(studentController.remarks.length, (i) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Text(
                              "${i + 1}",
                              style: TextStyle(color: Colors.teal),
                            ),
                            title: Text(
                              studentController.remarks[i]['remark_by'] ?? "-",
                              style: TextStyle(color: Colors.teal),
                            ),
                            subtitle: Text(
                                studentController.remarks[i]['remark'] ?? "-"),
                            isThreeLine: true,
                            onTap: () {},
                            visualDensity: VisualDensity.comfortable,
                          ),
                          Divider(),
                        ],
                      );
                    }),
                  ),
          ],
        ),
      ),
    );
  }
}
