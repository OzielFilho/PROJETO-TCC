import 'package:app/app/modules/splash/domain/entities/user_logged_info.dart';

import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RefreshAccountRepository {
  Future<Either<Failure, UserLoggedInfo>> loggedUser();
}
