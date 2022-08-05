import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/update_user.dart';

class UpdateUserCreate implements Usecase<void, UpdateUserWelcome> {
  final WelcomeRepository repository;

  UpdateUserCreate(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateUserWelcome? params) async {
    if (params!.phone.isEmpty) {
      return left(PhoneEmptyFailure());
    }
    if (!Validations.phoneValidation(phone: params.phone)) {
      return left(PhoneInvalidFailure());
    }
    params.contacts.map((contact) {
      if (!Validations.phoneValidation(phone: contact)) {
        return left(PhoneInvalidFailure());
      }
    }).toList();

    if (params.contacts.isEmpty) {
      return left(ListContactsEmptyFailure());
    }
    params.contacts.map((phoneContact) {
      if (!Validations.phoneValidation(phone: phoneContact)) {
        return left(PhoneInvalidFailure());
      }
      if (phoneContact.isEmpty) {
        return left(PhoneEmptyFailure());
      }
    }).toList();

    await repository.updateUserCreate(params);
    return right(null);
  }
}
