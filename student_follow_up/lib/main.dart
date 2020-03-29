import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studentfollowup/MainScreen.dart';
import 'package:studentfollowup/SplashScreen.dart';
import 'pages/HomePage.dart';

void main() {
  setupLocator();
  runApp(MaterialApp(
//    home: MyApp(),
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black,
      primarySwatch: Colors.red,
    ),
  ));
}
