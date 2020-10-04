import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_finder/components/side_drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:student_finder/screens/main_screens/bottom_components/admission_page.dart';
import 'package:student_finder/screens/main_screens/bottom_components/general_info_page.dart';
import 'package:student_finder/screens/main_screens/bottom_components/remarks_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uname_prefs;
  int _currentBottomNavyBarItemIndex = 0;
  PageController _pageController;

  checkPrefsForUname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uname_prefs = prefs.getString('uname');
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    checkPrefsForUname();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("RWn. ${uname_prefs ?? 'No User'}"),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (i) {
              setState(() {
                _currentBottomNavyBarItemIndex = i;
              });
            },
            children: [
              GeneralInfoPage(),
              AdmissionPage(),
              RemarksPage(),
            ],
          ),
        ),
        drawer: SideDrawer(),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentBottomNavyBarItemIndex,
            curve: Curves.easeInOut,
            items: [
              BottomNavyBarItem(
                activeColor: Colors.red,
                inactiveColor: Colors.red,
                icon: Icon(Icons.home),
                title: Text("Home"),
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                activeColor: Colors.blue,
                inactiveColor: Colors.blue,
                icon: Icon(Icons.info),
                title: Text("Admission"),
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                activeColor: Colors.teal,
                inactiveColor: Colors.teal,
                icon: Icon(Icons.announcement),
                title: Text("Remarks"),
                textAlign: TextAlign.center,
              ),
            ],
            onItemSelected: (i) {
              setState(() {
                _currentBottomNavyBarItemIndex = i;
              });
              _pageController.animateToPage(_currentBottomNavyBarItemIndex,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
            }),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App?'),
            actions: <Widget>[
              Wrap(
                children: [
                  FlatButton(
                    child: Text("NO"),
                    textColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text("YES"),
                    textColor: Colors.pink,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        ) ??
        false;
  }
}
