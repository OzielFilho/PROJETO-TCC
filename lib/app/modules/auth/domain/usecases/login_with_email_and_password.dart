import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/auth_result.dart';

class LoginWithEmailAndPassword implements Usecase<AuthResult, Params> {
  final LoginRepository repository;

  LoginWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(Params? params) async {
    if (params!.email.isEmpty || params.password.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }

    if (!(Validations.passwordValidation(password: params.password))) {
      return left(ParamsInvalidUserFailure());
    }

    if (!(Validations.emailValidation(email: params.email))) {
      return left(ParamsInvalidUserFailure());
    }
    final result = await repository.loginWithEmailAndPassword(
        params.email, params.password);

    return result;
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  Params({required this.email, required this.password});

  List<Object> get props => [email, password];
}