import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentfollowup/globals/StaffCredentials.dart';
import '../globals/StudentDetails.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image/image.dart' as im;

GetIt locator = GetIt.asNewInstance();

class Call {
  void call(int num) => launch("tel:$num");

  Future whatsApp(int num) {
    var msg = '''Hello, *RWn. ${studentDetails.fname} ${studentDetails.lname}*
    \n
Glad to know that you are a member of *Red and White Group of Institute*
    \n
- From *RWn. ${staffCredentials.userName}*''';
    print("whatsapp://send?phone=91$num&text=$msg");
    return launch("whatsapp://send?phone=91$num&text=$msg");
  }

  Future mail(String email) async {
    var subject = "SFU App";
    var body = '''Hello, RWn. ${studentDetails.fname} ${studentDetails.lname}
    \n
Glad to know that you are a member of Red and White Group of Institute
    \n
- From RWn. ${staffCredentials.userName}''';
    var url = 'mailto:$email?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      Fluttertoast.showToast(
        msg: "Could not launch $url",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }
}

void setupLocator() {
  locator.registerSingleton(Call());
}

Call _service = locator<Call>();

void dialCall(String number) {
  _service.call(int.parse(number));
}

whatsAppMsg(String number) {
  _service.whatsApp(int.parse(number));
}

mailTo(String email) {
  _service.mail(email);
}

class MainDataPage {
  List remarks = [];
  List remark_by = [];

