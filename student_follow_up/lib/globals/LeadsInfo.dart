// for globally available data
class LeadsInfo {
  String lead_id;
  String lead_timestamp_date;
  String lead_timestamp_time;
  String lead_school_classes;
  String lead_student_name;
  List lead_interested_subjects;
  String lead_assign_date;
  String lead_followup_status;

  int oldLeadsLength;

  static final LeadsInfo _appData = new LeadsInfo._internal();

  factory LeadsInfo() {
    return _appData;
  }

  LeadsInfo._internal();
}

final leadsInfo = LeadsInfo();
