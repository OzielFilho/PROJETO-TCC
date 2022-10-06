import 'dart:io';

import 'package:app/app/core/services/network_service.dart';
import 'package:app/app/modules/auth/domain/entities/user_create_account.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/create_account_repository.dart';
import '../datasources/create_account_datasource.dart';
import '../models/user_create_account_model.dart';

class CreateAccountRepositoryImpl extends CreateAccountRepository {
  final CreateAccountDatasource datasource;
  final NetworkService _networkService;
  CreateAccountRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, String>> createWithEmailAndPassword(
      UserCreateAccount user, File? image) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }

    try {
      final result = await datasource.createWithEmailAndPassword(
          UserCreateAccountModel.fromUser(user), image);
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
