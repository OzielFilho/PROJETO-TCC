import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_result.dart';

abstract class LoginRepository {
  Future<Either<Failure, AuthResult>> loginWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, AuthResult>> loginGoogleUser();
}
