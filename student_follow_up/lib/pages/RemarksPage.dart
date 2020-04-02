import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';
import '../globals/StaffCredentials.dart';
import '../globals/StudentDetails.dart';

class RemarksPage extends StatefulWidget {
  @override
  _RemarksPageState createState() => _RemarksPageState();
}

class _RemarksPageState extends State<RemarksPage> {
  Future<List> _futureStudent;
  Future<List> _futureRemarkTypes;
  MainDataPage mdp = MainDataPage();
  int currentIndex = 0;

  List<bool> isSelected = [];

  List<String> statusItems = ["Low", "Medium", "High"];
  int selectedStatusItem = 0;

  final addRemarkForm = GlobalKey<FormState>();
  String remarkField = "";

  Widget showRemarkList() {
    return FutureBuilder(
      future: _futureRemarkTypes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          for (int i = 1; i <= data.length; i++) {
            isSelected.add(false);
          }
          return Container(
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return CheckboxListTile(
                    secondary: Text(data[i].type_id),
                    selected: isSelected[i],
                    value: isSelected[i],
                    onChanged: (bool val) {
                      setState(() {
                        isSelected[i] = !isSelected[i];
                      });
                    },
                    title: Text(data[i].type_name),
                  );
                }),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget addRemarkButton() {
    return Opacity(
      opacity: 0.7,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
            context: context,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "GRID: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          TextSpan(
                            text: grid.number.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Added By: ",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          TextSpan(
                            text: staffCredentials.userName,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Remark Type: ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              _futureRemarkTypes = getRemarkTypes();
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text("Select Remark Types:"),
                                  content: showRemarkList(),
                                  actions: <Widget>[
                                    FlatButton(
                                      color: Colors.teal,
                                      child: Text("Select Type(s)"),
                                      onPressed: () {},
                                    ),
                                    FlatButton(
                                      color: Colors.black87,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancle"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Icon(Icons.arrow_drop_down_circle),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Status: ",
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        DropdownButton(
                          items: statusItems.map((v) {
                            return DropdownMenuItem<String>(
                              child: Text(v),
                              value: v,
                            );
                          }).toList(),
                          hint: Text("Select any status..."),
                          onChanged: (val) {
                            setState(() {
                              if (val == statusItems[0]) {
                                selectedStatusItem = 0;
                              } else if (val == statusItems[1]) {
                                selectedStatusItem = 1;
                              } else if (val == statusItems[2]) {
                                selectedStatusItem = 2;
                              }
                            });
                          },
                          value: statusItems[selectedStatusItem],
                        ),
                      ],
                    ),
                    Form(
                      key: addRemarkForm,
                        child: TextFormField(
                          maxLines: 2,
                          onSaved: (val){
                            setState(() {
                              remarkField = val;
                            });
                          },
                          validator: (val){
                            if(val==null || val.isEmpty || val=="" || val==" " || val=="."){
                              return "Enter non-empty or valid remark...";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Remark",
                            labelStyle: TextStyle(
                              color: Colors.teal,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              title: Text("Add Remark"),
              actions: <Widget>[
                FlatButton(
                  color: Colors.teal,
                  onPressed: () {
                    if(addRemarkForm.currentState.validate()){
                      addRemarkForm.currentState.save();
                      print(remarkField);
                    }
                  },
                  child: Text("Add Remark"),
                ),
                FlatButton(
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancle"),
                )
              ],
            ),
            barrierDismissible: false,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (grid.number == null) {
      setState(() {
        _futureStudent = null;
      });
    } else {
      setState(() {
        _futureStudent = getStudent(grid.number);
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          (_futureStudent == null)
              ? Expanded(
                  child: Center(
                    child: Text(
                      "Please select GRID first",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                )
              : Expanded(
                  child: mdp.getRemarksData(grid.number, _futureStudent),
                ),
        ],
      ),
      floatingActionButton: addRemarkButton(),
    );
  }
}
