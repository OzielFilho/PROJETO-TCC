import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';

class GetListContactsMessage {
  final ChatHomeRepository repository;

  GetListContactsMessage(this.repository);

  Stream<List> call(String tokenId) {
    return repository.getListContactsMessage(tokenId);
  }
}
