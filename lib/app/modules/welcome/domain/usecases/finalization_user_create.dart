import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/final_user.dart';

class FinalizationUserCreate implements Usecase<AuthResult, FinalizationUser> {
  final WelcomeRepository repository;

  FinalizationUserCreate(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(FinalizationUser? params) async {
    if (params!.contacts.isEmpty) {
      return left(ListContactsEmptyFailure());
    }
    return await repository.finalizationUserCreate(params);
  }
}
