import 'DataPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Model.dart';

void main() {
  return runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final formKey = GlobalKey<FormState>();
  String _name;
  String _address;
  final databaseReference = FirebaseDatabase.instance.reference();
  List records = [];

  void insertRecord() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      databaseReference
          .child("peoples")
          .push()
          .set({'name': _name, 'address': _address}).then((res) {
        formKey.currentState.reset();
      });
    }
  }

  void getData() async {
    FirebaseDatabase.instance
        .reference()
        .child("peoples")
        .once()
        .then((DataSnapshot snapshot) async {
      print('Data : ${snapshot.value}');
      var keys = await snapshot.value.keys;
      var data = await snapshot.value;
      records.clear();
      for (var key in keys) {
        Model m = new Model(data[key]['name'], data[key]['address']);
        records.add(m);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return DataPage(records: records);
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Real Time DataBase"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
                    icon: Icon(Icons.people),
                  ),
                  validator: (val) {
                    return (val.isEmpty) ? "Fill up name..." : null;
                  },
                  onSaved: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Address",
                    icon: Icon(Icons.location_on),
                  ),
                  validator: (val) {
                    return (val.isEmpty) ? "Fill up address..." : null;
                  },
                  onSaved: (val) {
                    setState(() {
                      _address = val;
                    });
                  },
                ),
                RaisedButton.icon(
                  onPressed: insertRecord,
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text("Insert Record"),
                ),
                RaisedButton.icon(
                  onPressed: getData,
                  icon: Icon(Icons.arrow_forward_ios),
                  label: Text("Get Records"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
