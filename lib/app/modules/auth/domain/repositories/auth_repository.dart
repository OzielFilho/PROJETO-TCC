import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_result.dart';

abstract class AuthUserRepository {
  Future<Either<Failure, AuthResult>> loginWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, bool>> loginGoogleUser(
      String idToken, String accessToken);
  Future<Either<Failure, bool>> createUser(String email, String password);
  Future<Either<Failure, bool>> recoveryPassword(String email);
}
