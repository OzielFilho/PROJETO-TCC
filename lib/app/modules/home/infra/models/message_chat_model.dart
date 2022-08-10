import 'dart:convert';

import 'package:app/app/modules/home/domain/entities/message_chat.dart';

class MessageChatModel extends MessageChat {
  final String text;
  final String date;
  final String tokenId;

  MessageChatModel(this.text, this.date, this.tokenId)
      : super(text: text, date: date, tokenId: tokenId);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'date': date,
      'tokenId': tokenId,
    };
  }

  factory MessageChatModel.fromMap(Map<String, dynamic> map) {
    return MessageChatModel(
      map['text'] ?? '',
      map['date'] ?? '',
      map['tokenId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageChatModel.fromJson(String source) =>
      MessageChatModel.fromMap(json.decode(source));
}
