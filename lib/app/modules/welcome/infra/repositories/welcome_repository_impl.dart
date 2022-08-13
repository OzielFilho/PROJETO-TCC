import 'package:app/app/core/services/network_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/auth_result.dart';
import '../../domain/entities/update_user.dart';
import '../../domain/repositories/welcome_repository.dart';
import '../datasources/welcome_datasource.dart';
import '../models/update_user_model.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeDatasource datasource;
  final NetworkService _networkService;
  WelcomeRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, void>> updateUserCreate(UpdateUserWelcome user) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource
          .updateUserCreate(UpdateUserWelcomeModel.fromFinalizationUser(user));
      return right(result);
    } on UpdateUserErrorException {
      return left(UpdateUserFailure());
    } catch (e) {
      return left(UpdateUserFailure());
    }
  }

  @override
  Future<Either<Failure, AuthResult>> getUserCreate() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.getUserCreate();
      return right(result);
    } catch (e) {
      return left(GetUserFailure());
    }
  }
}
