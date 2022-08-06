import 'package:app/app/core/error/failure.dart';
import 'package:app/app/core/usecases/usecase.dart';
import 'package:app/app/modules/home/domain/entities/current_position.dart';
import 'package:dartz/dartz.dart';

import '../repositories/informations_map_repository.dart';

class GetCurrentPosition extends Usecase<CurrentPosition, NoParams> {
  final InformationMapRepository repository;

  GetCurrentPosition(this.repository);

  @override
  Future<Either<Failure, CurrentPosition>> call(NoParams? params) async {
    return await repository.getCurrentLocation();
  }
}
