import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/repositories/create_account_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/create_account_with_email_and_password.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class CreateAccountRepositoryImpl extends Mock
    implements CreateAccountRepository {}

void main() {
  CreateAccountWithEmailAndPassword? usecase;
  CreateAccountRepository? repositoryMock;

  setUp(() {
    repositoryMock = CreateAccountRepositoryImpl();
    usecase = CreateAccountWithEmailAndPassword(repositoryMock!);
  });

  group('Create User Group', () {
    final resultAuth = AuthResult('osos@osso.com', '1212151');
    test('Should create user if params is not empty', () async {
      when(() =>
              repositoryMock!.createAccountWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '123456'));

      expect(result, right(resultAuth));
      verify(() => repositoryMock!
          .createAccountWithEmailAndPassword('jose@hotmail.com', '123456'));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsEmptyUserFailure if email or password is empty',
        () async {
      when(() =>
              repositoryMock!.createAccountWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsEmptyUserFailure()));

      final result = await usecase!(Params(email: '', password: ''));

      expect(result, left(ParamsEmptyUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if email is not valid',
        () async {
      when(() =>
              repositoryMock!.createAccountWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result =
          await usecase!(Params(email: 'kkk.com', password: '1234567'));

      expect(result, left(ParamsInvalidUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if password is less than 6',
        () async {
      when(() =>
              repositoryMock!.createAccountWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '1234'));

      expect(result, left(ParamsInvalidUserFailure()));
    });
  });
}
