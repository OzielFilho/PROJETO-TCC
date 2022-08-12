import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/chat_home_repository.dart';
import 'package:dartz/dartz.dart';

import '../../entities/details_contact_chat.dart';

class GetListDetailsContactFromPhoneChat
    extends Usecase<List<DetailsContactChat>, List<String>> {
  final ChatHomeRepository repository;

  GetListDetailsContactFromPhoneChat(this.repository);
  @override
  Future<Either<Failure, List<DetailsContactChat>>> call(
      List<String>? phones) async {
    if (phones!.isEmpty) {
      return left(ListPhoneEmptyFailure());
    }

    return await repository.getListDetailsContactFromPhoneChat(phones: phones);
  }
}
