import '../entities/user_create.dart';

import '../entities/auth_result.dart';
import '../repositories/create_account_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/validations/validations.dart';

class CreateAccountWithEmailAndPassword
    implements Usecase<AuthResult, UserCreate> {
  final CreateAccountRepository repository;

  CreateAccountWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(UserCreate? params) async {
    if (params!.email.isEmpty ||
        params.password.isEmpty ||
        params.confirmePassword.isEmpty ||
        params.name.isEmpty ||
        params.phone.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }
    if (!(Validations.emailValidation(email: params.email))) {
      return left(ParamsInvalidUserFailure());
    }
    if (!(Validations.phoneValidation(phone: params.phone))) {
      return left(PhoneInvalidFailure());
    }
    if (params.password != params.confirmePassword) {
      return left(PasswordAndConfirmePasswordDifferenceFailure());
    }

    if (!(Validations.passwordValidation(password: params.password)) &&
        !(Validations.passwordValidation(password: params.confirmePassword))) {
      return left(ParamsInvalidUserFailure());
    }

    return await repository.createAccountWithEmailAndPassword(params);
  }
}
