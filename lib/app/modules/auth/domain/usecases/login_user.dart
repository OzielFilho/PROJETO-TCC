import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/core/utils/validations/validations.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements Usecase<AuthResult, Params> {
  final AuthUserRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(Params params) async {
    if (params.email.isNotEmpty || params.password.isNotEmpty) {
      if (Validations.emailAndPasswordValidation(
          email: params.email, password: params.password)) {
        return await repository.loginUser(params.email, params.password);
      }
    }
    return left(ParamsLoginUserFailure());
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  Params({required this.email, required this.password});

  List<Object> get props => [email, password];
}
