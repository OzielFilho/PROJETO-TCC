import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HomeRepositoryImpl extends Mock implements HomeRepository {}

void main() {
  //GetUserHome? usecase;
  HomeRepository? repository;
  setUp(() {
    repository = HomeRepositoryImpl();
    // usecase = GetUserHome(repository!);
  });

  test('Should returns LogoutUserFailure if usecase LogoutUser return erro',
      () async {
    when(() => repository!.logoutUser())
        .thenAnswer((_) async => left(LogoutUserFailure()));
  });
}
