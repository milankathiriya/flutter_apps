import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rnw_job_portal/pages/recruiter_login_page.dart';
import 'package:rnw_job_portal/pages/rectuiter_register_page.dart';
import 'package:rnw_job_portal/pages/student_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white, // Color for Android
      statusBarBrightness:
          Brightness.dark // Dark == white status bar -- for IOS.
      ));

  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
      ),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  InAppWebViewController webView;

  Future<bool> _onBack() async {
    bool goBack;
    var value = await webView.canGoBack(); // check webview can go back

    if (value) {
      webView.goBack(); // perform webview back operation
      return false;
    } else {
      await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title:
              new Text('Confirmation ', style: TextStyle(color: Colors.purple)),
          // Are you sure?
          content: new Text('Do you want exit app ? '),
          // Do you want to go back?
          actions: <Widget>[
            new FlatButton(
              onPressed: () {
                if (Platform.isAndroid) {
                  try {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } catch (e) {
                    SystemNavigator.pop();
                  }
                }
                if (Platform.isIOS) {
                  try {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  } catch (e) {
                    SystemNavigator.pop();
                    exit(0);
                  }
                }
                Navigator.of(context).pop();
                setState(() {
                  goBack = true;
                });
              },
              child: new Text('Yes'), // No
            ),
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                setState(() {
                  goBack = false;
                });
              },
              child: new Text('No'), // Yes
            ),
          ],
        ),
      );

      if (goBack) Navigator.of(context).pop(); // If user press Yes pop the page
      return goBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBack(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InAppWebView(
                initialUrl:
                    "https://demo.rnwmultimedia.com/placement/index.php",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                  debuggingEnabled: true,
                )),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    isLoading = false;
                  });
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  switch (url) {
                    case 'https://demo.rnwmultimedia.com/student_placement/':
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => StudentScreen()));
                      break;
                    case 'https://demo.rnwmultimedia.com/recruiter/':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RecruiterLoginScreen()));
                      break;
                    case 'https://demo.rnwmultimedia.com/recruiter/recruiter_register.php':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => RecruiterRegisterScreen()));
                      break;
                  }
                },
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
