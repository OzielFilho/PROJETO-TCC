import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/login_with_email_and_password.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class LoginRepositoryImpl extends Mock implements LoginRepository {}

void main() {
  LoginWithEmailAndPassword? usecase;
  LoginRepository? repositoryMock;

  setUp(() {
    repositoryMock = LoginRepositoryImpl();
    usecase = LoginWithEmailAndPassword(repositoryMock!);
  });

  group('Login Group', () {
    final resultAuth = AuthResult(
        email: 'oziel@hotmail.com',
        tokenId: 'afafafafaf',
        welcomePage: false,
        phone: '2545gsgsgs85',
        name: 'Oziel',
        contacts: [],
        photo: 'www.com');
    test('Should do login of user if params is not empty', () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => right(resultAuth));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '123456'));

      expect(result, right(resultAuth));
      verify(() => repositoryMock!
          .loginWithEmailAndPassword('jose@hotmail.com', '123456'));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsEmptyUserFailure if email or password is empty',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsEmptyUserFailure()));

      final result = await usecase!(Params(email: '', password: ''));

      expect(result, left(ParamsEmptyUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if email is not valid',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result =
          await usecase!(Params(email: 'kkk.com', password: '1234567'));

      expect(result, left(ParamsInvalidUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if password is less than 6',
        () async {
      when(() => repositoryMock!.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result =
          await usecase!(Params(email: 'jose@hotmail.com', password: '1234'));

      expect(result, left(ParamsInvalidUserFailure()));
    });
  });
}
