import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/refresh_account_repository.dart';
import '../datasources/refresh_account_datasource.dart';
import 'package:dartz/dartz.dart';

class RefreshAccountRepositoryImpl implements RefreshAccountRepository {
  final RefreshAccountDatasource datasource;

  RefreshAccountRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, bool>> loggedUser() async {
    try {
      final result = await datasource.loggedUser();
      return right(result);
    } on RefreshAccountException {
      return left(LoggedUserFailure());
    } catch (e) {
      return left(LoggedUserFailure());
    }
  }
}
