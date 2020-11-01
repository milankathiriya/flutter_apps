import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:student_finder_rnw/models/student_detail_model.dart';

class StudentController extends GetxController {
  var GRID = "".obs;
  var image = "".obs;
  var fname = "".obs;
  var lname = "".obs;
  var total_admissions = 1.obs;
  var email = "-".obs;
  var mobile = "-".obs;
  var father_name = "-".obs;
  var father_mobile = "-".obs;
  var address = "-".obs;
  var remarks = List().obs;
  var courses = List().obs;
  var course_packages = List().obs;
  var branch_names = List().obs;
  var admission_dates = List().obs;
  var admission_codes = List().obs;
  var admission_statuses = List().obs;
  var total_fees = List().obs;
  var paid_fees = List().obs;

  Future<List<StudentDetailModel>> fetchStudentDetail({String grid}) async {
    final res = await http.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
      body: {
        'GR_ID': grid,
        'Inst_code': "RNWEDU",
        'Inst_security_code': "rnw",
      },
    );

    var data = jsonDecode(res.body.toString());

    return data['data'].map<StudentDetailModel>((elem) {
      print(StudentDetailModel.fromJson(elem).branch_name);
      return StudentDetailModel.fromJson(elem);
    }).toList();
  }

}
