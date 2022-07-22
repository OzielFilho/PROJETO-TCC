import '../../../../core/error/failure.dart';
import '../../domain/repositories/recovery_repository.dart';
import '../datasources/recovery_datasource.dart';
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
      return left(RecoveryPasswordFailure());
    }
  }
}
