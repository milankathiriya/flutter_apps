// for globally available data
class StudentDetails {
  String fname;
  String lname;
  String image;
  String email;
  String contact;
  String father_name;
  String father_mobile;
  String address;
  String course_package;
  String course;
  String admission_date;
  String admission_code;
  String admission_status;
  String branch_name;
  String total_fees;
  String paid_fees;
  int remaining_fees;
  List remarks  = [];
  List remark_by = [];

  static final StudentDetails _appData = new StudentDetails._internal();

  factory StudentDetails() {
    return _appData;
  }

  StudentDetails._internal();
}

final studentDetails = StudentDetails();
