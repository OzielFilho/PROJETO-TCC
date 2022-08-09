abstract class HomeEvent {}

class GetUserHomeEvent implements HomeEvent {}

class GetListDetailsContactFromPhoneChatEvent implements HomeEvent {
  final List<String> contacts;

  GetListDetailsContactFromPhoneChatEvent({required this.contacts});
}

class GetCurrentLocationEvent implements HomeEvent {}

class LogoutUserEvent implements HomeEvent {}
