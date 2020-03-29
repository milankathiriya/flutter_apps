import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../helpers/PODO.dart';

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
            return Column(
              children: <Widget>[
                Container(
                  height: 150,
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
                              maxRadius: 60,
                              backgroundImage: NetworkImage(data.image),
                            ),
//                          CachedNetworkImage(
//                            imageUrl: data.image,
//                            placeholder: (context, url) => CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => Icon(Icons.error),
//                          ),
                            Container(
                              height: 120,
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
                                                fontSize: 20)),
                                        TextSpan(
                                            text: grid.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
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
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text: "Name: ",
                                            style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        TextSpan(
                                            text: data.fname + " " + data.lname,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                      ]),
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
                                  data: data.email),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.call),
                                  title: "Contact",
                                  data: data.contact),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.person),
                                  title: "Father Name",
                                  data: data.father_name),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.call),
                                  title: "Father Contact",
                                  data: data.father_mobile),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: deepOrangeAccent,
                                  icon: Icon(Icons.location_on),
                                  title: "Address",
                                  data: data.address),
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
            return Text("${snapshot.error}");
          }

          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
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
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                                  data: data.course_package),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.assignment),
                                  title: "Course",
                                  data: data.course),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                color: blueAccent,
                                icon: Icon(Icons.location_city),
                                title: "Branch Name",
                                data: data.branch_name,
                              ),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.date_range),
                                  title: "Admission Date",
                                  data: data.admission_date),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: blueAccent,
                                  icon: Icon(Icons.confirmation_number),
                                  title: "Admission Code",
                                  data: data.admission_code),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                color: blueAccent,
                                icon: Icon(Icons.outlined_flag),
                                title: "Admission Status",
                                data: data.admission_status,
                              ),
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
            return Text("${snapshot.error}");
          }

          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
        },
      ),
    );
  }

  Widget getFeesData(grid, _futureStudent) {
    Color purpleAccent = Colors.purpleAccent;
    return SafeArea(
      child: FutureBuilder(
        future: _futureStudent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data[0];
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: purpleAccent),
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
                                  color: purpleAccent,
                                  icon: Icon(Icons.monetization_on),
                                  title: "Total Fees",
                                  data: data.total_fees),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: purpleAccent,
                                  icon: Icon(Icons.attach_money),
                                  title: "Paid Fees",
                                  data: data.paid_fees),
                              Divider(
                                height: 30,
                              ),
                              DataField(
                                  color: purpleAccent,
                                  icon: Icon(Icons.money_off),
                                  title: "Remaining Fees",
                                  data: data.remaining_fees.toString()),
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
            return Text("${snapshot.error}");
          }

          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
        },
      ),
    );
  }

  Widget getRemarksData(grid, _futureStudent) {
    Color teal = Colors.teal;
    return SafeArea(
      child: FutureBuilder(
        future: _futureStudent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data[0];

            remarks.clear();
            for (int i = 0; i < data.remarks.length; i++) {
              remarks.add(data.remarks[i]['remark']);
              remark_by.add(data.remarks[i]['remark_by']);
            }

            return Column(
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
                      itemCount: data.remarks.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: Text((i + 1).toString()),
                          title: Text(
                            remark_by[i].toString(),
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                          ),
                          subtitle: Text(
                            remarks[i].toString(),
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Column(
            children: <Widget>[CircularProgressIndicator()],
          );
        },
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
  }) : super(key: key);

  final color;
  final icon;
  final title;
  final data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title + "\n",
        style: TextStyle(color: color, fontSize: 16),
      ),
      dense: true,
      subtitle: Text(
        data,
        style: TextStyle(color: Colors.black54, fontSize: 20),
      ),
    );
  }
}
