import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_result_home.dart';
import '../repositories/home_repository.dart';

class GetUserHome extends Usecase<UserResultHome, NoParams> {
  final HomeRepository repository;

  GetUserHome(this.repository);

  @override
  Future<Either<Failure, UserResultHome>> call(NoParams? params) async {
    return await repository.getUserHome();
  }
}
