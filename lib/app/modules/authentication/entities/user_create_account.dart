class UserCreateAccount {
  final String name;
  final String email;
  final String password;
  String? photo;
  final String confirmePassword;
  List<String>? contacts;
  final String phone;
  bool? welcomePage;

  UserCreateAccount(this.name, this.email, this.password, this.photo,
      this.confirmePassword, this.contacts, this.phone, this.welcomePage);
}
