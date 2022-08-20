import '../domain/entities/message_chat.dart';
import '../infra/models/contacts_with_message_model.dart';
import '../infra/models/details_contact_chat_model.dart';
import '../infra/models/message_chat_model.dart';
import 'package:collection/collection.dart';
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
    Stream<List>? doc = Stream<List>.value([]);
    final existDocument = await firestoreService.existDocument('chat', tokenId);
    if (existDocument) {
      final snapshot = firestoreService.getDocumentSnapshot('chat', tokenId);
      doc = snapshot.map((event) => event
          .data()!['contacts']
          .map((element) => ContactsWithMessageModel.fromMap(element))
          .toList() as List);
    }

    yield* doc;
  }

  @override
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String? tokenIdUserActual, String? tokenIdContact}) async* {
    Stream<List<MessageChatModel>>? doc =
        Stream<List<MessageChatModel>>.value([]);
    final existDocument =
        await firestoreService.existDocument('chat', tokenIdUserActual!);
    if (existDocument) {
      final snapshot =
          firestoreService.getDocumentSnapshot('chat', tokenIdUserActual);
      final existSnapshot = (await snapshot
              .map((event) => event.data()!['contacts'])
              .first as List)
          .isNotEmpty;

      if (existSnapshot) {
        doc = snapshot.map((event) => event.data()!['contacts']).map(
            (contacts) => (contacts
                    .map((contact) => ContactsWithMessageModel.fromMap(contact))
                    .toList())
                .firstWhere((item) => item.tokenId == tokenIdContact)
                .messages);
      }
    }

    yield* doc;
  }

  @override
  Future<void> sendMessageToUser(
      {MessageChat? message,
      String? tokenIdUser,
      String? tokenIdContact,
      String? name,
      String? photo}) async {
    final existDocument =
        await firestoreService.existDocument('chat', tokenIdUser!);
    if (!existDocument) {
      await firestoreService
          .createDocument('chat', tokenIdUser, {'contacts': []});
    }

    final document = await firestoreService.getDocument('chat', tokenIdUser);

    List<ContactsWithMessageModel> contacts = ((document['contacts'] as List)
        .map((e) => ContactsWithMessageModel.fromMap(e))
        .toList());
    final existContact = contacts.firstWhereOrNull(
      (element) => element.tokenId == tokenIdContact,
    );
    if (existContact == null) {
      contacts.add(ContactsWithMessageModel([], tokenIdContact!, name!, photo));
    }
    contacts
        .firstWhere((element) => element.tokenId == tokenIdContact)
        .messages
        .add(MessageChatModel.fromMessageChat(message!));

    await firestoreService.updateDocument('chat', tokenIdUser,
        {'contacts': contacts.map((e) => e.toMap()).toList()});

    return;
  }
}
