import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/models/dept_branch_model.dart';

class DeptBranchController extends GetxController {
  var departments = [].obs;
  var branches = [].obs;

  getDeptBranchInfo() async {
    final res = await http.get(
        "http://demo.rnwmultimedia.com/eduzila_api/Android_api/branch_department_data.php");

    if (res.body.isNotEmpty) {
      Map data = jsonDecode(res.body.toString());
      if (data.isNotEmpty) {
        DeptBranchModel d1 = DeptBranchModel.fromJson(data);
        departments.value = d1.departments;
        branches.value = d1.branches;

        var dept_id = facultyDetail?.department_id;
        String dept = "";
        departments.forEach((element) {
          print(element);
          if (element['department_id'] == dept_id) {
            print(element['department_name']);
            dept = element['department_name'];
            facultyDetail.department = dept;
          }
        });

        var branch_id = facultyDetail?.branch_id;
        String branch = "";
        branches.forEach((element) {
          print(element);
          if (element['branch_id'] == branch_id) {
            print(element['branch_name']);
            branch = element['branch_name'];
            facultyDetail.branch = branch;
          }
        });

        return DeptBranchModel.fromJson(data);
      }
    }
  }
}
