import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_finder_rnw/controllers/dept_branch_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';

class MyDrawer extends StatefulWidget {
  final FocusNode node;

  MyDrawer({Key key, this.node}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  DeptBranchController deptBranchController = DeptBranchController();

  @override
  void initState() {
    super.initState();
    if (widget.node != null) {
      widget.node.unfocus();
    }
  }

  @override
  void dispose() {
    if (widget.node != null) {
      widget.node.unfocus();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            CircleAvatar(
              radius: Get.height * 0.09,
              backgroundImage: NetworkImage(
                facultyDetail.image,
              ),
            ),
            Spacer(),
            Text(
              "RWn. " + facultyDetail.user_name,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Text(
              facultyDetail.email,
              style: TextStyle(color: Colors.blueGrey),
            ),
            Spacer(),
            Divider(
              color: Colors.red,
              indent: 35,
              endIndent: 35,
            ),
            Spacer(),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.people),
              title: Text(facultyDetail?.role ?? "demo"),
              subtitle: Text("Role"),
            ),
            // Divider(color: Colors.grey, indent: 70, endIndent: 35,),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.call),
              title: Text(facultyDetail?.phone ?? "123"),
              subtitle: Text("Contact"),
            ),
            // Divider(color: Colors.grey, indent: 70, endIndent: 35,),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.account_balance),
              // title: getDepartment(),
              title: Text(facultyDetail?.department ?? "COMPUTER"),
              subtitle: Text("Department"),
            ),
            // Divider(color: Colors.grey, indent: 70, endIndent: 35,),
            ListTile(
              onTap: () {},
              leading: Icon(Icons.location_city),
              // title: getBranch(),
              title: Text(facultyDetail?.branch ?? "SARTHANA"),
              subtitle: Text("Branch"),
            ),
            ListTile(
              onTap: () {
                Get.back();
                Get.toNamed('/course_details');
              },
              leading: Icon(Icons.assignment),
              title: Text("Course Details"),
              subtitle: Text("Course"),
            ),
            // Divider(color: Colors.grey, indent: 70, endIndent: 35,),
            Spacer(),
            ListTile(
              tileColor: Theme.of(context).accentColor,
              onTap: logout,
              leading: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() {
    Get.defaultDialog(
      title: "Are you sure to logout?",
      content: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(15),
        child: Text("Note: You can only login again to this device only."),
      ),
      cancel: FlatButton(
        child: Text("No"),
        onPressed: () {
          Get.back();
        },
      ),
      confirm: FlatButton(
        child: Text("Yes"),
        onPressed: () {
          GetStorage().erase();
          Get.offAllNamed('/login');
        },
      ),
    );
  }
}
