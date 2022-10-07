import '../../../../core/services/network_service.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/current_position.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/user_result_home.dart';
import '../models/user_result_home_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;
  final NetworkService _networkService;
  HomeRepositoryImpl(this.datasource, this._networkService);

  @override
  Future<Either<Failure, void>> logoutUser() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.logoutUser();
      return right(result);
    } on LogoutUserErrorException {
      return left(LogoutUserFailure());
    } catch (e) {
      return left(LogoutUserFailure());
    }
  }

  @override
  Future<Either<Failure, CurrentPosition>> getCurrentLocation() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.getCurrentLocation();
      return right(result);
    } on InformationsMapException {
      return left(GetCurrentLocationFailure());
    } catch (e) {
      return left(GetCurrentLocationFailure());
    }
  }

  @override
  Future<Either<Failure, UserResultHome>> getUserHome() async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.getUserHome();
      return right(result);
    } on InformationsUserException {
      return left(GetUserFailure());
    } catch (e) {
      return left(GetUserFailure());
    }
  }

  @override
  Future<Either<Failure, UserResultHome>> updateUser(
      {UserResultHome? userUpdate}) async {
    if (!(await _networkService.hasConnection)) {
      return left(NetworkFailure());
    }
    try {
      final result = await datasource.updateUser(
          updateUser: UserResultHomeModel.fromUserResultHome(userUpdate!));
      return right(result);
    } on InformationsUserException {
      return left(GetUserFailure());
    } catch (e) {
      return left(GetUserFailure());
    }
  }
}
