import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_finder/globals/student.dart';
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
      margin: EdgeInsets.all(8),
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
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_studentFindingFormKey.currentState.validate()) {
      _studentFindingFormKey.currentState.save();

      fetchedData = await authService.getStudentData(grid: _grid);
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }

  void clearAllLists() {
    studentGlobal.course_packages.clear();
    studentGlobal.courses.clear();
    studentGlobal.branches.clear();
    studentGlobal.admission_dates.clear();
    studentGlobal.admission_codes.clear();
    studentGlobal.admission_statuses.clear();
    studentGlobal.total_fees.clear();
    studentGlobal.paid_fees.clear();
    studentGlobal.remaining_fees.clear();
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
                  studentGlobal.grid = _grid.toString();
                  int l = studentGlobal.totalAdmissions;
                  clearAllLists();
                  for (int i = 0; i < l; i++) {
                    var course_package = data[i].course_package != ""
                        ? data[i].course_package
                        : "-";
                    var course = data[i].course != "" ? data[i].course : "-";
                    var branch =
                        data[i].branch_name != "" ? data[i].branch_name : "-";
                    var admission_date = data[i].admission_date != ""
                        ? data[i].admission_date
                        : "-";
                    var admission_code = data[i].admission_code != ""
                        ? data[i].admission_code
                        : "-";
                    var admission_status = data[i].admission_status != ""
                        ? data[i].admission_status
                        : "-";
                    int total_fee = int.parse(
                        data[i].total_fee != "" ? data[i].total_fee : "0");
                    int paid_fee = int.parse(
                        data[i].paid_fee != "" ? data[i].paid_fee : "0");
                    var remaining_fee = total_fee - paid_fee;

                    studentGlobal.course_packages.add(course_package);
                    studentGlobal.courses.add(course);
                    studentGlobal.branches.add(branch);
                    studentGlobal.admission_dates.add(admission_date);
                    studentGlobal.admission_codes.add(admission_code);
                    studentGlobal.admission_statuses.add(admission_status);
                    studentGlobal.total_fees.add(total_fee);
                    studentGlobal.paid_fees.add(paid_fee);
                    studentGlobal.remaining_fees.add(remaining_fee);
                  }
                  studentGlobal.remarks = data.first.remarks;
                  return Column(
                    children: [
                      Container(
                        height: _height * 0.15,
                        margin: EdgeInsets.symmetric(horizontal: 8),
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
                                      studentGlobal.grid,
                                      // _grid.toString(),
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
                      // student details widget
                      Container(
                        height: _height * 0.535,
                        width: _width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                        ),
                        margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: ListView(
                          children: [
                            CustomListTile(
                              // TODO: Set email functionality via icon
                              title: "Email",
                              data: data.first.email,
                              icon: Icons.email,
                            ),
                            Divider(
                              indent: 15,
                              endIndent: 15,
                            ),
                            CustomListTile(
                              // TODO: Set call functionality via icon
                              // TODO: Set whatsapp functionality via icon

                              title: "Contact",
                              data: data.first.mobile,
                              icon: Icons.call,
                            ),
                            Divider(
                              indent: 15,
                              endIndent: 15,
                            ),
                            CustomListTile(
                              title: "Father Name",
                              data: data.first.father_name,
                              icon: Icons.account_circle,
                            ),
                            Divider(
                              indent: 15,
                              endIndent: 15,
                            ),
                            CustomListTile(
                              // TODO: Set call functionality via icon
                              // TODO: Set whatsapp functionality via icon

                              title: "Father Contact",
                              data: data.first.father_mobile,
                              icon: Icons.call,
                            ),
                            Divider(
                              indent: 15,
                              endIndent: 15,
                            ),
                            CustomListTile(
                              title: "Address",
                              data: data.first.address,
                              icon: Icons.location_on,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return Text("No Data");
              }
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            })
        : Container();
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key key,
    this.title,
    this.data,
    this.icon,
  }) : super(key: key);

  final title;
  final data;
  final icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.deepOrangeAccent,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        data,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
