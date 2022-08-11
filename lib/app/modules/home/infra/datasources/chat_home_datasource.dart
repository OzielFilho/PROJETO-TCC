import '../models/details_contact_chat_model.dart';

abstract class ChatHomeDatasource {
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones});
  Stream<List> getListContactsMessage(String tokenId);
}
