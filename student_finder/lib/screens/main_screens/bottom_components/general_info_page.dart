import 'package:flutter/material.dart';
import 'package:student_finder/services/auth_service.dart';

class GeneralInfoPage extends StatefulWidget {
  GeneralInfoPage({Key key}) : super(key: key);

  @override
  _GeneralInfoPageState createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  final _studentFindingFormKey = GlobalKey<FormState>();
  TextEditingController _gridController = TextEditingController();
  int _grid;
  bool _autovalidate = false;
  var fetchedData;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return ListView(
      children: [
        gridForm(),
        getStudentData(),
      ],
    );
  }

  Widget gridForm() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Form(
        key: _studentFindingFormKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: TextFormField(
                controller: _gridController,
                autovalidate: _autovalidate,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val.isEmpty || val == null || val == "") {
                    return "Enter any GRID";
                  } else if (val.contains(RegExp(r'[a-zA-Z_.+-]+'))) {
                    return "Enter only numeric value";
                  }
                  return null;
                },
                onSaved: (val) {
                  setState(() {
                    _grid = int.parse(val);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "Enter GRID",
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FloatingActionButton(
                child: Icon(Icons.cloud_download),
                backgroundColor: Colors.red,
                onPressed: validateGRIDAndFetchData,
              ),
            ),
          ],
        ),
      ),
    );
  }

  validateGRIDAndFetchData() async {
    if (_studentFindingFormKey.currentState.validate()) {
      _studentFindingFormKey.currentState.save();
      print(_grid.toString());
      fetchedData = await authService.getStudentData(grid: _grid);
      print(fetchedData);
      // ans.forEach((element) {
      //   print(element.remarks);
      //   print("\n\n--------\n\n");
      // });
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  Widget getStudentData() {
    return (_grid != null)
        ? FutureBuilder(
            future: authService.getStudentData(grid: _grid),
            builder: (context, ss) {
              double _width = MediaQuery.of(context).size.width;
              double _height = MediaQuery.of(context).size.height;
              if (ss.hasData) {
                if (ss.data != null) {
                  var data = ss.data;
                  return Column(
                    children: [
                      // TODO: student_pic, student_name, student_grid widget

                      Container(
                        height: _height * 0.15,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              // FIXME: if image not found then 404 occurs
                              backgroundImage: NetworkImage(
                                "http://demo.rnwmultimedia.com/eduzila_api${data.first.image}",
                              ),
                            ),
                            VerticalDivider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            SizedBox(width: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\bGRID: ",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _grid.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Name: \n",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${data.first.fname} ${data.first.lname}",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TODO: student details widget
                      Container(
                        height: _height * 0.53,
                        width: _width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Column(
                          children: [
                            Text("lo"),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Text("No Data");
              }
              return CircularProgressIndicator();
            })
        : Container();
  }
}
