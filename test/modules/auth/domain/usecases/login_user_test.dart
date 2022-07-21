import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/entities/auth_user.dart';
import 'package:app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class AuthUserRepositoryI extends Mock implements AuthUserRepository {}

void main() {
  LoginUser? usecase;
  AuthUserRepository? repositoryMock;

  setUp(() {
    repositoryMock = AuthUserRepositoryI();
    usecase = LoginUser(repositoryMock!);
  });

  group('Login Group', () {
    final authUserE = AuthUser(email: 'jose@hotmail.com', password: '123456');
    final resultAuth = AuthResult('oziel@hotmail.com', 'sfdadad');
    test('Should do login of user if params is not empty', () async {
      when(() => repositoryMock!.loginUser(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '123456'));

      expect(result, right(resultAuth));
      verify(
          () => repositoryMock!.loginUser(authUserE.email, authUserE.password));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsLoginUserFailure if email or password is empty',
        () async {
      when(() => repositoryMock!.loginUser(any(), any()))
          .thenAnswer((_) async => left(ParamsLoginUserFailure()));

      final result = await usecase!(Params(email: '', password: ''));

      expect(result, left(ParamsLoginUserFailure()));
    });

    test('Should returns ParamsLoginUserFailure if email is not valid',
        () async {
      when(() => repositoryMock!.loginUser(any(), any()))
          .thenAnswer((_) async => left(ParamsLoginUserFailure()));

      final result =
          await usecase!(Params(email: 'kkk.com', password: '1234567'));

      expect(result, left(ParamsLoginUserFailure()));
    });

    test('Should returns ParamsLoginUserFailure if password is less than 6',
        () async {
      when(() => repositoryMock!.loginUser(any(), any()))
          .thenAnswer((_) async => left(ParamsLoginUserFailure()));

      final result =
          await usecase!(Params(email: authUserE.email, password: '1234'));

      expect(result, left(ParamsLoginUserFailure()));
    });
  });
}
