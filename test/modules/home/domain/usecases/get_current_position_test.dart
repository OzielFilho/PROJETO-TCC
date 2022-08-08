import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/entities/current_position.dart';
import 'package:app/app/modules/home/domain/repositories/home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/get_current_position.dart';
import 'package:app/app/modules/splash/domain/entities/user_logged_info.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HomeRepositoryImpl extends Mock implements HomeRepository {}

void main() {
  GetCurrentPosition? usecase;
  HomeRepository? repository;
  CurrentPosition? currentPosition;
  setUp(() {
    repository = HomeRepositoryImpl();
    usecase = GetCurrentPosition(repository!);
    currentPosition = CurrentPosition(0, 0);
  });

  test('Should return an CurrentPosition if usecase return success', () async {
    when(() => repository!.getCurrentLocation())
        .thenAnswer((_) async => right(currentPosition!));

    final result = await usecase!(NoParams());

    expect(result, right(currentPosition));
    verify(() => repository!.getCurrentLocation());
    verifyNoMoreInteractions(repository);
  });

  test('Should returns GetCurrentLocationFailure if usecase return erro',
      () async {
    when(() => repository!.getCurrentLocation())
        .thenAnswer((_) async => left(GetCurrentLocationFailure()));

    final result = await usecase!(NoParams());

    expect(result, left(GetCurrentLocationFailure()));
  });
}
