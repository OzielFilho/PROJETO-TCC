import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_result.dart';

class LoginWithGoogle implements Usecase<AuthResult, NoParams> {
  final LoginRepository repository;

  LoginWithGoogle(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(params) async {
    final result = await repository.loginGoogleUser();
    return result.fold((l) => left(LoginFailure()), (r) => right(r));
  }
}
