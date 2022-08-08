import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/auth/domain/entities/auth_result.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/get_user_home.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HomeRepositoryImpl extends Mock implements HomeRepository {}

void main() {
  GetUserHome? usecase;
  HomeRepository? repository;
  AuthResult? userResult;
  setUp(() {
    repository = HomeRepositoryImpl();
    usecase = GetUserHome(repository!);
    userResult =
        AuthResult('osos@osso.com', '1212151', true, '(85)98828-6381', 'ozzy');
  });

  test('Should return an AuthResult if usecase GetUserHome return success',
      () async {
    when(() => repository!.getUserHome())
        .thenAnswer((_) async => right(userResult!));

    final result = await usecase!(NoParams());

    expect(result, right(userResult));
    verify(() => repository!.getUserHome());
    verifyNoMoreInteractions(repository);
  });

  test('Should returns GetUserFailure if usecase GetUserHome return erro',
      () async {
    when(() => repository!.getUserHome())
        .thenAnswer((_) async => left(GetUserFailure()));

    final result = await usecase!(NoParams());

    expect(result, left(GetUserFailure()));
  });
}