  Widget getData(grid, _futureStudent) {
    Color deepOrangeAccent = Colors.deepOrangeAccent;
    return SafeArea(
      child: FutureBuilder(
        future: _futureStudent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data[0];
            studentDetails.fname = data.fname;
            studentDetails.lname = data.lname;
            studentDetails.email = data.email;
            data.image = data.image.replaceAll(
                "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php/",
                "https://demo.rnwmultimedia.com/eduzila_api//");
            studentDetails.image = data.image;
            print(studentDetails.image);
            studentDetails.contact = data.contact;
            studentDetails.father_name = data.father_name;
            studentDetails.father_mobile = data.father_mobile;
            studentDetails.address = data.address;
            studentDetails.course_package = data.course_package;
            studentDetails.course = data.course;
            studentDetails.admission_date = data.admission_date;
            studentDetails.admission_code = data.admission_code;
            studentDetails.admission_status = data.admission_status;
            studentDetails.branch_name = data.branch_name;
            studentDetails.total_fees = data.total_fees;
            studentDetails.paid_fees = data.paid_fees;
            studentDetails.remaining_fees = data.remaining_fees;
            studentDetails.remarks = data.remarks;
            print("f_no.:" + studentDetails.father_mobile);
            return Column(
              children: <Widget>[
                Container(
                  height: 125,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      // Profile pic, GRID and Name
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: deepOrangeAccent),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // pic
                            // TODO: Cannot load image
                            CircleAvatar(
                              maxRadius: 50,
                              backgroundImage:
                                  NetworkImage(studentDetails.image),
                            ),
//                          CachedNetworkImage(
//                            imageUrl: data.image,
//                            placeholder: (context, url) => CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => Icon(Icons.error),
//                          ),
                            Container(
                              height: 90,
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // gr_id
                                  Container(
                                    child: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "GRID: ",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                        TextSpan(
                                            text: grid.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16))
                                      ]),
                                    ),
//                          child: Text("GRID: ${grid.toString()}"),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // name
                                  Container(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Name: ",
                                              style: TextStyle(
                                                  color: Colors.deepOrange,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16)),
                                          TextSpan(
                                            text: studentDetails.fname +
                                                " " +
                                                studentDetails.lname,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // All basic data fields
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: deepOrangeAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DataField(
                                color: deepOrangeAccent,
                                icon: Icon(Icons.email),
                                title: "Email",
                                data: studentDetails.email ?? "",
                                email:
                                    (studentDetails.email != "") ? true : false,
                              ),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                color: deepOrangeAccent,
                                icon: Icon(Icons.call),
                                title: "Contact",
                                data: studentDetails.contact ?? "",
                                call: (studentDetails.contact != "")
                                    ? true
                                    : false,
                              ),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.person),
                                  title: "Father Name",
                                  data: studentDetails.father_name ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.call),
                                  title: "Father Contact",
                                  data: studentDetails.father_mobile ?? "",
                                  call: (studentDetails.father_mobile != "")
                                      ? true
                                      : false),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.location_on),
                                  title: "Address",
                                  data: studentDetails.address ?? ""),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Low Network Connection...\nTry Again..."),);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getCourseData(grid, _futureStudent) {
    Color blueAccent = Colors.blueAccent;
    return SafeArea(
      child: FutureBuilder(
        future: _futureStudent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data[0];
            studentDetails.course_package = data.course_package;
            studentDetails.course = data.course;
            studentDetails.admission_date = data.admission_date;
            studentDetails.admission_code = data.admission_code;
            studentDetails.admission_status = data.admission_status;
            studentDetails.branch_name = data.branch_name;
            studentDetails.total_fees = data.total_fees;
            studentDetails.paid_fees = data.paid_fees;
            studentDetails.remaining_fees = data.remaining_fees;
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: blueAccent),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              DataField(
                                color: blueAccent,
                                icon: Icon(Icons.assignment_turned_in),
                                title: "Course Package",
                                data: studentDetails.course_package ?? "",
                              ),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                color: blueAccent,
                                icon: Icon(Icons.assignment),
                                title: "Course",
                                data: studentDetails.course ?? "",
                              ),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.location_city),
                                  title: "Branch Name",
                                  data: studentDetails.branch_name ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                color: blueAccent,
                                icon: Icon(Icons.date_range),
                                title: "Admission Date",
                                data: studentDetails.admission_date ?? "",
                              ),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.confirmation_number),
                                  title: "Admission Code",
                                  data: studentDetails.admission_code ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.assistant_photo),
                                  title: "Admission Status",
                                  data: studentDetails.admission_status ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: Colors.purpleAccent,
                                  icon: Icon(Icons.monetization_on),
                                  title: "Total Fees",
                                  data: studentDetails.total_fees ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: Colors.purpleAccent,
                                  icon: Icon(Icons.attach_money),
                                  title: "Paid Fees",
                                  data: studentDetails.paid_fees ?? ""),
                              Divider(
                                height: 15,
                              ),
                              DataField(
                                  color: Colors.purpleAccent,
                                  icon: Icon(Icons.money_off),
                                  title: "Remaining Fees",
                                  data: studentDetails.remaining_fees
                                          .toString() ??
                                      ""),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Low Network Connection...\nTry Again..."),);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getRemarksData(grid, _futureStudent) {
    Color teal = Colors.teal;
    remarks.clear();
    remark_by.clear();
    for (int i = 0; i < studentDetails.remarks.length; i++) {
      remarks.add(studentDetails.remarks[i]['remark']);
      remark_by.add(studentDetails.remarks[i]['remark_by']);
    }
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: teal),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider(
                    color: Colors.teal,
                  );
                },
                itemCount: studentDetails.remarks.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Text((i + 1).toString()),
                    title: Text(
                      remark_by[i].toString(),
                      style: TextStyle(color: Colors.teal, fontSize: 14),
                    ),
                    subtitle: Text(
                      remarks[i].toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataField extends StatelessWidget {
  const DataField({
    Key key,
    @required this.icon,
    @required this.data,
    @required this.title,
    @required this.color,
    this.call,
    this.email,
  }) : super(key: key);

  final color;
  final icon;
  final title;
  final data;
  final call;
  final email;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title + "\n",
        style: TextStyle(color: color, fontSize: 14),
      ),
      dense: true,
      subtitle: Text(
        data,
        style: TextStyle(color: Colors.black54, fontSize: 16),
      ),
      trailing: Wrap(
        children: <Widget>[
          (email == true)
              ? FloatingActionButton(
                  backgroundColor: Colors.black54,
                  child: Icon(
                    Icons.mail_outline,
                  ),
                  onPressed: () {
                    mailTo(data);
                  },
                  mini: true,
                  elevation: 2,
                )
              : Text(""),
          (call == true)
              ? FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.call,
                  ),
                  onPressed: () {
                    dialCall(data);
                  },
                  mini: true,
                  elevation: 2,
                )
              : Text(""),
          (call == true)
              ? FloatingActionButton(
                  backgroundColor: Colors.teal,
                  child: FaIcon(
                    FontAwesomeIcons.whatsapp,
                  ),
                  onPressed: () {
                    whatsAppMsg(data);
                  },
                  mini: true,
                  elevation: 2,
                )
              : Text("")
        ],
      ),
    );
  }
}
