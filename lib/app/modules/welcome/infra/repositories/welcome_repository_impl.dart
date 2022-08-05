import '../../domain/entities/update_user.dart';
import '../../../auth/domain/entities/auth_result.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/welcome_repository.dart';
import '../datasources/welcome_datasource.dart';
import '../models/update_user_model.dart';
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
