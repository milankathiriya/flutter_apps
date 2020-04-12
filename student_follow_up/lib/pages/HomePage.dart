import 'package:flutter/material.dart';
import 'package:phone_state_i/phone_state_i.dart';
import 'MainDataPage.dart';
import '../helpers/NetworkHelper.dart';
import 'dart:async';
import '../globals/GRID.dart';

int number;

StreamSubscription streamSubscription;

Future<List> _futureStudent;
MainDataPage mdp = MainDataPage();

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    streamSubscription =
        phoneStateCallEvent.listen((PhoneStateCallEvent event) {
          print('Call is Incoming or Connected: ' + event.stateC);
          //event.stateC has values "true" or "false"
        });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  validateAndGet() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        grid.number = number;
        _futureStudent = getStudent(number);
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 4,
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.perm_identity),
                              hintText: "Enter GRID",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {

                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              else if(int.parse(value) <= 0){
                                return 'Enter only positive number';
                              }
                              try{
                                number = int.parse(value);
                              }
                              catch(e){
                                return 'Enter only numeric value';
                              }
                              setState(() {
                                number = int.parse(value);
                              });
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          flex: 1,
                          child: FloatingActionButton(
                            child: Icon(Icons.cloud_download),
                            onPressed: validateAndGet,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          (_futureStudent == null)
              ? Expanded(child: Text(""))
              : Expanded(
            child: mdp.getData(number, _futureStudent),
          ),
        ],
      ),
    );
  }
}
