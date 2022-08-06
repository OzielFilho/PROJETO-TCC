import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/repositories/informations_user_repository.dart';
import 'package:app/app/modules/home/infra/datasources/informations_user_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class InformationsUserRepositoryImpl implements InformationUserRepository {
  final InformationUserDatasource datasource;

  InformationsUserRepositoryImpl(this.datasource);

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
