import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:studentfollowup/LoginScreen.dart';
import 'package:studentfollowup/globals/StudentDetails.dart';
import 'pages/HomePage.dart';
import 'pages/CoursePage.dart';
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

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int counter = 0;
  int totalTabBarView = 1;

  final bottomNavyBarKey = GlobalKey();

  TabController tabController;

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
        (totalTabBarView == null)
            ? CoursePage()
            : TabBarView(
                controller: tabController,
                children: List.generate(totalTabBarView, (i) {
                  print("tab i => $i");
                  return CoursePage(i);
                }),
              ),
        RemarksPage(),
      ],
    );
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
    )) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      tabController = TabController(
          length: studentDetails.admissionLength ?? 1, vsync: this);
      totalTabBarView = studentDetails.admissionLength;
    });
    return WillPopScope(
      onWillPop: onBackButtonPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RWn. ${staffCredentials.userName}"),
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: (counter == 1 && studentDetails.admissionLength != null)
              ? TabBar(
                  controller: tabController,
                  tabs: List.generate(studentDetails.admissionLength, (i) {
                    return Tab(
                      child: Text("Admission\n       ${i + 1}"),
                    );
                  }),
                  labelColor: Colors.blue,
                  indicatorColor: Colors.blue,
                )
              : null,
        ),
        body: SafeArea(
          child: allPages(),
        ),
        bottomNavigationBar: BottomNavyBar(
          key: bottomNavyBarKey,
          selectedIndex: counter,
          showElevation: true,
          itemCornerRadius: 20,
          curve: Curves.easeInBack,
          onItemSelected: (index) {
            setState(() {
              counter = index;
              if (Platform.isAndroid) {
                _pageController.jumpToPage(
                  counter,
                );
              } else {
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
      ),
    );
  }
}
