import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/recovery_repository.dart';
import 'package:app/app/modules/auth/infra/datasources/recovery_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class RecoveryRepositoryImpl extends RecoveryRepository {
  final RecoveryDatasource datasource;

  RecoveryRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, bool>> recoveryPasswordWithEmail(String email) async {
    try {
      final result = await datasource.recoveryWithEmail(email);
      return right(result);
    } on RecoveryPasswordException {
      return left(RecoveryPasswordFailure());
    } catch (e) {
      return left(LoginFailure());
    }
  }
}
