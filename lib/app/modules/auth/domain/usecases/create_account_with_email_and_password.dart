import '../entities/auth_result.dart';
import '../repositories/create_account_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/validations/validations.dart';

class CreateAccountWithEmailAndPassword implements Usecase<AuthResult, Params> {
  final CreateAccountRepository repository;

  CreateAccountWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(Params? params) async {
    if (params!.email.isEmpty || params.password.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }
    if (!(Validations.emailValidation(email: params.email))) {
      return left(ParamsInvalidUserFailure());
    }
    if (!(Validations.passwordValidation(password: params.password))) {
      return left(ParamsInvalidUserFailure());
    }

    return await repository.createAccountWithEmailAndPassword(
        params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  Params({required this.email, required this.password});

  List<Object> get props => [email, password];
}
