import '../../../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class RefreshAccountRepository {
  Future<Either<Failure, bool>> loggedUser();
}
