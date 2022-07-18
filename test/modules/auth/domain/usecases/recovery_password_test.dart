import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/recovery_password.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class AuthUserRepositoryI extends Mock implements AuthUserRepository {}

void main() {
  RecoveryPassword? usecase;
  AuthUserRepository? repositoryMock;

  setUp(() {
    repositoryMock = AuthUserRepositoryI();
    usecase = RecoveryPassword(repositoryMock!);
  });

  group('Recovery Password Group', () {
    final resultAuth = true;
    test('Should do send message to email if params is not empty', () async {
      when(() => repositoryMock!.recoveryPassword(any()))
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(Params(email: 'jose@hotmail.com'));

      expect(result, right(resultAuth));
      verify(() => repositoryMock!.recoveryPassword(
            'jose@hotmail.com',
          ));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsRecoveryPasswordFailure if email  is empty',
        () async {
      when(() => repositoryMock!.recoveryPassword(any()))
          .thenAnswer((_) async => left(ParamsRecoveryPasswordFailure()));

      final result = await usecase!(Params(
        email: '',
      ));

      expect(result, left(ParamsRecoveryPasswordFailure()));
    });

    test('Should returns ParamsRecoveryPasswordFailure if email is not valid',
        () async {
      when(() => repositoryMock!.recoveryPassword(any()))
          .thenAnswer((_) async => left(ParamsRecoveryPasswordFailure()));

      final result = await usecase!(Params(email: 'kkk.com'));

      expect(result, left(ParamsRecoveryPasswordFailure()));
    });
  });
}
