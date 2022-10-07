import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/current_position.dart';
import '../repositories/home_repository.dart';

class GetCurrentPosition extends Usecase<CurrentPosition, NoParams> {
  final HomeRepository repository;

  GetCurrentPosition(this.repository);

  @override
  Future<Either<Failure, CurrentPosition>> call(NoParams? params) async {
    return await repository.getCurrentLocation();
  }
}
