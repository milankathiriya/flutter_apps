import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
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
            // List of Student Detail
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidEnvelope),
              title: Text(
                "Email",
                style: TextStyle(color: Colors.redAccent),
              ),
              subtitle: Text(
                studentController.email.value,
              ),
              trailing: (studentController.email.value != "-")
                  ? FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      tooltip: "Email Student",
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {},
                      child: FaIcon(
                        FontAwesomeIcons.solidEnvelope,
                        size: 22,
                      ),
                    )
                  : Text(""),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.phoneAlt),
              title: Text(
                "Mobile",
                style: TextStyle(color: Colors.redAccent),
              ),
              subtitle: Text(studentController.mobile.value),
              trailing: Wrap(
                children: (studentController.mobile.value != "-")
                    ? [
                        FloatingActionButton(
                          tooltip: "Call Student",
                          heroTag: null,

                          mini: true,
                          backgroundColor: Colors.blue,
                          child: FaIcon(
                            FontAwesomeIcons.phoneAlt,
                            size: 22,
                          ),
                          // TODO: Add calling functionality
                          onPressed: () {},
                        ),
                        FloatingActionButton(
                          tooltip: "WhatsApp Student",
                          heroTag: null,

                          mini: true,
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 25,
                          ),
                          // TODO: Add whatsapp functionality
                          onPressed: () {},
                        ),
                      ]
                    : [Text("")],
              ),
            ),
            Container(
              height: Get.height * 0.02,
              color: Colors.grey[200],
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.userAlt),
              title: Text(
                "Father Name",
                style: TextStyle(color: Colors.redAccent),
              ),
              subtitle: Text(studentController.father_name.value),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.phoneAlt),
              title: Text(
                "Father Contact",
                style: TextStyle(color: Colors.redAccent),
              ),
              subtitle: Text(studentController.father_mobile.value),
              trailing: Wrap(
                children: (studentController.father_mobile.value != "-")
                    ? [
                        FloatingActionButton(
                          tooltip: "Call Father",
                          heroTag: null,

                          mini: true,
                          backgroundColor: Colors.blue,
                          child: FaIcon(
                            FontAwesomeIcons.phoneAlt,
                            size: 22,
                          ),
                          // TODO: Add calling functionality
                          onPressed: () {},
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          tooltip: "WhatsApp Father",
                          mini: true,
                          backgroundColor: Colors.green,
                          child: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 25,
                          ),
                          // TODO: Add whatsapp functionality
                          onPressed: () {},
                        ),
                      ]
                    : [Text("")],
              ),
            ),
            Container(
              height: Get.height * 0.02,
              color: Colors.grey[200],
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.addressCard),
              title: Text(
                "Address",
                style: TextStyle(color: Colors.redAccent),
              ),
              subtitle: Text(studentController.address.value),
            ),
            Container(
              height: Get.height * 0.1,
              color: Colors.grey[200],
            ),
          ],
        ),
      ),
    );
  }
}
