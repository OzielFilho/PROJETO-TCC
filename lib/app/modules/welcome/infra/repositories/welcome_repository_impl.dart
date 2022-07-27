import 'package:app/app/modules/welcome/domain/entities/final_user.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:app/app/modules/welcome/infra/datasources/welcome_datasource.dart';
import 'package:app/app/modules/welcome/infra/models/finalization_user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeDatasource datasource;

  WelcomeRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, AuthResult>> finalizationUserCreate(
      FinalizationUser user) async {
    try {
      final result = await datasource.finalizationUserCreate(
          FinalizationUserModel.fromFinalizationUser(user));
      return right(result);
    } on FinalizationUserException {
      return left(FinalizationUserFailure());
    } catch (e) {
      return left(FinalizationUserFailure());
    }
  }
}
