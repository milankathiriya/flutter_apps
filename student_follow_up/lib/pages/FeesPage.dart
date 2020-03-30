import 'package:flutter/material.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';

class FeesPage extends StatefulWidget {
  @override
  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
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
      setState(() {
        _futureStudent = getStudent(grid.number);
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
                  child: mdp.getFeesData(grid.number, _futureStudent),
                ),
        ],
      ),
    );
  }
}
