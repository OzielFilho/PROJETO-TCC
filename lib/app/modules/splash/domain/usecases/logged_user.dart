import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_logged_info.dart';
import '../repositories/refresh_account_repository.dart';

class LoggedUser implements Usecase<UserLoggedInfo, NoParams> {
  final RefreshAccountRepository repository;

  LoggedUser(this.repository);

  @override
  Future<Either<Failure, UserLoggedInfo>> call(noParams) async {
    return await repository.loggedUser();
  }
}
