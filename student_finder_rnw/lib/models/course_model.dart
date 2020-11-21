class CourseModel {
  final String course_id;
  final String department_id;
  final String RelevantCourse_id;
  final String course_name;
  final String course_detail;
  final String course_fees;
  final String installment;
  final String course_duration;
  final String jobg;
  final String csigning_sheet;

  CourseModel({
    this.course_id,
    this.department_id,
    this.RelevantCourse_id,
    this.course_name,
    this.course_detail,
    this.course_fees,
    this.installment,
    this.course_duration,
    this.jobg,
    this.csigning_sheet,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json){

    if (json == null) return null;

    return CourseModel(
      course_id: json['course_id'],
      department_id: json['department_id'],
      RelevantCourse_id: json['RelevantCourse_id'],
      course_name: json['course_name'],
      course_detail: json['course_detail'],
      course_fees: json['course_fees'],
      installment: json['installment'],
      course_duration: json['course_duration'],
      jobg: json['jobg'],
      csigning_sheet: json['csigning_sheet'],
    );
  }

}
