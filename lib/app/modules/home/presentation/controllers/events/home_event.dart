abstract class HomeEvent {}

class GetUserHomeEvent implements HomeEvent {}

class GetListDetailsContactFromPhoneChatEvent implements HomeEvent {
  final List<String> contacts;

  GetListDetailsContactFromPhoneChatEvent({required this.contacts});
}

class GetListContactsMessageEvent implements HomeEvent {
  final String tokenId;

  GetListContactsMessageEvent({required this.tokenId});
}

class GetListMessageChatUserEvent implements HomeEvent {
  final String tokenIdUser;
  final String tokenIdContact;

  GetListMessageChatUserEvent(
      {required this.tokenIdUser, required this.tokenIdContact});
}

class GetCurrentLocationEvent implements HomeEvent {}

class LogoutUserEvent implements HomeEvent {}
