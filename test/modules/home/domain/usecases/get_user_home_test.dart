import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/entities/user_result_home.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/get_user_home.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HomeRepositoryImpl extends Mock implements HomeRepository {}

void main() {
  GetUserHome? usecase;
  HomeRepository? repository;
  UserResultHome? userResult;
  setUp(() {
    repository = HomeRepositoryImpl();
    usecase = GetUserHome(repository!);
    userResult = UserResultHome(
        'osos@osso.com', '(85)98828-6381', 'ozzy', ['154545645'], 's151515');
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
