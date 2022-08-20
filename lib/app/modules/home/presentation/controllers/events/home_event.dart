import 'package:app/app/modules/home/domain/entities/message_chat.dart';
import 'package:app/app/modules/home/domain/entities/user_result_home.dart';

abstract class HomeEvent {}

class GetUserHomeEvent implements HomeEvent {}

class GetListDetailsContactFromPhoneChatEvent implements HomeEvent {
  final List<String> contacts;

  GetListDetailsContactFromPhoneChatEvent({required this.contacts});
}

class SendMessageToUserEvent implements HomeEvent {
  final MessageChat message;
  final String tokenIdContact;
  final String tokenIdUser;
  final String name;
  final String photo;
  SendMessageToUserEvent(
      {required this.message,
      required this.photo,
      required this.tokenIdContact,
      required this.tokenIdUser,
      required this.name});
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

class UpdateUserHomeEvent implements HomeEvent {
  final UserResultHome user;

  UpdateUserHomeEvent(this.user);
}
