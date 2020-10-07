import 'package:flutter/material.dart';
import 'package:student_finder/screens/intro_screens/login_screen.dart';
import 'package:student_finder/screens/intro_screens/splash_screen.dart';
import 'package:student_finder/screens/main_screens/home_screen.dart';

/*
Red :- #e31e25
dark Blue :- #0b527e
Gray :- #e8e8e8
Dark Gray :- #dedede
Light gray  :- #fefefe
Black  :- #2b2a28
 */

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff2b2a28),
          accentColor: Color(0xffe31e25),
        ),
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        }),
  );
}
