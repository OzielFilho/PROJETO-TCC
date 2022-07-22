import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/validations/validations.dart';
import '../repositories/auth_repository.dart';

class CreateUser implements Usecase<bool, Params> {
  final AuthUserRepository repository;

  CreateUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params? params) async {
    if (params!.email.isEmpty || params.password.isEmpty) {
      return left(ParamsEmptyUserFailure());
    }
    if (!(Validations.emailValidation(email: params.email))) {
      return left(ParamsInvalidUserFailure());
    }
    if (!(Validations.passwordValidation(password: params.password))) {
      return left(ParamsInvalidUserFailure());
    }

    return await repository.createUser(params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;
  Params({required this.email, required this.password});

  List<Object> get props => [email, password];
}
