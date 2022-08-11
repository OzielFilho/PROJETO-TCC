import 'package:app/app/modules/home/domain/entities/details_contact_chat.dart';
import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';
import 'package:app/app/modules/home/infra/datasources/chat_home_datasource.dart';
import 'package:app/app/modules/home/infra/models/message_chat_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class ChatHomeRepositoryImpl implements ChatHomeRepository {
  final ChatHomeDatasource datasource;

  ChatHomeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<DetailsContactChat>>>
      getListDetailsContactFromPhoneChat({List<String>? phones}) async {
    try {
      final result =
          await datasource.getListDetailsContactFromPhoneChat(phones: phones);
      return right(result);
    } on ChatHomeException {
      return left(GetDetailsContactFromPhoneFailure());
    } catch (e) {
      return left(GetDetailsContactFromPhoneFailure());
    }
  }

  @override
  Stream<List> getListContactsMessage(String tokenId) {
    return datasource.getListContactsMessage(tokenId);
  }

  @override
  Stream<List<MessageChatModel>> getListMessageChatUser(
      {String? tokenIdUserActual, String? tokenIdContact}) {
    return datasource.getListMessageChatUser(
        tokenIdContact: tokenIdContact!, tokenIdUserActual: tokenIdUserActual!);
  }
}
