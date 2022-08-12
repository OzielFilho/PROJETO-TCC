import '../../domain/entities/details_contact_chat.dart';

class DetailsContactChatModel extends DetailsContactChat {
  final String name;
  final String tokenId;
  final String email;
  final String phone;

  DetailsContactChatModel(
      {required this.name,
      required this.tokenId,
      required this.email,
      required this.phone})
      : super(name: name, tokenId: tokenId, email: email, phone: phone);

  factory DetailsContactChatModel.fromDocument(Map<String, dynamic> document) =>
      DetailsContactChatModel(
          email: document['email'],
          name: document['name'],
          phone: document['phone'],
          tokenId: document['tokenId']);
}
