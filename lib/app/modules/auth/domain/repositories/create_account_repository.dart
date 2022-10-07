import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../entities/user_create_account.dart';

abstract class CreateAccountRepository {
  Future<Either<Failure, String>> createWithEmailAndPassword(
      UserCreateAccount user, File? image);
}
