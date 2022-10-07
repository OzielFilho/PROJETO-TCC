import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_result_home.dart';
import '../repositories/home_repository.dart';
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
