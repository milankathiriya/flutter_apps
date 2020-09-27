import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key key}) : super(key: key);

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  String email;
  String uname;

  @override
  void initState() {
    super.initState();
    if (email == null || uname == null) {
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
              radius: 80,
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            email,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            padding: EdgeInsets.all(12),
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 16),
            ),
            color: Colors.black,
            textColor: Colors.white,
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
