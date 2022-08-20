abstract class WelcomeEvent {}

class GetUserEvent implements WelcomeEvent {}

class PhoneIsEmptyEvent implements WelcomeEvent {
  final String phone;

  PhoneIsEmptyEvent({required this.phone});
}

class UpdateUserCreateEvent implements WelcomeEvent {
  final String name;
  final String phone;
  final String email;
  final List<String> contacts;
  final bool welcomePage;
  final String photo;
  UpdateUserCreateEvent(
      {required this.name,
      required this.photo,
      required this.phone,
      required this.email,
      required this.contacts,
      required this.welcomePage});
}
