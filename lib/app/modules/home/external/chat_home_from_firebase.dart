import '../infra/models/contacts_with_message_model.dart';
import '../infra/models/details_contact_chat_model.dart';
import '../infra/models/message_chat_model.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../infra/datasources/chat_home_datasource.dart';

class ChatHomeFromFirebase implements ChatHomeDatasource {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;

  ChatHomeFromFirebase(this.authService, this.firestoreService);

  @override
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones}) async {
    List<DetailsContactChatModel> result = [];
    for (String phone in phones!) {
      final existDocument =
          await firestoreService.existDocument('contacts', phone);

      if (existDocument) {
        final contactData =
            await firestoreService.getDocument('contacts', phone);
        final user =
            await firestoreService.getDocument('users', contactData['tokenId']);
        user.addAll({'tokenId': contactData['tokenId']});

        result.add(DetailsContactChatModel.fromDocument(user));
      }
    }

    return result;
  }

  @override
  Stream<List> getListContactsMessage(String tokenId) async* {
    Stream<List>? doc;
    final existDocument = await firestoreService.existDocument('chat', tokenId);
    if (existDocument) {
      final snapshot = firestoreService.getDocumentSnapshot('chat', tokenId);
      doc = snapshot.map((event) => event
          .data()!['contacts']
          .map((element) => ContactsWithMessageModel.fromMap(element))
          .toList() as List);
    }

    yield* doc!;
  }

  @override
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String? tokenIdUserActual, String? tokenIdContact}) async* {
    Stream<List<MessageChatModel>>? doc;
    final existDocument =
        await firestoreService.existDocument('chat', tokenIdUserActual!);
    if (existDocument) {
      final snapshot =
          firestoreService.getDocumentSnapshot('chat', tokenIdUserActual);

      doc = snapshot.map((event) => event.data()!['contacts']).map((contacts) =>
          (contacts
                  .map((contact) => ContactsWithMessageModel.fromMap(contact))
                  .toList())
              .firstWhere((item) => item.tokenId == tokenIdContact)
              .messages);
    }

    yield* doc!;
  }
}
