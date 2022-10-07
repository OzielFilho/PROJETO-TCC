import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/services/network_service.dart';
import '../../domain/repositories/refresh_account_repository.dart';
import '../datasources/refresh_account_datasource.dart';
import '../models/user_logged_info_model.dart';

class RefreshAccountRepositoryImpl implements RefreshAccountRepository {
  final RefreshAccountDatasource datasource;
  final NetworkService _networkService;
  RefreshAccountRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, UserLoggedInfoModel>> loggedUser() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.loggedUser();
      return right(result);
    } on RefreshAccountException {
      return left(LoggedUserFailure());
    } catch (e) {
      return left(LoggedUserFailure());
    }
  }
}
