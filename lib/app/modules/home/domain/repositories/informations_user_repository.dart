import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:dartz/dartz.dart';

abstract class InformationUserRepository {
  Future<Either<Failure, AuthResult>> getUserHome();
}
