import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/domain/entities/auth_result.dart';
import '../entities/current_position.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, CurrentPosition>> getCurrentLocation();
  Future<Either<Failure, AuthResult>> getUserHome();
}
