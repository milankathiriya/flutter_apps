import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_finder/models/LoginModel.dart';
import 'package:student_finder/models/StudentModel.dart';

class AuthService {
  Future<LoginModel> getLoggedInResponse(String email, String password) async {
    var res = await http.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/login.php",
        body: {"email": email, "password": password});

    if (res.statusCode == 200) {
      if (res.body.isNotEmpty) {
        var data = jsonDecode(res.body.toString());
        if (data['data'].isNotEmpty) {
          data = LoginModel.fromJson(data['data'].first);
          return data;
        }
        return null;
      } else {
        print("data is empty");
      }
    } else if (res.statusCode == 503) {
      print("Server Error bcz of 503");
      throw Exception("Server Error bcz of 503");
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<StudentModel>> getStudentData({int grid}) async {
    var res = await http.post(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/Android_api.php",
        body: {"gr_id": grid.toString()});

    if (res.statusCode == 200) {
      if (res.body.isNotEmpty) {
        var data = jsonDecode(res.body.toString());
        // print(data['data'][0]);
        // print(data['data'][1]);
        return data['data']
            .map<StudentModel>((e) => StudentModel.fromJson(e))
            .toList();
      } else {
        print("Data is empty.");
      }
    } else if (res.statusCode == 503) {
      print("Server Error bcz of 503");
      throw Exception("Server Error bcz of 503");
    } else {
      throw Exception('Failed to load data');
    }
  }
}

AuthService authService = AuthService();
