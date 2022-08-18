class AuthResult {
  final String email;
  final String? tokenId;
  final bool welcomePage;
  String phone;
  List<String>? contacts;
  String? photo;
  final String name;

  AuthResult(
      {required this.email,
      this.tokenId,
      required this.welcomePage,
      required this.phone,
      required this.name,
      this.contacts,
      this.photo});
}
