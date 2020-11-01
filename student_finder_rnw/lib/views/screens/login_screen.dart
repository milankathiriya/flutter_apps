import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_finder_rnw/controllers/auth_controller.dart';
import 'package:student_finder_rnw/helpers/device_information.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final passwordFocus = FocusNode();

  String email;
  String password;

  String deviceToken;

  AuthController _authController = Get.put(AuthController());

  bool _successLogin = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  getToken() async {
    deviceToken = await DeviceInformation.deviceInformation.getDeviceToken();
    print(deviceToken);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height*0.885,
          child: Column(
            children: [
              Spacer(flex: 1,),
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/rnw.jpg"),
              ),
              Spacer(flex: 3,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter Email Address...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (val){
                              FocusScope.of(context).requestFocus(passwordFocus);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter your email address",
                              labelText: "Email",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.020,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: passwordFocus,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            obscureText: true,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Enter Password...";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () async {
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              var res = await validateAndLogin();
                              print(res);
                              if (res == 1) {
                                setState(() {
                                  _isLoading = true;
                                });
                                GetStorage().writeIfNull('email', email);
                                GetStorage().writeIfNull('password', password);
                                Get.offAllNamed('/');
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.security),
                              hintText: "Enter your password",
                              labelText: "Password",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  30,
                                ),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.020,
                          ),
                          (_isLoading == false)
                              ? FloatingActionButton.extended(
                                  icon: Icon(Icons.login_rounded),
                                  backgroundColor: Theme.of(context).primaryColor,
                                  onPressed: () async {
                                    var res = await validateAndLogin();
                                    print(res);
                                    if (res == 1) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      GetStorage().writeIfNull('email', email);
                                      GetStorage().writeIfNull('password', password);
                                      Get.offAllNamed('/');
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  label: Text("Login"),
                                )
                              : CircularProgressIndicator(),
                          SizedBox(
                            height: Get.height * 0.020,
                          ),
                          Obx(() {
                            return (_authController.success.value == false)
                                ? Text(
                                    _authController.msg.value,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.red),
                                  )
                                : Text("");
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 1,),
            ],
          ),
        ),
      ),
    );
  }

  validateAndLogin() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_loginFormKey.currentState.validate()) {
      _loginFormKey.currentState.save();

      var res = await _authController.login(email, password, deviceToken);
      print("RES => $res");
      return (res == false) ? 0 : 1;
    }
    // return 0;
  }
}
