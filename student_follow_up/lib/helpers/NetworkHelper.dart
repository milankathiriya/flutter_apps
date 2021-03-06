import 'dart:convert';
import 'dart:io';
import 'package:studentfollowup/globals/StudentDetails.dart';

import 'PODO.dart';
import 'package:dio/dio.dart';
import '../globals/StaffCredentials.dart';
import '../globals/LeadsInfo.dart';

List students = [];
List loginData = [];
List remark_type_id = [];
List remark_type_name = [];
List remarkAddedResponse = [];
Response response;
Response oldLeadResponse;
Response newLeadResponse;
List leads = [];
Dio dio = Dio();

Future<List> getStudent(int number, [int i]) async {
  FormData formData = new FormData.fromMap({
    "gr_id": number,
  });
  try {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  } on DioError {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  } catch (e) {
    response = await dio.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        data: formData);
  }
  if (response.statusCode == 200) {
    students.clear();
    studentDetails.admissionLength = response.data['data'].length;

    print("i => $i");
    (i == null)
        ? students.add(Student.fromJson(response.data['data'][0]))
        : students.add(Student.fromJson(response.data['data'][i]));
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

Future getLeadPermissionResponse(String user_name) async {
  FormData leadPermissionFormData =
      new FormData.fromMap({"user_name": user_name});
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Lead_check_permission.php",
      data: leadPermissionFormData);

  if (response.statusCode == 200) {
    if (response.data != null) {
      var res = response.data['status'];
      print(res.runtimeType);
      return res;
    } else {
      print("data is empty");
      return null;
    }
  } else if (response.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to fetch data');
  }
}

Future getLeads(String user_name) async {
  FormData oldLeadFormData =
  new FormData.fromMap({"lead_type": 0, "user_name": user_name});
  oldLeadResponse = await dio.post(
      "http://demo.rnwmultimedia.com/Lead Calling_report/get_lead_list.php",
      data: oldLeadFormData);

//  FormData newLeadFormData =
//  new FormData.fromMap({"lead_type": 1, "user_name": user_name});
//  newLeadResponse = await dio.post(
//      "http://demo.rnwmultimedia.com/Lead Calling_report/get_lead_list.php",
//      data: newLeadFormData);

  if (oldLeadResponse.statusCode == 200) {
    if (oldLeadResponse.data != null) {
      leads.clear();
      var oldRes = oldLeadResponse.data['data'];
      print(oldRes[0]);
      leadsInfo.oldLeadsLength = oldRes.length;
      for(int i=0; i<oldRes.length; i++){
        leads.add(Leads.fromJson(oldRes[i]));
      }
      return leads;
    } else {
      print("data is empty");
      return null;
    }
  } else if (oldLeadResponse.statusCode == 503) {
    print("Server Error bcz of 503");
    throw DioError();
  } else {
    throw Exception('Failed to fetch data');
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

Future<List> getRemarkInsertedResponse(
    int gr_id, String added_by, String remark_type, int status, String remark,
    [File file]) async {
  String fileName = file.path.split('/').last;

  FormData remarkData = new FormData.fromMap({
    "gr_id": gr_id,
    "added_by": added_by,
    "type_id": remark_type,
    "status": status,
    "remark": remark,
    "file": await MultipartFile.fromFile(file.path, filename: fileName) ?? "",
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
