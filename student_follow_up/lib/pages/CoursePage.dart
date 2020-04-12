import 'package:flutter/material.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';
import '../globals/StudentDetails.dart';
import '../globals/StaffCredentials.dart';

class CoursePage extends StatefulWidget {
  int i;

  CoursePage([this.i]);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  Future<List> _futureStudent;
  MainDataPage mdp = MainDataPage();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    if (grid.number == null) {
      setState(() {
        _futureStudent = null;
      });
    } else {
      print("widget.i => ${widget.i}");
      setState(() {
        _futureStudent = getStudent(grid.number, widget.i);
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          (_futureStudent == null)
              ? Expanded(
                  child: Center(
                    child: Text(
                      "Please select GRID first",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                )
              : Expanded(
                  child: mdp.getCourseData(grid.number, _futureStudent),
                ),
        ],
      ),
    );
  }
}
