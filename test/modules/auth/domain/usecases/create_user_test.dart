import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/entities/user_create.dart';
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
  setUpAll(() {
    repositoryMock = CreateAccountRepositoryImpl();
    usecase = CreateAccountWithEmailAndPassword(repositoryMock!);
    registerFallbackValue(UserCreate(
        email: 'jose@hotmail.com',
        password: '1234567',
        name: 'jose',
        confirmePassword: '1234567',
        phone: '(85)98828-6381'));
  });

  group('Create User Group', () {
    final resultAuth =
        AuthResult('osos@osso.com', '1212151', true, '(85)98828-6381');
    final inputAuth = UserCreate(
        email: 'jose@hotmail.com',
        password: '1234567',
        name: 'jose',
        confirmePassword: '1234567',
        phone: '(85)98828-6381');
    test('Should create user if params is not empty', () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(inputAuth);

      expect(result, right(resultAuth));
      verify(
          () => repositoryMock!.createAccountWithEmailAndPassword(inputAuth));
      verifyNoMoreInteractions(repositoryMock);
    });

    test(
        'Should returns ParamsEmptyUserFailure if email or password or name is empty',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => left(ParamsEmptyUserFailure()));

      final result = await usecase!(UserCreate(
          email: '', password: '', name: '', confirmePassword: '', phone: ''));

      expect(result, left(ParamsEmptyUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if email is not valid',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result = await usecase!(UserCreate(
          email: 'jose.com',
          password: '12345678',
          name: 'jose',
          phone: '(85)98828-6381',
          confirmePassword: '12345678'));

      expect(result, left(ParamsInvalidUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if password is less than 6',
        () async {
      when(() => repositoryMock!.createAccountWithEmailAndPassword(any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result = await usecase!(UserCreate(
          email: 'jose@hotmail.com',
          password: '1238',
          name: 'jose',
          confirmePassword: '1238',
          phone: '(85)98828-6381'));

      expect(result, left(ParamsInvalidUserFailure()));
    });
  });
}
