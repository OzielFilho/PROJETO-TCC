import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_user.dart';
import 'package:app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class AuthUserRepositoryI extends Mock implements AuthUserRepository {}

void main() {
  CreateUser? usecase;
  AuthUserRepository? repositoryMock;

  setUp(() {
    repositoryMock = AuthUserRepositoryI();
    usecase = CreateUser(repositoryMock!);
  });

  group('Create User Group', () {
    final authUserE = AuthUser(email: 'jose@hotmail.com', password: '123456');
    final resultAuth = true;
    test('Should create user if params is not empty', () async {
      when(() => repositoryMock!.createUser(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '123456'));

      expect(result, right(resultAuth));
      verify(() =>
          repositoryMock!.createUser(authUserE.email, authUserE.password));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsCreateUserFailure if email or password is empty',
        () async {
      when(() => repositoryMock!.createUser(any(), any()))
          .thenAnswer((_) async => left(ParamsCreateUserFailure()));

      final result = await usecase!(Params(email: '', password: ''));

      expect(result, left(ParamsCreateUserFailure()));
    });

    test('Should returns ParamsCreateUserFailure if email is not valid',
        () async {
      when(() => repositoryMock!.createUser(any(), any()))
          .thenAnswer((_) async => left(ParamsCreateUserFailure()));

      final result =
          await usecase!(Params(email: 'kkk.com', password: '1234567'));

      expect(result, left(ParamsCreateUserFailure()));
    });

    test('Should returns ParamsCreateUserFailure if password is less than 6',
        () async {
      when(() => repositoryMock!.createUser(any(), any()))
          .thenAnswer((_) async => left(ParamsCreateUserFailure()));

      final result =
          await usecase!(Params(email: authUserE.email, password: '1234'));

      expect(result, left(ParamsCreateUserFailure()));
    });
  });
}
