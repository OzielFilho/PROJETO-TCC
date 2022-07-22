import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/auth_repository.dart';

class LoginGoogleUser implements Usecase<bool, Params> {
  final AuthUserRepository repository;

  LoginGoogleUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    if (params.accessToken.isNotEmpty || params.idToken.isNotEmpty) {
      return await repository.loginGoogleUser(
          params.idToken, params.accessToken);
    }
    return left(ParamsEmptyUserFailure());
  }
}

class Params extends Equatable {
  final String idToken;
  final String accessToken;
  Params({required this.idToken, required this.accessToken});

  List<Object> get props => [idToken, accessToken];
}
