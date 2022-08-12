import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_logged_info.dart';

abstract class RefreshAccountRepository {
  Future<Either<Failure, UserLoggedInfo>> loggedUser();
}
