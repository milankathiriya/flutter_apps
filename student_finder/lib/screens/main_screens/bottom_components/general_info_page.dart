import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_finder/globals/student.dart';
import 'package:student_finder/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class GeneralInfoPage extends StatefulWidget {
  GeneralInfoPage({Key key}) : super(key: key);

  @override
  _GeneralInfoPageState createState() => _GeneralInfoPageState();
}

class _GeneralInfoPageState extends State<GeneralInfoPage> {
  final _studentFindingFormKey = GlobalKey<FormState>();
  TextEditingController _gridController = TextEditingController();
  var fetchedData;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          gridForm(),
          getStudentData(),
        ],
      ),
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    studentGlobal.grid = val;
                  });
                },
                onFieldSubmitted: (val) => validateGRIDAndFetchData(),
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
    studentGlobal.alreadyLoaded = false;
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_studentFindingFormKey.currentState.validate()) {
      _studentFindingFormKey.currentState.save();
      fetchedData = await authService.getStudentData(grid: studentGlobal.grid);
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
    print("LOADED => ${studentGlobal.alreadyLoaded}");
    if (studentGlobal.alreadyLoaded) {
      return getHomePageData(context);
    } else if (studentGlobal.grid != "") {
      return FutureBuilder(
          future: authService.getStudentData(grid: studentGlobal.grid),
          builder: (context, ss) {
            if (ss.hasData) {
              if (ss.data != null) {
                var data = ss.data;
                studentGlobal.alreadyLoaded = true;
                studentGlobal.fname =
                    data.first.fname != "" ? data.first.fname : "-";
                studentGlobal.lname =
                    data.first.lname != "" ? data.first.lname : "-";
                studentGlobal.image =
                    data.first.image != "" ? data.first.image : "-";
                studentGlobal.email =
                    data.first.email != "" ? data.first.email : "-";
                studentGlobal.mobile =
                    data.first.mobile != "" ? data.first.mobile : "-";
                studentGlobal.father_name =
                    data.first.father_name != "" ? data.first.father_name : "-";
                studentGlobal.father_mobile = data.first.father_mobile != ""
                    ? data.first.father_mobile
                    : "-";
                studentGlobal.address =
                    data.first.address != "" ? data.first.address : "-";
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
                return getHomePageData(context);
              }
              return Text("No Data");
            }
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          });
    } else {
      return Container();
    }
  }

  Widget getHomePageData(context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
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
              SizedBox(
                width: _width * 0.01,
              ),
              CircleAvatar(
                radius: _height * 0.07,
                backgroundImage: _fetchImage(studentGlobal.image),
              ),
              VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "GRID: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: studentGlobal.grid,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Name: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "${studentGlobal.fname} ${studentGlobal.lname}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Admissions: ",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        height: 23,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          studentGlobal.totalAdmissions.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
            physics: BouncingScrollPhysics(),
            children: [
              CustomListTile(
                title: "Email",
                data: studentGlobal.email,
                icon: Icons.email,
                canEmail: true,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              CustomListTile(
                title: "Contact",
                data: studentGlobal.mobile,
                icon: Icons.call,
                canCallStudent: studentGlobal.mobile != "-" ? true : false,
                canWhatsAppStudent: studentGlobal.mobile != "-" ? true : false,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              CustomListTile(
                title: "Father Name",
                data: studentGlobal.father_name,
                icon: Icons.account_circle,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              CustomListTile(
                title: "Father Contact",
                data: studentGlobal.father_mobile,
                icon: Icons.call,
                canCallFather:
                    studentGlobal.father_mobile != "-" ? true : false,
                canWhatsAppFather:
                    studentGlobal.father_mobile != "-" ? true : false,
              ),
              Divider(
                indent: 15,
                endIndent: 15,
              ),
              CustomListTile(
                title: "Address",
                data: studentGlobal.address,
                icon: Icons.location_on,
              ),
            ],
          ),
        )
      ],
    );
  }

  _fetchImage(image) {
    if (image == "/Eduzilla_image/rnw.jpg") {
      return NetworkImage(
          "https://adviceco.com.au/wp-content/uploads/sites/683/2019/10/profile-icon-male-user-person-avatar-symbol-vector-20910833.png");
    } else {
      return NetworkImage("http://demo.rnwmultimedia.com/eduzila_api$image");
    }
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key key,
    this.title,
    this.data,
    this.icon,
    this.canEmail = false,
    this.canCallStudent = false,
    this.canCallFather = false,
    this.canWhatsAppStudent = false,
    this.canWhatsAppFather = false,
  }) : super(key: key);

  final title;
  final data;
  final icon;
  final canEmail;
  final canCallStudent;
  final canCallFather;
  final canWhatsAppStudent;
  final canWhatsAppFather;

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
      trailing: Wrap(
        children: [
          (canEmail)
              ? FloatingActionButton(
                  child: Icon(
                    Icons.email,
                  ),
                  backgroundColor: Colors.blueGrey,
                  mini: true,
                  tooltip: "Email",
                  onPressed: _sendEmail,
                )
              : Text(""),
          (canCallStudent)
              ? FloatingActionButton(
                  child: Icon(
                    Icons.phone,
                  ),
                  backgroundColor: Colors.blueAccent,
                  mini: true,
                  tooltip: "Call Student",
                  onPressed: () => _callContact(studentGlobal.mobile),
                )
              : Text(""),
          (canCallFather)
              ? FloatingActionButton(
                  child: Icon(
                    Icons.phone,
                  ),
                  backgroundColor: Colors.blueAccent,
                  mini: true,
                  tooltip: "Call Father",
                  onPressed: () => _callContact(studentGlobal.father_mobile),
                )
              : Text(""),
          (canWhatsAppStudent)
              ? FloatingActionButton(
                  child: FaIcon(
                    FontAwesomeIcons.whatsapp,
                  ),
                  backgroundColor: Colors.green,
                  mini: true,
                  tooltip: "WhatsApp Student",
                  onPressed: () => _whatsApp(studentGlobal.mobile),
                )
              : Text(""),
          (canWhatsAppFather)
              ? FloatingActionButton(
                  child: FaIcon(
                    FontAwesomeIcons.whatsapp,
                  ),
                  backgroundColor: Colors.green,
                  mini: true,
                  tooltip: "WhatsApp Father",
                  onPressed: () => _whatsApp(studentGlobal.father_mobile),
                )
              : Text(""),
        ],
      ),
    );
  }

  _sendEmail() async {
    var fname = Uri.encodeComponent(studentGlobal.fname);
    var lname = Uri.encodeComponent(studentGlobal.lname);
    // TODO: show multiple template emails for sending
    final Uri params = Uri(
        scheme: 'mailto',
        path: studentGlobal.email,
        queryParameters: {
          'subject': "From RNW",
          'body': "Hello ${fname + " " + lname}"
        });
    String url =
        params.toString().replaceAll("+", "%20").replaceAll("%2520", "%20");
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  _callContact(String mobile) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(mobile);
    print(res);
  }

  _whatsApp(String mobile) async {
    // TODO: make student and father separate msgs with multiple template msgs
    String msg =
        "Hello ${studentGlobal.fname} ${studentGlobal.lname}, \n - From RNW";
    String url = "https://api.whatsapp.com/send?phone=+91$mobile&text=$msg";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
