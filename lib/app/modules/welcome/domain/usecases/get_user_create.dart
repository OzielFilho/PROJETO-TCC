import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserCreate implements Usecase<AuthResult, NoParams> {
  final WelcomeRepository repository;

  GetUserCreate(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(NoParams? params) async {
    return await repository.getUserCreate();
  }
}
