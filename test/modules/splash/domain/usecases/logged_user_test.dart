import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/splash/domain/entities/user_logged_info.dart';
import 'package:app/app/modules/splash/domain/repositories/refresh_account_repository.dart';
import 'package:app/app/modules/splash/domain/usecases/logged_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class RefreshAccountRepositoryImpl extends Mock
    implements RefreshAccountRepository {}

void main() {
  LoggedUser? usecase;
  RefreshAccountRepository? repository;
  UserLoggedInfo? userLoggedInfo;
  setUp(() {
    repository = RefreshAccountRepositoryImpl();
    usecase = LoggedUser(repository!);
    userLoggedInfo = UserLoggedInfo(
        logged: true, welcomePage: true, phone: '(85)98828-6381');
  });

  test('Should return true if user logged', () async {
    when(() => repository!.loggedUser())
        .thenAnswer((_) async => right(userLoggedInfo!));

    final result = await usecase!(NoParams());

    expect(result, right(userLoggedInfo));
    verify(() => repository!.loggedUser());
    verifyNoMoreInteractions(repository);
  });

  test('Should return false if user dont logged', () async {
    when(() => repository!.loggedUser())
        .thenAnswer((_) async => right(userLoggedInfo!));

    final result = await usecase!(NoParams());

    expect(result, right(userLoggedInfo));
    verify(() => repository!.loggedUser());
    verifyNoMoreInteractions(repository);
  });
}
