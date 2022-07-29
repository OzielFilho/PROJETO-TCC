abstract class WelcomeEvent {}

class GetUserEvent implements WelcomeEvent {}

class UpdateUserCreateEvent implements WelcomeEvent {
  final String name;
  final String phone;
  final String email;
  final List<String> contacts;
  final bool welcomePage;

  UpdateUserCreateEvent(
      {required this.name,
      required this.phone,
      required this.email,
      required this.contacts,
      required this.welcomePage});
}
