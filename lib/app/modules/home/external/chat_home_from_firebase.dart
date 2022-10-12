import 'package:flutter/material.dart';

import '../../../core/services/sms_service.dart';
import '../domain/entities/current_position.dart';
import '../infra/models/user_result_home_model.dart';

import '../../../core/utils/constants/encrypt_data.dart';
import '../../../core/utils/functions_utils.dart';
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
  final SmsService smsService;
  ChatHomeFromFirebase(
      this.authService, this.firestoreService, this.smsService);

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
      final docChat =
          await firestoreService.getDocument('chat', tokenIdUserActual);
      if (docChat['contacts'].isNotEmpty) {
        final snapshot =
            firestoreService.getDocumentSnapshot('chat', tokenIdUserActual);
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
    ContactsWithMessageModel contactUser =
        contacts.firstWhere((element) => element.tokenId == tokenIdContact);
    contactUser.name = name!;
    contactUser.photo = photo;

    contactUser.messages.add(MessageChatModel.fromMessageChat(message!));
    await firestoreService.updateDocument('chat', tokenIdUser,
        {'contacts': contacts.map((e) => e.toMap()).toList()});

    return;
  }

  @override
  Future<void> sendMessageEmergenceWithChat(
      {List<String>? phones,
      String? tokenId,
      CurrentPosition? position}) async {
    List<String> idsContacts = [];
    final userDoc = await firestoreService.getDocument('users', tokenId!);
    UserResultHomeModel user = UserResultHomeModel.fromDocument(userDoc);
    List<String> nonExistentContacts = [];
    for (String contact in phones!) {
      final contactCript = EncryptData().encrypty(contact).base16;
      final exist =
          await firestoreService.existDocument('contacts', contactCript);
      if (exist) {
        final doc =
            await firestoreService.getDocument('contacts', contactCript);
        idsContacts.add(doc['tokenId']);
      }
      if (!exist) {
        nonExistentContacts.add(contact);
      }
    }

    if (idsContacts.isNotEmpty) {
      for (String tokenIdContact in idsContacts) {
        final doc = await firestoreService.getDocument('chat', tokenIdContact);

        List listChat = doc['contacts'];
        final chat =
            listChat.firstWhereOrNull((chat) => chat['tokenId'] == tokenId);
        if (chat != null) {
          final userDocContact =
              await firestoreService.getDocument('users', tokenIdContact);
          UserResultHomeModel contactUserResult =
              UserResultHomeModel.fromDocument(userDocContact);
          sendMessageToUser(
              message: MessageChat(
                  date: DateTime.now().toString(),
                  text: FunctionUtils.currentLocationMessage(position!),
                  tokenId: user.tokenId),
              name: contactUserResult.name,
              photo: contactUserResult.photo,
              tokenIdContact: contactUserResult.tokenId,
              tokenIdUser: user.tokenId);
          sendMessageToUser(
              message: MessageChat(
                  date: DateTime.now().toString(),
                  text: FunctionUtils.currentLocationMessage(position),
                  tokenId: user.tokenId),
              name: user.name,
              photo: user.photo,
              tokenIdContact: user.tokenId,
              tokenIdUser: tokenIdContact);
        }
      }
    }
  }

  @override
  Future<void> addNewContacts(List<String> contacts, String tokenId) async {
    final userDoc = await firestoreService.getDocument('users', tokenId);
    UserResultHomeModel user = UserResultHomeModel.fromDocument(userDoc);
    contacts.map((e) {
      final phoneEnc = EncryptData().encrypty(e).base16;
      if (!user.contacts.contains(phoneEnc)) {
        user.contacts.add(phoneEnc);
      }
    }).toList();
    await firestoreService.updateDocument('users', tokenId, user.toMap());
  }
}
