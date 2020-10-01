import 'dart:convert';

class StudentGlobal {
  String grid = "";
  String fname = "";
  String lname = "";
  String email = "";
  String mobile = "";
  String father_name = "";
  String father_mobile = "";
  String address = "";
  String course = "";
  String course_package = "";
  String admission_date = "";
  String total_fee = "";
  String paid_fee = "";
  String branch_name = "";
  String admission_code = "";
  String admission_status = "";
  String image = "";
  List remarks = [];
  int totalAdmissions = 0;
  // all admissions list fields for generating admission page's pageviews
  List course_packages = [];
  List courses = [];
  List branches = [];
  List admission_dates = [];
  List admission_codes = [];
  List admission_statuses = [];
  List total_fees = [];
  List paid_fees = [];
  List remaining_fees = [];
}

StudentGlobal studentGlobal = StudentGlobal();
