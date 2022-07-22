import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, bool>> createAccountWithEmailAndPassword(
      String email, String password);
}
