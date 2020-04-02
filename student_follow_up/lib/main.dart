import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studentfollowup/SplashScreen.dart';
import 'pages/MainDataPage.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
