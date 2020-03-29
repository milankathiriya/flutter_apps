import 'package:flutter/material.dart';
import 'package:studentfollowup/MainScreen.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'helpers/AuthService.dart';
import 'package:email_validator/email_validator.dart';

AuthService appAuth = AuthService();

// for globally available data
class StaffCredentials {
  String email;
  String userName;

  static final StaffCredentials _appData = new StaffCredentials._internal();

  factory StaffCredentials() {
    return _appData;
  }

  StaffCredentials._internal();
}

final staffCredentials = StaffCredentials();

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _status = 'no-action';
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String email = "";
  String password = "";
  Future<dynamic> _futureStaff;
  bool loadingFlag = false;
  bool errorFlag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  validAndLogin() {
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      _futureStaff = getLoggedInResponse(email, password) ?? "";

      _futureStaff.then((res) {
        if (res == null) {
          setState(() {
            errorFlag = true;
            _loginFormKey.currentState.reset();
          });
        } else {
          setState(() {
            loadingFlag = true;
            staffCredentials.email = res[0].email ?? "";
            staffCredentials.userName = res[0].user_name ?? "";
          });
          if (staffCredentials.email != "" && staffCredentials.userName != "") {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) {
                return MainScreen(appAuth);
              }),
            );
          }
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Student Follow Up'),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(50),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/rnw_pic.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Red and White Group of Institute",
                    style: TextStyle(fontSize: 20, color: Colors.black87),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: "Enter Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || value == "" || value == null) {
                              return "Enter your email address";
                            } else if (!EmailValidator.validate(value)) {
                              return "Enter valid email address format";
                            }
                            setState(() {
                              email = value;
                            });
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: Icon(Icons.security),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: "Enter Password"),
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty || value == "" || value == null) {
                              return "Enter your password";
                            }
                            setState(() {
                              password = value;
                            });
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                          color: Colors.black,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: validAndLogin,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        (loadingFlag) ? CircularProgressIndicator() : Text(""),
                        (errorFlag)
                            ? Text(
                                "Provide valid credentials.",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
