import 'package:app/app/core/services/network_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user_create.dart';
import '../../domain/repositories/create_account_repository.dart';
import '../datasources/create_account_datasource.dart';
import '../models/user_create_model.dart';

class CreateAccountRepositoryImpl extends CreateAccountRepository {
  final CreateAccountDatasource datasource;
  final NetworkService _networkService;
  CreateAccountRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, AuthResult>> createAccountWithEmailAndPassword(
      UserCreate user) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.createAccountWithEmailAndPassword(
          UserCreateModel.fromUserCreate(user));
      return right(result);
    } on CreateUserException {
      return left(CreateUserFailure());
    } on PhoneExistException {
      return left(PhoneExistFailure());
    } catch (e) {
      return left(CreateUserFailure());
    }
  }
}
