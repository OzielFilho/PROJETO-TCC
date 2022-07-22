import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class RecoveryRepository {
  Future<Either<Failure, bool>> recoveryPasswordWithEmail(String email);
}
