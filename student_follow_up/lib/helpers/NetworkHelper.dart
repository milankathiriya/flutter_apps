import 'dart:convert';
import 'PODO.dart';
import 'package:dio/dio.dart';
import '../globals/StaffCredentials.dart';

List students = [];
List loginData = [];
List remark_type_id = [];
List remark_type_name = [];
List remarkAddedResponse = [];
Response response;
Dio dio = Dio();

Future<List> getStudent(int number) async {
  FormData formData = new FormData.fromMap({
    "gr_id": number,
  });
  try {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  }
  on DioError {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  }
  catch (e) {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  }
  if (response.statusCode == 200) {
    students.clear();
    students.add(Student.fromJson(response.data['data'][0]));
    return students;
  } else if (response.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to load student data');
  }
}

Future<List> getLoggedInResponse(String email, String password) async {
  FormData loginFormData =
      new FormData.fromMap({"email": email, "password": password});
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/login.php",
      data: loginFormData);

  if (response.statusCode == 200) {
    if (response.data['data'].isNotEmpty) {
      loginData.clear();
      loginData.add(Staff.fromJson(response.data['data'][0]));
      return loginData;
    } else {
      print("data is empty");
      return null;
    }
  } else if (response.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List> getRemarkTypes() async {
  FormData remarkTypes =
      new FormData.fromMap({"user_type": staffCredentials.user_type});
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/remarks_type.php",
      data: remarkTypes);

  if (response.statusCode == 200) {
    if (response.data['data'].isNotEmpty) {
      remark_type_id.clear();
      remark_type_name.clear();
      for (int i = 0; i < response.data['data'].length; i++) {
        remark_type_id.add(RemarkType.fromJson(response.data['data'][i]));
        remark_type_name.add(RemarkType.fromJson(response.data['data'][i]));
      }
      return remark_type_id;
    } else {
      print("data is empty");
      return null;
    }
  } else if (response.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to load remark types');
  }
}

Future<List> getRemarkInsertedResponse(int gr_id, String added_by,
    String remark_type, int status, String remark) async {

  FormData remarkData = new FormData.fromMap({
    "gr_id": gr_id,
    "added_by": added_by,
    "type_id": remark_type,
    "status": status,
    "remark": remark
  });
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/upload_audio_remark.php",
      data: remarkData);

  if (response.statusCode == 200) {
    return response.data['data'];
  } else if (response.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to insert remark');
  }
}
