import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/auth_result.dart';
import '../repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserCreate implements Usecase<AuthResult, NoParams> {
  final WelcomeRepository repository;

  GetUserCreate(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(NoParams? params) async {
    return await repository.getUserCreate();
  }
}
