import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class LoginGoogleUser implements Usecase<AuthResult, NoParams> {
  final AuthUserRepository repository;

  LoginGoogleUser(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(params) async {
    final result = await repository.loginGoogleUser();
    return result.fold((l) => left(LoginFailure()), (r) => right(r));
  }
}
