import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/models/faculty_login_model.dart';

class AuthController extends GetxController {
  var success = true.obs;
  var msg = "".obs;

  var user_name = "".obs;

  login(String email, String password, String token) async {
    print(token);

    var r = await loginFaculty(email, password, token);
    print("r => ${r.msg}");

    if (r.msg.isNotEmpty) {
      success.value = false;
      return false;
    } else {
      success.value = true;
      return true;
    }
  }

  Future<FacultyLoginModel> loginFaculty(email, password, token) async {
    // TODO: enable below lines in production mode
    // final res = await http.post(
    //     'https://demo.rnwmultimedia.com/eduzila_api/Android_api/login.php',
    //     body: {'email': email, 'password': password, 'mac_address': token});

    // TODO: Use below lines in development mode
    final res = await http.post(
        'https://demo.rnwmultimedia.com/eduzila_api/Android_api/login.php',
        body: {'email': email, 'password': password, 'mac_address': '6dbb9ef20df7ebb8'});

    if (res.statusCode == 200) {
      if (res.body.isNotEmpty) {
        Map data = jsonDecode(res.body.toString());
        if (data['data'] != "") {
          FacultyLoginModel o1 = FacultyLoginModel.fromJson(data);
          print("Email => ${o1.email}");
          msg.value = o1.msg ?? "";
          print("Msg => ${msg.value}");
          facultyDetail.user_name = o1.user_name;
          facultyDetail.email = o1.email;
          facultyDetail.role = o1.role;
          facultyDetail.phone = o1.phone;
          facultyDetail.branch_id = o1.branch_id;
          facultyDetail.department_id = o1.department_id;
          String base_img_path = "https://demo.rnwmultimedia.com/dist/img/";
          String demo_img_path =
              "https://demo.rnwmultimedia.com/dist/img/RNW_1.jpeg";
          try {
            facultyDetail.image = base_img_path + o1.image?.split('/')?.last;
          } catch (e) {
            facultyDetail.image = demo_img_path;
          }
          return FacultyLoginModel.fromJson(data);
        }
        return null;
      }
    }
    if (res.statusCode == 403) {
      if (res.body.isNotEmpty) {
        Map data = jsonDecode(res.body.toString());
        if (data['msg'] != "") {
          FacultyLoginModel o1 = FacultyLoginModel.fromJson(data);
          msg.value = o1.msg ?? "";
          print("Msg => ${msg.value}");
          return FacultyLoginModel.fromJson(jsonDecode(res.body));
        }
        return null;
      }
    } else {
      print("Provide valid credentials");
      success.value = false;
      return null;
    }
  }
}
