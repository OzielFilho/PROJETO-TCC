import '../../../../core/services/network_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/recovery_repository.dart';
import '../datasources/recovery_datasource.dart';

class RecoveryRepositoryImpl extends RecoveryRepository {
  final RecoveryDatasource datasource;
  final NetworkService _networkService;
  RecoveryRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, bool>> recoveryPasswordWithEmail(String email) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
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
