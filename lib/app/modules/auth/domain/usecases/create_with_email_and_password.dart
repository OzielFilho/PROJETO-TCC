import 'dart:io';

import '../repositories/create_account_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/validations/validations.dart';
import '../entities/user_create_account.dart';

class CreateWithEmailAndPassword extends Usecase<String, Params> {
  final CreateAccountRepository _repository;

  CreateWithEmailAndPassword(this._repository);
  @override
  Future<Either<Failure, String>> call(Params? params) async {
    if (params!.userCreateAccount!.email.isEmpty ||
        params.userCreateAccount!.password.isEmpty ||
        params.userCreateAccount!.confirmePassword.isEmpty ||
        params.userCreateAccount!.name.isEmpty ||
        params.userCreateAccount!.phone.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }
    if (!(Validations.emailValidation(
        email: params.userCreateAccount!.email))) {
      return left(ParamsInvalidUserFailure());
    }
    if (!(Validations.phoneValidation(
        phone: params.userCreateAccount!.phone))) {
      return left(PhoneInvalidFailure());
    }
    if (params.userCreateAccount!.password !=
        params.userCreateAccount!.confirmePassword) {
      return left(PasswordAndConfirmePasswordDifferenceFailure());
    }

    if (!(Validations.passwordValidation(
            password: params.userCreateAccount!.password)) &&
        !(Validations.passwordValidation(
            password: params.userCreateAccount!.confirmePassword))) {
      return left(ParamsInvalidUserFailure());
    }
    return await _repository.createWithEmailAndPassword(
        params.userCreateAccount!, params.image);
  }
}

class Params extends Equatable {
  final UserCreateAccount? userCreateAccount;
  final File? image;

  const Params(this.userCreateAccount, this.image);
  @override
  List<Object?> get props => [userCreateAccount, image];
}
