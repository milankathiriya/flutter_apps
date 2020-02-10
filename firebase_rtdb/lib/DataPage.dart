import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DataPage extends StatefulWidget {
  final List records;

  const DataPage({Key key, this.records}): super(key: key);

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Data"),
      ),
      body:  Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text("$index"),
              title: Text("${widget.records[index].name}"),
              subtitle: Text("${widget.records[index].address}"),

            );
          },
          itemCount: widget.records.length,
        ),
      )
    );
  }
}
