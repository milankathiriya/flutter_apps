import 'dart:convert';
import 'PODO.dart';
import 'package:dio/dio.dart';

List students = [];
List loginData = [];
Response response;
Dio dio = Dio();

Future<List> getStudent(int number) async {

  FormData formData = new FormData.fromMap({
    "gr_id": number,
  });
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
      data: formData);

  if (response.statusCode == 200) {
    students.clear();
    students.add(Student.fromJson(response.data['data'][0]));
    return students;
  }
  else if(response.statusCode == 503){
    print("Server Error bcz of 503");
    throw DioError();
  }
  else {
    throw Exception('Failed to load student data');
  }
}

getLoggedInResponse(String email, String password) async {
  FormData loginFormData =
      new FormData.fromMap({"email": email, "password": password});
  response = await dio.post(
      "http://demo.rnwmultimedia.com/eduzila_api/Android_api/login.php",
      data: loginFormData);

  print(response.statusCode);

  if (response.statusCode == 200) {
    if(response.data['data'].isNotEmpty){
      loginData.clear();
      loginData.add(Staff.fromJson(response.data['data'][0]));
      return loginData;
    }
    else{
      print("data is empty");
      return null;
    }
  }
  else if(response.statusCode == 503){
    print("Server Error bcz of 503");
    throw DioError();
  }
  else {
    throw Exception('Failed to load data');
  }
}
