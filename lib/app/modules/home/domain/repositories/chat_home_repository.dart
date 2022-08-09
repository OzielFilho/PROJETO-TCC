import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/details_contact_chat.dart';

abstract class ChatHomeRepository {
  Future<Either<Failure, List<DetailsContactChat>>>
      getListDetailsContactFromPhoneChat({List<String> phones});
}
