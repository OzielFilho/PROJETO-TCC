import '../../domain/entities/details_contact_chat.dart';

class DetailsContactChatModel extends DetailsContactChat {
  final String name;
  final String tokenId;
  final String email;
  final String phone;
  final String? photo;
  DetailsContactChatModel(
      {required this.name,
      required this.tokenId,
      required this.email,
      required this.phone,
      required this.photo})
      : super(
            name: name,
            tokenId: tokenId,
            email: email,
            phone: phone,
            photo: photo);

  factory DetailsContactChatModel.fromDocument(Map<String, dynamic> document) =>
      DetailsContactChatModel(
          email: document['email'],
          name: document['name'],
          phone: document['phone'],
          photo: document['photo'] ?? '',
          tokenId: document['tokenId']);
}
