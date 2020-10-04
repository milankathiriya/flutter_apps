import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_finder/globals/student.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String email = "";
  String uname = "";

  @override
  void initState() {
    super.initState();
    if (email == "" || uname == "") {
      checkPrefs();
    }
  }

  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
      uname = prefs.getString('uname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DrawerHeader(
            child: CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("assets/images/rnw_pic.png"),
            ),
          ),
          Divider(
            indent: 15,
            endIndent: 15,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "RWn. $uname",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
            icon: Icon(Icons.power_settings_new),
            label: Text(
              "Logout",
              style: TextStyle(fontSize: 16),
            ),
            backgroundColor: Color(0xff2b2a28),
            onPressed: showDialogAndLogout,
          ),
        ],
      ),
    );
  }

  showDialogAndLogout() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure to want to logout?"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"),
                textColor: Colors.black,
                color: Colors.grey[300],
              ),
              FlatButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  studentGlobal = StudentGlobal();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login', (route) => false);
                },
                child: Text("Yes"),
                textColor: Colors.red,
                color: Colors.grey[300],
              ),
            ],
          );
        });
  }
}
