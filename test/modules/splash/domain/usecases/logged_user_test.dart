import 'package:app/app/core/usecases/usecase.dart';
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

  setUp(() {
    repository = RefreshAccountRepositoryImpl();
    usecase = LoggedUser(repository!);
  });

  test('Should return true if user logged', () async {
    when(() => repository!.loggedUser()).thenAnswer((_) async => right(true));

    final result = await usecase!(NoParams());

    expect(result, right(true));
    verify(() => repository!.loggedUser());
    verifyNoMoreInteractions(repository);
  });

  test('Should return false if user dont logged', () async {
    when(() => repository!.loggedUser()).thenAnswer((_) async => right(false));

    final result = await usecase!(NoParams());

    expect(result, right(false));
    verify(() => repository!.loggedUser());
    verifyNoMoreInteractions(repository);
  });
}
