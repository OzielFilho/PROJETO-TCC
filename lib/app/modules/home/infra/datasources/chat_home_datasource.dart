import '../../domain/entities/current_position.dart';
import '../../domain/entities/message_chat.dart';
import '../models/details_contact_chat_model.dart';
import '../models/message_chat_model.dart';

abstract class ChatHomeDatasource {
  Future<void> addNewContacts(List<String> contacts, String tokenId);
  Future<List<DetailsContactChatModel>> getListDetailsContactFromPhoneChat(
      {List<String>? phones});
  Stream<List> getListContactsMessage(String tokenId);
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String tokenIdUserActual, String tokenIdContact});
  Future<void> sendMessageToUser(
      {MessageChat? message,
      String tokenIdUser,
      String tokenIdContact,
      String name,
      String photo});
  Future<void> sendMessageEmergenceWithChat(
      {List<String> phones, String tokenId, CurrentPosition position});
}
