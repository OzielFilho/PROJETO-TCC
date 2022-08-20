import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/entities/user_result_home.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserHome extends Usecase<UserResultHome, UserResultHome> {
  final HomeRepository repository;

  UpdateUserHome(this.repository);
  @override
  Future<Either<Failure, UserResultHome>> call(UserResultHome? params) async {
    if (params!.name.isEmpty) {
      return left(ParamsEmptyFailure());
    }
    return await repository.updateUser(userUpdate: params);
  }
}
