import 'dart:convert';

class StudentModel {
  final String fname;
  final String lname;
  final String email;
  final String mobile;
  final String father_name;
  final String father_mobile;
  final String address;
  final String course;
  final String course_package;
  final String admission_date;
  final String total_fee;
  final String paid_fee;
  final String branch_name;
  final String admission_code;
  final String admission_status;
  final String image;
  final List remarks;
  final String remark;
  final String remark_by;
  StudentModel({
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.father_name,
    this.father_mobile,
    this.address,
    this.course,
    this.course_package,
    this.admission_date,
    this.total_fee,
    this.paid_fee,
    this.branch_name,
    this.admission_code,
    this.admission_status,
    this.image,
    this.remarks,
    this.remark,
    this.remark_by,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return StudentModel(
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      mobile: json['mobile'],
      father_name: json['father_name'],
      father_mobile: json['father_mobile'],
      address: json['address'],
      course: json['course'],
      course_package: json['course_package'],
      admission_date: json['admission_date'],
      total_fee: json['total_fees'],
      paid_fee: json['paid_fees'],
      branch_name: json['branch_name'],
      admission_code: json['admission_code'],
      admission_status: json['admission_status'],
      image: json['image'],
      remarks: List.from(json['remarks']),
    );
  }
}
