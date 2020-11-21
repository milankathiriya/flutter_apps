class FacultyLoginModel {
  final String email;
  final String password;
  final String user_name;
  final String role;
  final String phone;
  final String branch_id;
  final String department_id;
  final String image;
  final String msg;

  FacultyLoginModel(
      {this.email,
      this.password,
      this.user_name,
      this.role,
      this.phone,
      this.branch_id,
      this.department_id,
      this.image,
      this.msg});

  factory FacultyLoginModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    if (json['msg']!=null) {
      if (json['msg'].isNotEmpty) {
        return FacultyLoginModel(
          msg: json['msg'],
        );
      }
    }

    return FacultyLoginModel(
      email: json['data'].first['email'],
      password: json['data'].first['password'],
      user_name: json['data'].first['user_name'],
      role: json['data'].first['role'],
      phone: json['data'].first['phone'],
      branch_id: json['data'].first['branch_id'],
      department_id: json['data'].first['department_id'],
      image: json['data'].first['image'],
      msg: json['msg'] ?? "",
    );
  }
}
