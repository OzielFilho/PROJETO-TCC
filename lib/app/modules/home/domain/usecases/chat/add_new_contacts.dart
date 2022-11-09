import 'package:app/app/core/utils/validations/validations.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../repositories/chat_home_repository.dart';

class AddNewContacts extends Usecase<void, Params> {
  final ChatHomeRepository repository;

  AddNewContacts(this.repository);

  @override
  Future<Either<Failure, void>> call(Params? params) async {
    if (params!.contacts.isEmpty || params.tokenId.isEmpty) {
      return left(ParamsEmptyFailure());
    }
    if (params.contacts.isNotEmpty) {
      final listValidation = params.contacts
          .map((e) => Validations.phoneValidation(phone: e))
          .toList();
      if (listValidation.contains(false)) {
        return left(ParamsInvalidFailure());
      }
    }
    return await repository.addNewContacts(params.contacts, params.tokenId);
  }
}

class Params extends Equatable {
  final String tokenId;
  final List<String> contacts;

  Params(this.tokenId, this.contacts);
  @override
  List<Object?> get props => [tokenId, contacts];
}
