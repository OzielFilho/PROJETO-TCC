class AuthResult {
  final String email;
  final String? tokenId;
  final bool welcomePage;
  final String phone;

  AuthResult(this.email, this.tokenId, this.welcomePage, this.phone);
}
