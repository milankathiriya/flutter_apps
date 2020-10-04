import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:student_finder/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _autoValidate = false;
  bool _isLoading = false;
  bool _isLoginFailed = false;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Finder"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              CircleAvatar(
                radius: 65,
                backgroundImage: AssetImage('assets/images/rnw_pic.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Red and White Group of Institutes",
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _loginFormKey,
                autovalidate: _autoValidate,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.security),
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: "Enter Password",
                        ),
                        validator: (value) {
                          if (value.isEmpty || value == "" || value == null) {
                            return "Enter your password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: validateAndLogin,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (_isLoading) ? CircularProgressIndicator() : Container(),
                      (_isLoginFailed)
                          ? Text(
                              "Provide valid credentials.",
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateAndLogin() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();
      var ans = await authService.getLoggedInResponse(email, password);
      if (ans != null && ans.userEmail.isNotEmpty) {
        print("success login...");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        prefs.setString('uname', ans.userName);
        prefs.setString('pass', password);
        setState(() {
          _isLoading = true;
          _isLoginFailed = false;
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        print("login failed...");
        setState(() {
          _isLoading = false;
          _isLoginFailed = true;
        });
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
