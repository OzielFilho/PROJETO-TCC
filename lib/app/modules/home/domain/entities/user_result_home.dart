class UserResultHome {
  final String email;
  final String phone;
  String name;
  final String tokenId;
  String photo;
  final List<String> contacts;
  UserResultHome(this.email, this.phone, this.name, this.contacts, this.tokenId,
      this.photo);
}
