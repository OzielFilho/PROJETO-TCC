import 'dart:io';

class UserCreate {
  final String email;
  final String password;
  final String name;
  List<String>? contacts;
  final String phone;
  bool? welcomePage;
  File? photo;
  final String confirmePassword;

  UserCreate(
      {required this.email,
      required this.password,
      required this.confirmePassword,
      required this.name,
      this.contacts,
      this.photo,
      this.welcomePage,
      required this.phone});
}
