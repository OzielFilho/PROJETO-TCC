import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/current_position.dart';
import '../entities/user_result_home.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, CurrentPosition>> getCurrentLocation();
  Future<Either<Failure, UserResultHome>> getUserHome();
  Future<Either<Failure, UserResultHome>> updateUser(
      {UserResultHome userUpdate});
}
