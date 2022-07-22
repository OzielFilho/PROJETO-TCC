import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/validations/validations.dart';
import '../repositories/auth_repository.dart';

class RecoveryPassword implements Usecase<bool, Params> {
  final AuthUserRepository repository;

  RecoveryPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params? params) async {
    if (params!.email.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }
    if (!(Validations.emailValidation(email: params.email))) {
      return left(ParamsInvalidUserFailure());
    }

    return await repository.recoveryPassword(params.email);
  }
}

class Params extends Equatable {
  final String email;
  Params({required this.email});

  List<Object> get props => [email];
}
