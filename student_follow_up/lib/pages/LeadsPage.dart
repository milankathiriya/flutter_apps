import 'package:flutter/material.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';
import '../globals/StudentDetails.dart';
import '../globals/StaffCredentials.dart';

class LeadsPage extends StatefulWidget {

  @override
  _LeadsPageState createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  Future _futureStudent;
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
        _futureStudent = getLeads(staffCredentials.userName);
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
            child: mdp.getLeadsData(grid.number, _futureStudent),
          ),
        ],
      ),
    );
  }
}
