import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/auth_result.dart';
import '../entities/final_user.dart';

abstract class WelcomeRepository {
  Future<Either<Failure, AuthResult>> finalizationUserCreate(
      FinalizationUser user);
}
