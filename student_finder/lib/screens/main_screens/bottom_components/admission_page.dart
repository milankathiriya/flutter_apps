import 'package:flutter/material.dart';
import 'package:student_finder/globals/student.dart';
import 'package:student_finder/models/StudentModel.dart';

class AdmissionPage extends StatefulWidget {
  AdmissionPage({Key key}) : super(key: key);

  @override
  _AdmissionPageState createState() => _AdmissionPageState();
}

class _AdmissionPageState extends State<AdmissionPage> {
  @override
  Widget build(BuildContext context) {
    return (studentGlobal.grid != "")
        ? DefaultTabController(
            length: studentGlobal.totalAdmissions,
            child: Column(
              children: [
                Container(
                  color: Color(0xff2b2a28),
                  alignment: Alignment.topCenter,
                  child: TabBar(
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    tabs: List.generate(
                      studentGlobal.totalAdmissions,
                      (i) => Tab(
                        child: Text(
                          "Admi. ${i + 1}",
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: List.generate(studentGlobal.totalAdmissions, (i) {
                      return CustomPageView(i);
                    }),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Text("Please enter GRID first..."),
          );
  }

  Widget CustomPageView(int i) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.assignment_turned_in),
          title: Text(
            "Course Package",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.course_packages[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text(
            "Course",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.courses[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text(
            "Branch Name",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.branches[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text(
            "Admission Date",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.admission_dates[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.code),
          title: Text(
            "Admission Code",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.admission_codes[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.flag),
          title: Text(
            "Admission Status",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
          subtitle: Text(
            studentGlobal.admission_statuses[i],
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(
            "Total Fees",
            style: TextStyle(fontSize: 16, color: Colors.purple),
          ),
          subtitle: Text(
            studentGlobal.total_fees[i].toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text(
            "Paid Fees",
            style: TextStyle(fontSize: 16, color: Colors.purple),
          ),
          subtitle: Text(
            studentGlobal.paid_fees[i].toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
        ListTile(
          leading: Icon(Icons.attach_money),
          title: Text(
            "Remaining Fees",
            style: TextStyle(fontSize: 16, color: Colors.purple),
          ),
          subtitle: Text(
            studentGlobal.remaining_fees[i].toString(),
            style: TextStyle(fontSize: 16),
          ),
        ),
        Divider(
          indent: 15,
          endIndent: 15,
        ),
      ],
    );
  }
}
