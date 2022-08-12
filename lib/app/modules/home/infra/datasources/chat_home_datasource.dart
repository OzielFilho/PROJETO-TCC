import '../models/message_chat_model.dart';

import '../models/details_contact_chat_model.dart';

abstract class ChatHomeDatasource {
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones});
  Stream<List> getListContactsMessage(String tokenId);
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String tokenIdUserActual, String tokenIdContact});
}
