import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:app/app/modules/auth/infra/datasources/login_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, AuthResult>> loginGoogleUser() async {
    try {
      final result = await datasource.loginWithGoogle();
      return right(result);
    } on LoginException {
      return left(LoginFailure());
    } catch (e) {
      return left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResult>> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final result =
          await datasource.loginWithEmailAndPassword(email, password);
      return right(result);
    } on LoginException {
      return left(LoginFailure());
    } catch (e) {
      return left(LoginFailure());
    }
  }
}
