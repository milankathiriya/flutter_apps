import 'package:flutter/material.dart';
import 'DBModel.dart';
import 'DBHelper.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController controller;
  String name;
  var dbHelper;
  Future users;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      User u = User(null, name);
//      dbHelper.save(u);
      var res = dbHelper.save(u);
      res.then((res) {
        scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('Success! Record Inserted!')));
      }).catchError((e) {
        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(e)));
      });
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onSaved: (val) {
              setState(() {
                name = val;
              });
            },
            validator: (val) =>
                (val.length == 0 || val == null) ? "Enter Name" : null,
          ),
        ],
      ),
    );
  }

  refreshList() {
    setState(() {
      users = dbHelper.getUsers();
    });
  }

  dataTable(List users) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(label: Text("ID")),
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("DELETE")),
        ],
        rows: users.map((user) {
          return DataRow(cells: [
            DataCell(
              Text(user.id.toString()),
            ),
            DataCell(Text(user.name), onTap: () {}),
            DataCell(IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  dbHelper.delete(user.id);
                  refreshList();
                  scaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text("Record deleted!"),
                  ));
                })),
          ]);
        }).toList(),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: dbHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null) {
            return Text("No data found...");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("SQFLITE"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            form(),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              child: Text("Insert"),
              onPressed: validate,
              color: Colors.blue,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 30,
            ),
            list(),
          ],
        ),
      ),
    );
  }
}
