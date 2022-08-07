import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUser extends Usecase<void, void> {
  final HomeRepository repository;

  LogoutUser(this.repository);
  @override
  Future<Either<Failure, void>> call(void params) {
    return repository.logoutUser();
  }
}
