import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/welcome/domain/entities/update_user.dart';
import 'package:app/app/modules/welcome/domain/repositories/welcome_repository.dart';
import 'package:app/app/modules/welcome/domain/usecases/update_user_create.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class WelcomeRepositoryImpl extends Mock implements WelcomeRepository {}

void main() {
  UpdateUserCreate? usecase;
  WelcomeRepository? repository;
  UpdateUserWelcome? updateUser;
  setUpAll(() {
    registerFallbackValue(UpdateUserWelcome(
        contacts: ['(85)98845-1235'],
        email: 'oziel@hotmail.com',
        name: 'Oziel',
        photo: 'ww.com',
        phone: '(85)98828-6381',
        welcomePage: true));
  });
  setUp(() {
    repository = WelcomeRepositoryImpl();
    usecase = UpdateUserCreate(repository!);
    updateUser = UpdateUserWelcome(
        contacts: ['(85)98845-1235'],
        email: 'oziel@hotmail.com',
        name: 'Oziel',
        photo: 'ww.com',
        phone: '(85)98828-6381',
        welcomePage: true);
  });

  test('Should return AuthResult if usecase returns success', () async {
    when(() => repository!.updateUserCreate(any()))
        .thenAnswer((_) async => right(null));

    final result = await usecase!(updateUser);

    expect(result, right(null));
    verify(() => repository!.updateUserCreate(updateUser!));
    verifyNoMoreInteractions(repository);
  });

  test('Should returns PhoneEmptyFailure if phone is empty', () async {
    when(() => repository!.updateUserCreate(any()))
        .thenAnswer((_) async => left(PhoneEmptyFailure()));

    final result = await usecase!(UpdateUserWelcome(
        contacts: ['(85)98845-1235'],
        email: 'oziel@hotmail.com',
        name: 'Oziel',
        photo: 'ww.com',
        phone: '',
        welcomePage: true));

    expect(result, left(PhoneEmptyFailure()));
  });

  test('Should returns PhoneInvalidFailure if phone is invalid', () async {
    when(() => repository!.updateUserCreate(any()))
        .thenAnswer((_) async => left(PhoneInvalidFailure()));

    final result = await usecase!(UpdateUserWelcome(
        contacts: ['(85)98845-1235'],
        email: 'oziel@hotmail.com',
        name: 'Oziel',
        photo: 'ww.com',
        phone: '(85)28828-6381',
        welcomePage: true));

    expect(result, left(PhoneInvalidFailure()));
  });
  test('Should returns ListContactsEmptyFailure if contacts is empty',
      () async {
    when(() => repository!.updateUserCreate(any()))
        .thenAnswer((_) async => left(ListContactsEmptyFailure()));

    final result = await usecase!(UpdateUserWelcome(
        contacts: [],
        email: 'oziel@hotmail.com',
        name: 'Oziel',
        photo: 'ww.com',
        phone: '(85)98828-6381',
        welcomePage: true));

    expect(result, left(ListContactsEmptyFailure()));
  });
}
