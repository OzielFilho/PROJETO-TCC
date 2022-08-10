import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/contacts_with_message.dart';

class GetListContactsWithMessageChat
    extends Usecase<List<ContactsWithMessage>, String> {
  final ChatHomeRepository repository;

  GetListContactsWithMessageChat(this.repository);

  @override
  Future<Either<Failure, List<ContactsWithMessage>>> call(
      String? tokenId) async {
    if (tokenId!.isEmpty) {
      return left(IdTokenFailure());
    }
    return await repository.getListContactsWithMessageChat(tokenId: tokenId);
  }
}
