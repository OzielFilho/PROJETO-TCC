import '../../entities/current_position.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/chat_home_repository.dart';

class SendMessageEmergenceWithChat extends Usecase<void, Params> {
  final ChatHomeRepository repository;

  SendMessageEmergenceWithChat(this.repository);

  @override
  Future<Either<Failure, void>> call(Params? params) async {
    if (params!.contacts.isEmpty || params.idTokenUser.isEmpty) {
      return left(ParamsEmptyFailure());
    }
    return await repository.sendMessageEmergenceWithChat(
        phones: params.contacts,
        tokenId: params.idTokenUser,
        position: params.position);
  }
}

class Params {
  final String idTokenUser;
  final List<String> contacts;
  final CurrentPosition position;
  Params({
    required this.position,
    required this.idTokenUser,
    required this.contacts,
  });
}
