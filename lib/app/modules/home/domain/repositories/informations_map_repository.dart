import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/entities/current_position.dart';
import 'package:dartz/dartz.dart';

abstract class InformationMapRepository {
  Future<Either<Failure, CurrentPosition>> getCurrentLocation();
}
