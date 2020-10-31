import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/views/components/basic_info_screen.dart';
import 'package:student_finder_rnw/views/components/drawer.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  StudentController studentController = Get.find();
  int _selectedBottomIndex = 0;

  int _currentPageIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("RWn. ${facultyDetail.user_name}"),
      //   centerTitle: true,
      // ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
              _selectedBottomIndex = index;
            });
          },
          children: <Widget>[
            BasicInfo(),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: BottomNavyBar(
        showElevation: true,
        selectedIndex: _selectedBottomIndex,
        onItemSelected: (int index) {
          setState(() {
            _selectedBottomIndex = index;
          });
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
            activeColor: Colors.redAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            title: Text("Admissions"),
            icon: Icon(Icons.info),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            title: Text("Remarks"),
            icon: Icon(Icons.assignment),
            activeColor: Colors.teal,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
