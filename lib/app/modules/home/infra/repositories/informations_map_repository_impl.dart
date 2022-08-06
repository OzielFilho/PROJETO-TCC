import 'package:app/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/informations_map_repository.dart';
import '../datasources/informations_map_datasource.dart';
import '../models/current_position_model.dart';

class InformationsMapRepositoryImpl implements InformationMapRepository {
  final InformationMapDatasource datasource;

  InformationsMapRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, CurrentPositionModel>> getCurrentLocation() async {
    try {
      final result = await datasource.getCurrentLocation();
      return right(result);
    } on InformationsMapException {
      return left(GetCurrentLocationFailure());
    } catch (e) {
      return left(GetCurrentLocationFailure());
    }
  }
}
