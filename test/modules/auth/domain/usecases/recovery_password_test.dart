import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/repositories/recovery_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/recovery_password.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class RecoveryRepositoryImpl extends Mock implements RecoveryRepository {}

void main() {
  RecoveryPassword? usecase;
  RecoveryRepository? repositoryMock;

  setUp(() {
    repositoryMock = RecoveryRepositoryImpl();
    usecase = RecoveryPassword(repositoryMock!);
  });

  group('Recovery Password Group', () {
    final resultAuth = true;
    test('Should do send message to email if params is not empty', () async {
      when(() => repositoryMock!.recoveryPasswordWithEmail(any()))
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(Params(email: 'jose@hotmail.com'));
      expect(result, right(resultAuth));
      verify(() => repositoryMock!.recoveryPasswordWithEmail(
            'jose@hotmail.com',
          ));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('Should returns ParamsEmptyUserFailure if email  is empty', () async {
      when(() => repositoryMock!.recoveryPasswordWithEmail(any()))
          .thenAnswer((_) async => left(ParamsEmptyUserFailure()));

      final result = await usecase!(Params(
        email: '',
      ));

      expect(result, left(ParamsEmptyUserFailure()));
    });

    test('Should returns ParamsInvalidUserFailure if email is not valid',
        () async {
      when(() => repositoryMock!.recoveryPasswordWithEmail(any()))
          .thenAnswer((_) async => left(ParamsInvalidUserFailure()));

      final result = await usecase!(Params(email: 'kkk.com'));

      expect(result, left(ParamsInvalidUserFailure()));
    });
  });
}
