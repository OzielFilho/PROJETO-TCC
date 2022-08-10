import 'package:app/app/modules/home/domain/entities/message_chat.dart';

class ContactsWithMessage {
  final List<MessageChat> messages;
  final String tokenId;
  final String name;

  ContactsWithMessage(this.messages, this.tokenId, this.name);
}
