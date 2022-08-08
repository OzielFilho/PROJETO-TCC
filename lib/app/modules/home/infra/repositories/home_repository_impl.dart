import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/entities/current_position.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:app/app/modules/home/infra/datasources/home_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> logoutUser() async {
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
  Future<Either<Failure, AuthResult>> getUserHome() async {
    try {
      final result = await datasource.getUserHome();
      return right(result);
    } on InformationsUserException {
      return left(GetUserFailure());
    } catch (e) {
      return left(GetUserFailure());
    }
  }
}
