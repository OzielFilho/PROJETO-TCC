import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';

import '../entities/message_chat.dart';

class GetListMessageChatUser {
  final ChatHomeRepository repository;

  GetListMessageChatUser(this.repository);

  Stream<List<MessageChat>> call(String tokenIdUser, String tokenIdContact) {
    return repository.getListMessageChatUser(
        tokenIdUserActual: tokenIdUser, tokenIdContact: tokenIdContact);
  }
}
