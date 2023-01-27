import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../authentication/utils/entities/auth_result.dart';
import '../entities/update_user.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, void>> updateUserCreate(UpdateUserWelcome user);
  Future<Either<Failure, AuthResult>> getUserCreate();
}
