import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/create_account_repository.dart';
import 'package:app/app/modules/auth/infra/datasources/create_account_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class CreateAccountRepositoryImpl extends CreateAccountRepository {
  final CreateAccountDatasource datasource;

  CreateAccountRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, bool>> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final result =
          await datasource.createAccountWithEmailAndPassword(email, password);
      return right(result);
    } on CreateUserException {
      return left(CreateUserFailure());
    } catch (e) {
      return left(CreateUserFailure());
    }
  }
}
