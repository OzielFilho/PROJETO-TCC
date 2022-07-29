import 'package:app/app/modules/welcome/domain/entities/update_user.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:app/app/modules/welcome/infra/datasources/welcome_datasource.dart';
import 'package:app/app/modules/welcome/infra/models/update_user_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class WelcomeRepositoryImpl implements WelcomeRepository {
  final WelcomeDatasource datasource;

  WelcomeRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, void>> updateUserCreate(UpdateUserWelcome user) async {
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
    try {
      final result = await datasource.getUserCreate();
      return right(result);
    } catch (e) {
      return left(GetUserFailure());
    }
  }
}
