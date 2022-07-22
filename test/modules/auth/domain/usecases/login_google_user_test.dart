import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
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
    final resultAuth = AuthResult('osos@osso.com', '1212151');
    test('Should do login google of user if params is not empty', () async {
      when(() => repositoryMock!.loginGoogleUser())
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(NoParams());
      expect(result, right(resultAuth));
    });
  });
}
