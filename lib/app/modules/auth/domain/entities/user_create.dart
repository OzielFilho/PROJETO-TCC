class UserCreate {
  final String? email;
  final String? password;
  final String? name;
  List<String> phones;
  final String? yourPhone;

  UserCreate(
      {this.email,
      this.password,
      this.name,
      this.phones = const [],
      this.yourPhone});
}
