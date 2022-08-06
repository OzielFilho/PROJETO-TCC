import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/home/domain/repositories/informations_user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserHome extends Usecase<AuthResult, NoParams> {
  final InformationUserRepository repository;

  GetUserHome(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(NoParams? params) async {
    return await repository.getUserHome();
  }
}
