import 'package:app/app/modules/home/domain/entities/message_chat.dart';
import 'package:dartz/dartz.dart';

import 'package:app/app/core/error/failure.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../repositories/chat_home_repository.dart';

class SendMessageToUser extends Usecase<void, Params> {
  final ChatHomeRepository repository;

  SendMessageToUser(this.repository);

  @override
  Future<Either<Failure, void>> call(Params? params) async {
    if (params!.idTokenContact.isEmpty ||
        params.idTokenUser.isEmpty ||
        params.message.text.isEmpty ||
        params.message.tokenId.isEmpty ||
        params.name.isEmpty) {
      return left(ParamsEmptyFailure());
    }
    return await repository.sendMessageToUser(
        message: params.message,
        name: params.name,
        photo: params.photo,
        tokenIdContact: params.idTokenContact,
        tokenIdUser: params.idTokenUser);
  }
}

class Params {
  final String idTokenUser;
  final String idTokenContact;
  final MessageChat message;
  final String name;
  final String photo;

  Params(
      {required this.idTokenUser,
      required this.photo,
      required this.name,
      required this.idTokenContact,
      required this.message});
}
