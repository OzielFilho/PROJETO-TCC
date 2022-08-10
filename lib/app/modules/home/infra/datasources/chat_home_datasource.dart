import 'package:app/app/modules/home/infra/models/contacts_with_message_model.dart';

import '../models/details_contact_chat_model.dart';

abstract class ChatHomeDatasource {
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones});

  Future<List<ContactsWithMessageModel>> getListContactsWithMessageChat(
      {String tokenId});
}
