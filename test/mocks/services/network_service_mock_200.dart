import 'package:app/app/core/services/network_service.dart';

class NetworkServiceMock200 implements NetworkService {
  int callHasConnection = 0;
  @override
  Future<bool> get hasConnection async {
    callHasConnection += 1;
    return Future.value(true);
  }
}
