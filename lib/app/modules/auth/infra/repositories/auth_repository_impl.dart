import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app/app/modules/auth/infra/datasources/auth_user_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class AuthUserRepositoryImpl extends AuthUserRepository {
  final AuthUserDatasource datasource;

  AuthUserRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, bool>> loginUser(String email, String password) async {
    try {
      final result = await datasource.login(email, password);
      return right(result);
    } on LoginException {
      return left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> loginGoogleUser(
      String idToken, String accessToken) async {
    try {
      final result = await datasource.loginGoogle(idToken, accessToken);
      return right(result);
    } on LoginException {
      return left(LoginFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> createUser(
      String email, String password) async {
    try {
      final result = await datasource.createUser(email, password);
      return right(result);
    } on CreateUserException {
      return left(CreateUserFailure());
    }
  }
}
