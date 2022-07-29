class UpdateUserWelcome {
  final List<String> contacts;
  final bool welcomePage;
  final String phone;
  final String name;
  final String email;
  UpdateUserWelcome({
    required this.name,
    required this.phone,
    required this.email,
    required this.welcomePage,
    required this.contacts,
  });
}
