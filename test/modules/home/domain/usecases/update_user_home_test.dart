import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/entities/user_result_home.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/update_user_home.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HomeRepositoryImpl extends Mock implements HomeRepository {}

void main() {
  UpdateUserHome? usecase;
  HomeRepository? repository;
  UserResultHome? userResult;
  setUp(() {
    repository = HomeRepositoryImpl();
    usecase = UpdateUserHome(repository!);
    userResult = UserResultHome('osos@osso.com', '(85)98828-6381', 'ozzy',
        ['154545645'], 's151515', 'www.do');
  });

  test(
      'Should return an UserResultHome if usecase UpdateUserHome return success',
      () async {
    when(() => repository!.updateUser(userUpdate: userResult!))
        .thenAnswer((_) async => right(userResult!));

    final result = await usecase!(userResult);

    expect(result, right(userResult));
    verify(() => repository!.updateUser(userUpdate: userResult!));
    verifyNoMoreInteractions(repository);
  });

  test(
      'Should returns ParamsEmptyFailure if usecase UpdateUserHome return erro',
      () async {
    when(() => repository!
            .updateUser(userUpdate: UserResultHome("", "", "", [], "", "")))
        .thenAnswer((_) async => left(ParamsEmptyFailure()));

    final result = await usecase!(UserResultHome("", "", "", [], "", ""));

    expect(result, left(ParamsEmptyFailure()));
  });
}
