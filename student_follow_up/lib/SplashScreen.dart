import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studentfollowup/LoginScreen.dart';
import 'package:studentfollowup/MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/rnw_without_bg.png',
                height: 150,
                width: 150,
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Student Follow Up",
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
