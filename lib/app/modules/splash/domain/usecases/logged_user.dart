import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/refresh_account_repository.dart';
import 'package:dartz/dartz.dart';

class LoggedUser implements Usecase<bool, NoParams> {
  final RefreshAccountRepository repository;

  LoggedUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(noParams) async {
    return await repository.loggedUser();
  }
}
