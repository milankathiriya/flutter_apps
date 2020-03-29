import 'package:flutter/material.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import 'HomePage.dart';

class RemarksPage extends StatefulWidget {

  @override
  _RemarksPageState createState() => _RemarksPageState();
}

class _RemarksPageState extends State<RemarksPage> {

  Future<List> _futureStudent;
  MainDataPage mdp = MainDataPage();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    print(grid.number);

    _futureStudent = getStudent(grid.number);

    return Scaffold(
      body: Column(
        children: <Widget>[
          (_futureStudent == null)
              ? Expanded(child: Text("no"))
              : Expanded(
            child: mdp.getRemarksData(grid.number, _futureStudent),
          ),

        ],
      ),
    );
  }
}
