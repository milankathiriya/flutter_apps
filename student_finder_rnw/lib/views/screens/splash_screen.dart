import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_finder_rnw/controllers/auth_controller.dart';
import 'package:student_finder_rnw/helpers/check_internet.dart';
import 'package:student_finder_rnw/helpers/device_information.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var emailBox;
  var passBox;

  AuthController _authController = AuthController();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  String _connectionStatus = 'Unknown';

  // TODO: fix internet connectivity funcionality

  @override
  void initState() {
    super.initState();

    initialize();
  }

  initialize(){
    // setState(() {
      emailBox = GetStorage().read('email');
      passBox = GetStorage().read('password');

      print(emailBox);
      print(passBox);
    // });

    isInternet().then((value) {
      print("isInternet => ${value}");
      if (value == true) {
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
      } else {
        Get.snackbar(
          "No internet",
          "No connection",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          leftBarIndicatorColor: Colors.redAccent,
          borderRadius: 2,
          isDismissible: false,
          margin: EdgeInsets.all(8),
          icon: Icon(
            Icons.airplanemode_active,
            color: Colors.white,
          ),
          duration: Duration(seconds: 18),
        );
      }
    });
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
      body: StreamBuilder(
          stream: DataConnectionChecker().onStatusChange,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var result = snapshot.data;
            switch (result) {
              case DataConnectionStatus.disconnected:
                print("no net");
                return Center(child: Text("No Internet Connection!"));
              case DataConnectionStatus.connected:
                print("yes net");
                initialize();
                return Container(
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
                );
              default:
                return Center(child: Text("No Internet Connection!"));
            }
          }),
    );
  }
}
