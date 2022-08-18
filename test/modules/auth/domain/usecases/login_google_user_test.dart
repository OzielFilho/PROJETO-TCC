import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/auth/domain/repositories/login_repository.dart';
import 'package:app/app/modules/auth/domain/usecases/login_with_google_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

class LoginRepositoryImpl extends Mock implements LoginRepository {}

void main() {
  LoginWithGoogle? usecase;
  LoginRepository? repositoryMock;

  setUp(() {
    repositoryMock = LoginRepositoryImpl();
    usecase = LoginWithGoogle(repositoryMock!);
  });

  group('Login Google Group', () {
    final resultAuth = AuthResult(
        email: 'oziel@hotmail.com',
        tokenId: 'afafafafaf',
        welcomePage: false,
        phone: '2545gsgsgs85',
        name: 'Oziel',
        contacts: [],
        photo: 'www.com');
    test('Should do login google of user if params is not empty', () async {
      when(() => repositoryMock!.loginGoogleUser())
          .thenAnswer((_) async => right(resultAuth));

      final result = await usecase!(NoParams());
      expect(result, right(resultAuth));
    });
  });
}
