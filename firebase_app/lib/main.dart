import 'package:flutter/material.dart';
import 'services/auth.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService _auth = AuthService();

  var loggedIn = false;

  var userStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase App"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Sign In"),
              color: Colors.deepOrange,
              textColor: Colors.white,
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print("Error signing in...");
                } else {
                  setState(() {
                    loggedIn = true;
                    userStatus = result.uid;
                  });
                  print(result.uid);
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(userStatus),
            SizedBox(
              height: 30,
            ),
            (loggedIn)
                ? RaisedButton(
                    child: Text("Sign Out"),
                    color: Colors.deepOrangeAccent,
                    textColor: Colors.white,
                    onPressed: () async {
                      var res = await _auth.signOut();
                      setState(() {
                        loggedIn = false;
                        userStatus = "";
                      });
                    },
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
