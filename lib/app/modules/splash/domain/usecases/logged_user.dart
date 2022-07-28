import 'package:app/app/modules/splash/domain/entities/user_logged_info.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/refresh_account_repository.dart';
import 'package:dartz/dartz.dart';

class LoggedUser implements Usecase<UserLoggedInfo, NoParams> {
  final RefreshAccountRepository repository;

  LoggedUser(this.repository);

  @override
  Future<Either<Failure, UserLoggedInfo>> call(noParams) async {
    return await repository.loggedUser();
  }
}
