import 'package:flutter/material.dart';
import 'package:student_finder/globals/student.dart';
import 'package:student_finder/models/StudentModel.dart';

class RemarksPage extends StatefulWidget {
  RemarksPage({Key key}) : super(key: key);

  @override
  _RemarksPageState createState() => _RemarksPageState();
}

class _RemarksPageState extends State<RemarksPage> {
  @override
  Widget build(BuildContext context) {
    var remarks = studentGlobal.remarks;
    List a = remarks
        .map(
          (e) => StudentModel(remark: e['remark'], remark_by: e['remark_by']),
        )
        .toList();
    return (studentGlobal.grid != "")
        ? Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
              ),
            ),
            child: ListView.separated(
                itemCount: a.length,
                separatorBuilder: (_, __) {
                  return Divider(
                    indent: 15,
                    endIndent: 15,
                  );
                },
                itemBuilder: (_, i) {
                  return ListTile(
                    leading: Text(
                      "${i + 1}",
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    title: Text(
                      "${a[i].remark_by}",
                      style: TextStyle(color: Colors.teal, fontSize: 16),
                    ),
                    subtitle: Text(
                      "${a[i].remark}",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
          )
        : Center(
            child: Text("Please enter GRID first..."),
          );
  }
}
