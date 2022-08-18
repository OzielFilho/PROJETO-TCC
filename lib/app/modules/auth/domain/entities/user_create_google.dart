class UserCreateGoogle {
  final String email;
  final String password;
  final String name;
  List<String>? contacts;
  final String phone;
  String? photo;
  bool? welcomePage;
  final String confirmePassword;

  UserCreateGoogle(
      {required this.email,
      required this.password,
      required this.confirmePassword,
      required this.name,
      this.contacts,
      this.photo,
      this.welcomePage,
      required this.phone});
}
