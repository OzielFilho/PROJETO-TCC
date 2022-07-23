import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/entities/user_create.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, AuthResult>> createAccountWithEmailAndPassword(
      UserCreate user);
}
