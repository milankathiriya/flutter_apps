import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:studentfollowup/LoginScreen.dart';
import 'pages/HomePage.dart';
import 'pages/CoursePage.dart';
import 'pages/FeesPage.dart';
import 'pages/RemarksPage.dart';
import 'helpers/AuthService.dart';
import 'LoginScreen.dart';
import 'dart:io';
import 'globals/GRID.dart';
import 'globals/StaffCredentials.dart';

class MainScreen extends StatefulWidget {
  AuthService appAuth;

  MainScreen(this.appAuth);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int counter = 0;

  final bottomNavyBarKey = GlobalKey();

  Widget allPages() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          counter = index;
        });
        print(index);
      },
      children: <Widget>[
        // all pages indexed by bottom navigation bar's items
        HomePage(),
        CoursePage(),
        FeesPage(),
        RemarksPage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Follow Up"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: allPages(),
      bottomNavigationBar: BottomNavyBar(
        key: bottomNavyBarKey,
        selectedIndex: counter,
        showElevation: true,
        itemCornerRadius: 20,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            counter = index;
            if(Platform.isAndroid){
              _pageController.jumpToPage(
                counter,
              );
            }
            else{
              _pageController.animateToPage(
                counter,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInBack,
              );
            }

          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.deepOrange,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.info),
            title: Text('Course'),
            activeColor: Colors.blueAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Fees'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text(
              'Remarks',
            ),
            activeColor: Colors.teal,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/rnw_pic.png'),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "RWn. " + staffCredentials.userName ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  staffCredentials.email ?? "",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.power_settings_new),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.black87,
                  textColor: Colors.white,
                  onPressed: () {
                    widget.appAuth.logout().then((res) {
                      setState(() {
                        grid.number = null;
                      });
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    });
                  },
                  label: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
