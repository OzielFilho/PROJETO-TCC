import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/details_contact_chat.dart';
import '../entities/message_chat.dart';

abstract class ChatHomeRepository {
  Stream<List> getListContactsMessage(String tokenId);
  Stream<List<MessageChat>> getListMessageChatUser(
      {String tokenIdUserActual, String tokenIdContact});
  Future<Either<Failure, List<DetailsContactChat>>>
      getListDetailsContactFromPhoneChat({List<String> phones});
}
