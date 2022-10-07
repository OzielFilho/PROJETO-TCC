import '../../../../core/services/network_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_datasource.dart';

class LoginRepositoryImpl extends LoginRepository {
  final NetworkService _networkService;
  final LoginDatasource datasource;

  LoginRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, AuthResult>> loginGoogleUser() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
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
  Future<Either<Failure, String>> loginWithEmailAndPassword(
      String email, String password) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
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
