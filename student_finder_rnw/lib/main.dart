import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/views/screens/course_details_screen.dart';
import 'package:student_finder_rnw/views/screens/home_screen.dart';
import 'package:student_finder_rnw/views/screens/login_screen.dart';
import 'package:student_finder_rnw/views/screens/splash_screen.dart';
import 'package:student_finder_rnw/views/screens/student/student_screen.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

/*
Red :- #e31e25
dark Blue :- #0b527e
Gray :- #e8e8e8
Dark Gray :- #dedede
Light gray  :- #fefefe
Black  :- #2b2a28
*/

// TODO: Add connectivity package for internet connectivity

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xff2b2a28),
    // navigation bar color
    statusBarColor: Color(0xff2b2a28),
    // status bar color
    statusBarBrightness: Brightness.dark,
    //status bar brightness
    statusBarIconBrightness: Brightness.light,
    //status barIcon Brightness
    systemNavigationBarDividerColor: Colors.redAccent,
    //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));

  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/course_details',
          page: () => CourseDetailsScreen(),
        ),
        GetPage(
          name: '/basic_info',
          page: () => StudentScreen(),
        ),
      ],
      theme: ThemeData(
        primaryColor: Color(0xff2b2a28),
        accentColor: Color(0xffe31e25),
      ),
    ),
  );
}
