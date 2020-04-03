import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentfollowup/helpers/PODO.dart';
import 'MainDataPage.dart';
import 'package:studentfollowup/helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';
import '../globals/StaffCredentials.dart';
import '../globals/StudentDetails.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';

Future<List> _futureStudent;
Future<List> _futureRemarkTypes;
Future<List> _futureRemarkAddedResponse;
MainDataPage mdp = MainDataPage();
int currentIndex = 0;

List<bool> isSelected = [];

List<String> statusItems = ["Low", "Medium", "High"];
int selectedStatusItem = 0;

final addRemarkForm = GlobalKey<FormState>();
String remarkField = "";

List rt = [];
List remarkTypeIntList = [];

var file;
var audioFile;

void sendRemarkDetails(context) {
  print("============= All Remark Details ===============");
  print("| GRID => ${grid.number}");
  print("| Added by => ${staffCredentials.userName}");
  print("| Remark Type => $isSelected");
  print("| Status => $selectedStatusItem");
  print("| Remark => $remarkField");
  print("==============================");
  remarkTypeIntList.clear();
  for (int i = 0; i < isSelected.length; i++) {
    if (isSelected[i] == true) {
      remarkTypeIntList.add(i + 1);
    }
  }
  _futureRemarkAddedResponse = getRemarkInsertedResponse(
      grid.number,
      staffCredentials.userName,
      remarkTypeIntList.join(","),
      selectedStatusItem,
      remarkField,
      audioFile);
  _futureRemarkAddedResponse.then((res) {
    if (res != null) {
      print("Res => $res");
      Fluttertoast.showToast(
          msg: "Remark Added Successfully.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Error: Remark not added",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  });
}

class RemarkTypeDialogue extends StatefulWidget {
  @override
  _RemarkTypeDialogueState createState() => _RemarkTypeDialogueState();
}

class _RemarkTypeDialogueState extends State<RemarkTypeDialogue> {
  getFutureRemarkTypes() async {
    await _futureRemarkTypes.then((v) {
      setState(() {
        rt = v;
        print("rt length => ${rt.length}");
        if (isSelected.isEmpty) {
          for (int j = 0; j < rt.length; j++) {
            isSelected.add(false);
          }
        } else {
          isSelected.clear();
          for (int j = 0; j < rt.length; j++) {
            isSelected.add(false);
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (_futureRemarkTypes == null) {
      _futureRemarkTypes = getRemarkTypes();
    }
    getFutureRemarkTypes();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Remark Type(s)"),
      content: Container(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: rt.length,
            itemBuilder: (context, i) {
              return CheckboxListTile(
                secondary: Text(rt[i].type_id),
                selected: isSelected[i],
                value: isSelected[i],
                onChanged: (bool val) {
                  setState(() {
                    isSelected[i] = !isSelected[i];
                  });
                },
                title: Text(rt[i].type_name),
              );
            }),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Select"),
          color: Colors.teal,
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancle"),
          color: Colors.blueGrey,
        )
      ],
    );
  }
}

class MainRemarkDialogue extends StatefulWidget {
  @override
  _MainRemarkDialogueState createState() => _MainRemarkDialogueState();
}

class _MainRemarkDialogueState extends State<MainRemarkDialogue> {
// START: audio related coding

  String statusText = "";
  bool isComplete = false;

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> map =
        await [Permission.storage, Permission.microphone].request();
    print(map[Permission.microphone]);
    return map[Permission.microphone] == PermissionStatus.granted;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      var recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Error--->$type";
        setState(() {});
      });
    } else {
      statusText = "Permission not available.";
    }
    setState(() {});
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Recording Complete.";
      isComplete = true;
      setState(() {
        audioFile = File(file);
      });
    }
  }

  int i = 0;
  Directory storageDirectory;

  Future<String> getFilePath() async {
    if (Platform.isAndroid) {
      storageDirectory = await getExternalStorageDirectory();
    }
    if (Platform.isIOS) {
      storageDirectory = await getApplicationDocumentsDirectory();
      print(storageDirectory);
    }
    // create a directory grid wise
    String sdPath = storageDirectory.path + "/${grid.number}";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    var dt = DateFormat("dd-MM-yyyy hh:mm:ss a").format(DateTime.now());
    print(sdPath + "/${dt}_${i++}.mp3");
    file = sdPath + "/${dt}_${i++}.mp3";
    return file;
  }

// END: audio related coding

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text("Add Remark"),
      content: Container(
        width: width - (width * 0.1),
        height: height - (height * 0.55),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "GRID: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      grid.number.toString(),
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Added By: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      staffCredentials.userName,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Remark Type: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(Icons.arrow_drop_down_circle),
                        onPressed: () {
                          showDialog(
                            context: context,
                            child: RemarkTypeDialogue(),
                          );
                        }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Status: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    DropdownButton(
                      items: statusItems.map((val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          if (val == "Low") {
                            selectedStatusItem = 0;
                          }
                          if (val == "Medium") {
                            selectedStatusItem = 1;
                          }
                          if (val == "High") {
                            selectedStatusItem = 2;
                          }
                        });
                      },
                      value: statusItems[selectedStatusItem],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Remark: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Form(
                        key: addRemarkForm,
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Add your Reamrk...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (val) {
                            if (val == null ||
                                val == "" ||
                                val == " " ||
                                val == ".") {
                              return "Enter non-empty or valid remark...";
                            }
                            return null;
                          },
                          onSaved: (val) {
                            setState(() {
                              remarkField = val;
                              print(remarkField);
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Audio Remark: ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold),
                    ),
                    FlatButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.microphone,
                        color: Colors.red,
                      ),
                      label: Text("Long Press"),
                      onLongPress: () async {
                        print("audio...");
                        startRecord();
                      },
                    ),
                  ],
                ),
                Text(statusText),
                (statusText == "Recording...")
                    ? FlatButton.icon(
                        icon: FaIcon(
                          FontAwesomeIcons.stop,
                          color: Colors.red,
                        ),
                        label: Text("Stop"),
                        onPressed: () async {
                          print("stop...");
                          stopRecord();
                        },
                      )
                    : Text(""),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (addRemarkForm.currentState.validate()) {
              addRemarkForm.currentState.save();
            }
            sendRemarkDetails(context);
            Navigator.pop(context);
          },
          child: Text("Add"),
          color: Colors.teal,
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancle"),
          color: Colors.blueGrey,
        )
      ],
    );
  }
}

class RemarksPage extends StatefulWidget {
  @override
  _RemarksPageState createState() => _RemarksPageState();
}

class _RemarksPageState extends State<RemarksPage> {
  Widget addRemarkButton() {
    return Opacity(
      opacity: 0.7,
      child: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
            context: context,
            child: MainRemarkDialogue(),
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
