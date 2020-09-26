import 'dart:convert';

class LoginModel {
  final String userName;
  final String userEmail;

  LoginModel({
    this.userName,
    this.userEmail,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return LoginModel(
      userName: json['user_name'],
      userEmail: json['email'],
    );
  }
}