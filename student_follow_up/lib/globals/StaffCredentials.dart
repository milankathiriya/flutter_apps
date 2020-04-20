// for globally available data
class StaffCredentials {
  int user_type;
  String email;
  String userName;
  int leadStatus;

  static final StaffCredentials _appData = new StaffCredentials._internal();

  factory StaffCredentials() {
    return _appData;
  }

  StaffCredentials._internal();
}

final staffCredentials = StaffCredentials();
