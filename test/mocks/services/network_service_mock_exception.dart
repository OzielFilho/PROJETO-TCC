import 'package:app/app/core/services/network_service.dart';

class NetworkServiceMockException implements NetworkService {
  int callHasConnectionException = 0;
  @override
  Future<bool> get hasConnection async {
    callHasConnectionException += 1;
    throw Exception();
  }
}
