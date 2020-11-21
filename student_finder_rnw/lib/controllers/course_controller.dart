import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:student_finder_rnw/models/course_model.dart';

class CourseController extends GetxController {

  var singleCourses = List().obs;

  getCourseInfo() async {
    final res = await http.get(
        "https://demo.rnwmultimedia.com/eduzila_api/Android_api/get_course_details.php");

    if (res.body.isNotEmpty) {
      List data = jsonDecode(res.body.toString());
      if (data.isNotEmpty) {
        List result = data.map((dt) => CourseModel.fromJson(dt)).toList();
        singleCourses.add(result);
        return result;
      }
    }
  }
}
