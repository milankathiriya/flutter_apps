import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_finder_rnw/controllers/auth_controller.dart';
import 'package:student_finder_rnw/helpers/device_information.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var emailBox;
  var passBox;

  AuthController _authController = AuthController();

  final Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;
  String internetStatus = "unknown internet status";

  // TODO: fix internet connectivity funcionality
  checkConnection() async {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print("internet status res => ${result}");
      if (result == ConnectivityResult.none) {
        setState(() {
          internetStatus = "Disconnected from Internet...";
        });
        Get.snackbar(internetStatus, internetStatus);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    checkConnection();
    print(internetStatus);

    setState(() {
      emailBox = GetStorage().read('email');
      passBox = GetStorage().read('password');

      print(emailBox);
      print(passBox);
    });

    if (emailBox != null && passBox != null) {
      loginFaculty(emailBox, passBox).then((res) {
        if (res == 1) {
          Timer(
            Duration(milliseconds: 1800),
            () => Get.offAllNamed('/'),
          );
        } else {
          Timer(
            Duration(milliseconds: 1800),
            () => Get.offAllNamed('/login'),
          );
        }
      });
    } else {
      Timer(
        Duration(milliseconds: 1800),
        () => Get.offAllNamed('/login'),
      );
    }
  }

  @override
  dispose() {
    super.dispose();
    // subscription.cancel();
  }

  loginFaculty(email, password) async {
    var deviceToken =
        await DeviceInformation.deviceInformation.getDeviceToken();
    var res = await _authController.login(email, password, deviceToken);
    print("RES => $res");
    return (res == false) ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/ic_logo.png",
              height: Get.height * 0.25,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Text(
              "Student Finder",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
