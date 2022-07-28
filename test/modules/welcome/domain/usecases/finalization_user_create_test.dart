import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/welcome/domain/entities/final_user.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:app/app/modules/welcome/domain/usecases/finalization_user_create.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class WelcomeRepositoryImpl extends Mock implements WelcomeRepository {}

void main() {
  WelcomeRepository? repository;
  FinalizationUserCreate? usecase;

  setUpAll(() {
    repository = WelcomeRepositoryImpl();
    usecase = FinalizationUserCreate(repository!);
    registerFallbackValue(FinalizationUser(contacts: ['859877647367']));
  });

  final resultAuth = AuthResult('osos@osso.com', '1212151', true);
  final inputUsecase = FinalizationUser(contacts: ['859877647367']);

  test('Should return list of contacts', () async {
    when(() => repository!.finalizationUserCreate(any()))
        .thenAnswer((_) async => right(resultAuth));

    final result = await usecase!(inputUsecase);

    expect(result, right(resultAuth));
    verify(() => repository!.finalizationUserCreate(inputUsecase));
    verifyNoMoreInteractions(repository);
  });

  test('Should return ListContactsEmptyFailure if list of contacts is empty',
      () async {
    when(() => repository!.finalizationUserCreate(any()))
        .thenAnswer((_) async => left(ListContactsEmptyFailure()));

    final result = await usecase!(FinalizationUser(contacts: []));

    expect(result, left(ListContactsEmptyFailure()));
  });
}
