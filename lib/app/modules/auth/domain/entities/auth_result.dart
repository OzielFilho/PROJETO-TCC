class AuthResult {
  final String email;
  final String? tokenId;
  final bool welcomePage;
  String phone;
  final String name;

  AuthResult(this.email, this.tokenId, this.welcomePage, this.phone, this.name);
}
