import 'package:flutter/material.dart';
import 'package:phone_state_i/phone_state_i.dart';
import 'MainDataPage.dart';
import '../helpers/NetworkHelper.dart';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';


GetIt locator = GetIt.asNewInstance();

class Call {
  void call(int num) => launch("tel:$num");
}

void setupLocator() {
  locator.registerSingleton(Call());
}

// for globally available data
class GRID{
  int number;

  static final GRID _appData = new GRID._internal();

  factory GRID() {
    return _appData;
  }
  GRID._internal();

}

final grid = GRID();

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  int number;

  Call _service = locator<Call>();

  StreamSubscription streamSubscription;

  Future<List> _futureStudent;
  MainDataPage mdp = MainDataPage();

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

//  validateAndCall() {
//    if (_formKey.currentState.validate()) {
//      _formKey.currentState.save();
//      print("Number: $number validated...");
//      // for calling
//      _service.call(number);
//    }
//  }

  validateAndGet() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
//      print("Number: $number validated...");
      setState(() {
        GRID g = GRID();
        g.number = number;
        _futureStudent = getStudent(number);
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
