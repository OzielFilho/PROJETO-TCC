import '../../domain/entities/details_contact_chat.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/message_chat.dart';
import '../../domain/repositories/chat_home_repository.dart';
import '../datasources/chat_home_datasource.dart';
import '../models/message_chat_model.dart';
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

  @override
  Future<Either<Failure, void>> sendMessageToUser(
      {MessageChat? message,
      String? tokenIdUser,
      String? tokenIdContact,
      String? name}) async {
    try {
      final result = await datasource.sendMessageToUser(
          message: message,
          tokenIdContact: tokenIdContact!,
          tokenIdUser: tokenIdUser!,
          name: name!);
      return right(result);
    } on ChatHomeException {
      return left(SendMessageUserFailure());
    } catch (e) {
      return left(SendMessageUserFailure());
    }
  }
}
