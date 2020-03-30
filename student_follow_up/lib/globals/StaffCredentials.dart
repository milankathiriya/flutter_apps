// for globally available data
class StaffCredentials {
  String email;
  String userName;

  static final StaffCredentials _appData = new StaffCredentials._internal();

  factory StaffCredentials() {
    return _appData;
  }

  StaffCredentials._internal();
}

final staffCredentials = StaffCredentials();
