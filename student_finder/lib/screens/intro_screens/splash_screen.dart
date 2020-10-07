import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_finder/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkPrefs();
  }

  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Timer(Duration(milliseconds: 2000), () async {
      if (prefs.containsKey('email') && prefs.containsKey('pass')) {
        String e = prefs.getString('email');
        String p = prefs.getString('pass');
        var ans = await authService.getLoggedInResponse(e, p);
        if (ans != null && ans.userEmail.isNotEmpty) {
          print("success login...");
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          print("login failed...");
        }
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/rnw_without_bg.png',
                width: _width,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Student Finder",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
