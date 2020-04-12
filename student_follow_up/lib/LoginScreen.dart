import 'package:flutter/material.dart';
import 'package:studentfollowup/MainScreen.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'helpers/AuthService.dart';
import 'package:email_validator/email_validator.dart';
import 'globals/StaffCredentials.dart';

AuthService appAuth = AuthService();

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _status = 'no-action';
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
            staffCredentials.user_type = res[0].user_type ?? "";
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

  Future<bool> onBackButtonPressed() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Student Follow Up'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 65,
                    backgroundImage: AssetImage('assets/images/rnw_pic.png'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Red and White Group of Institute",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
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
                              contentPadding: EdgeInsets.all(15),
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
                            style: TextStyle(fontSize: 18),
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
                                style: TextStyle(fontSize: 16, color: Colors.red),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
