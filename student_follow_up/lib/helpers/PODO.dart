class Student {
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
  List remarks;

  List courses = [];

  Student({
    this.fname,
    this.lname,
    this.image,
    this.email,
    this.contact,
    this.father_name,
    this.father_mobile,
    this.address,
    this.course_package,
    this.course,
    this.admission_date,
    this.admission_code,
    this.admission_status,
    this.branch_name,
    this.total_fees,
    this.paid_fees,
    this.remaining_fees,
    this.remarks,
  });

  Student.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    image =
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php" +
            json['image'];
    email = json['email'];
    contact = json['mobile'];
    father_name = json['father_name'];
    father_mobile = json['father_mobile'];
    address = json['address'];
    course_package =
        (json['course_package'] == "") ? "-" : json['course_package'];
    course = json['course'];

    courses = course.split(",");
    course = "";
    courses.forEach((c) {
      course += "- " + c + "\n";
    });

    admission_date = json['admission_date'];
    admission_code = json['admission_code'];
    admission_status = json['admission_status'];
    branch_name = json['branch_name'];
    total_fees = json['total_fees'];
    paid_fees = json['paid_fees'];
    remaining_fees = int.parse(total_fees) - int.parse(paid_fees);

    remarks = json['remarks'];
  }
}

class Staff {
  int user_type;
  String email;
  String password;
  String user_name;

  Staff({this.user_type, this.email, this.password, this.user_name});

  Staff.fromJson(Map<String, dynamic> json) {
    user_type = json['user_type'];
    email = json['email'];
    password = json['password'];
    user_name = json['user_name'];
  }
}

class RemarkType {
  String type_id;
  String type_name;

  RemarkType({this.type_id, this.type_name});

  RemarkType.fromJson(Map<String, dynamic> json) {
    type_id = json['type_id'];
    type_name = json['type_name'];
  }
}

class Leads {
  String lead_id;
  String lead_timestamp_date;
  String lead_timestamp_time;
  String lead_school_classes;
  String lead_student_name;
  String lead_interested_subject;
  String lead_assign_date;
  String lead_followup_status;

  List interested_subjects = [];

  Leads(
      {this.lead_id,
      this.lead_timestamp_date,
      this.lead_timestamp_time,
      this.lead_school_classes,
      this.lead_student_name,
      this.lead_interested_subject,
      this.lead_assign_date,
      this.lead_followup_status});

  Leads.fromJson(Map<String, dynamic> json) {
    lead_id = json['id'].toString();
    lead_timestamp_date = json['timestamp'];
    lead_timestamp_time = json['timestamp'];
    lead_school_classes = json['name_of_school_or_classes'];
    lead_student_name = json['student_name'];

    lead_interested_subject = json['Intrested_subjects'];

    interested_subjects = lead_interested_subject.split(",");
    lead_interested_subject = "";
    interested_subjects.forEach((c) {
      lead_interested_subject += c + ", ";
    });

    lead_assign_date = json['lead_assign_date'];
    lead_followup_status = json['followup_status'].toString();
  }
}
