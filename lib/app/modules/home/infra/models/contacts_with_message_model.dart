import 'dart:convert';

import 'package:app/app/modules/home/domain/entities/contacts_with_message.dart';
import 'package:app/app/modules/home/infra/models/message_chat_model.dart';

class ContactsWithMessageModel extends ContactsWithMessage {
  final List<MessageChatModel> messages;
  final String tokenId;
  final String name;
  ContactsWithMessageModel(this.messages, this.tokenId, this.name)
      : super(messages, tokenId, name);

  Map<String, dynamic> toMap() {
    return {
      'messages': messages.map((x) => x.toMap()).toList(),
      'tokenId': tokenId,
      'name': name
    };
  }

  factory ContactsWithMessageModel.fromMap(Map<String, dynamic> map) {
    return ContactsWithMessageModel(
      List<MessageChatModel>.from(
          map['messages']?.map((x) => MessageChatModel.fromMap(x))),
      map['tokenId'] ?? '',
      map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactsWithMessageModel.fromJson(String source) =>
      ContactsWithMessageModel.fromMap(json.decode(source));
}
