import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_finder/models/LoginModel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uname_prefs;

  checkPrefsForUname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uname_prefs = prefs.getString('uname');
    });
  }

  @override
  void initState() {
    super.initState();
    checkPrefsForUname();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard - ${uname_prefs ?? 'No User'}"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
