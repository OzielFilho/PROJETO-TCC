import 'dart:convert';

import '../../domain/entities/contacts_with_message.dart';
import 'message_chat_model.dart';

class ContactsWithMessageModel extends ContactsWithMessage {
  final List<MessageChatModel> messages;
  final String tokenId;
  String name;
  String? photo;
  ContactsWithMessageModel(this.messages, this.tokenId, this.name, this.photo)
      : super(messages, tokenId, name, photo);

  Map<String, dynamic> toMap() {
    return {
      'messages': messages.map((x) => x.toMap()).toList(),
      'tokenId': tokenId,
      'name': name,
      'photo': photo
    };
  }

  factory ContactsWithMessageModel.fromMap(Map<String, dynamic> map) {
    return ContactsWithMessageModel(
        List<MessageChatModel>.from(
            map['messages']?.map((x) => MessageChatModel.fromMap(x))),
        map['tokenId'] ?? '',
        map['name'] ?? '',
        map['photo'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory ContactsWithMessageModel.fromJson(String source) =>
      ContactsWithMessageModel.fromMap(json.decode(source));
}
