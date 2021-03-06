import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rnw_job_portal/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecruiterLoginScreen extends StatefulWidget {
  RecruiterLoginScreen({Key key}) : super(key: key);

  @override
  _RecruiterLoginScreenState createState() => _RecruiterLoginScreenState();
}

class _RecruiterLoginScreenState extends State<RecruiterLoginScreen> {
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SplashScreen()));
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

      if (goBack) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>SplashScreen())); // If user press Yes pop the page
      return goBack;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBack(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => SplashScreen()));
                    },
                    splashColor: Colors.black,
                    highlightColor: Colors.black,
                    icon: Icon(Icons.home),
                    label: Text(
                      "RNW Job Portal".toUpperCase(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Colors.white,
                  ),
                ]),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
          ),
          body: Stack(
            children: <Widget>[
              InAppWebView(
                initialUrl: "https://demo.rnwmultimedia.com/recruiter/",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      debuggingEnabled: true,
                    )
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webView = controller;
                },
                onLoadStop: (InAppWebViewController controller, String url) async {
                  setState(() {
                    isLoading = false;
                  });
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
