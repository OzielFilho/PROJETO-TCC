import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_credential.dart';
import 'package:app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/login_google_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class AuthUserRepositoryI extends Mock implements AuthUserRepository {}

void main() {
  LoginGoogleUser? usecase;
  AuthUserRepository? repositoryMock;

  setUp(() {
    repositoryMock = AuthUserRepositoryI();
    usecase = LoginGoogleUser(repositoryMock!);
  });

  group('Login Google Group', () {
    final authUserE =
        AuthCredential(idToken: '12345648415', accessToken: 'ggafgafafafa');
    final resultAuth = true;
    test('Should do login google of user if params is not empty', () async {
      when(() => repositoryMock!.loginGoogleUser(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(
          Params(accessToken: '12345648415', idToken: 'ggafgafafafa'));

      expect(result, right(resultAuth));
      verifyNever(() => repositoryMock!
          .loginGoogleUser(authUserE.idToken, authUserE.accessToken));
    });

    test('Should returns ParamsLoginUserFailure if email or password is empty',
        () async {
      when(() => repositoryMock!.loginGoogleUser(any(), any()))
          .thenAnswer((_) async => left(ParamsEmptyUserFailure()));

      final result = await usecase!(Params(accessToken: '', idToken: ''));

      expect(result, left(ParamsEmptyUserFailure()));
    });
  });
}
