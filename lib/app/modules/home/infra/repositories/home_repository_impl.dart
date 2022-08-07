import 'package:app/app/core/error/failure.dart';
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
}
