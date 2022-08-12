import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUser extends Usecase<void, void> {
  final HomeRepository repository;

  LogoutUser(this.repository);
  @override
  Future<Either<Failure, void>> call(void params) {
    return repository.logoutUser();
  }
}
