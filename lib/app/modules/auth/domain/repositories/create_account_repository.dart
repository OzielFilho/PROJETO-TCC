import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_result.dart';
import '../entities/user_create.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, AuthResult>> createAccountWithEmailAndPassword(
      UserCreate user);
}
