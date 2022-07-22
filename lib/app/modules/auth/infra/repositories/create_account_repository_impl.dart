import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/repositories/create_account_repository.dart';
import '../datasources/create_account_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';

class CreateAccountRepositoryImpl extends CreateAccountRepository {
  final CreateAccountDatasource datasource;

  CreateAccountRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, AuthResult>> createAccountWithEmailAndPassword(
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
