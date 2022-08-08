import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:dartz/dartz.dart';

import '../repositories/home_repository.dart';

class GetUserHome extends Usecase<AuthResult, NoParams> {
  final HomeRepository repository;

  GetUserHome(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(NoParams? params) async {
    return await repository.getUserHome();
  }
}
