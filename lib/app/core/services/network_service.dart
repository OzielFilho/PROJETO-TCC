import 'dart:io';

abstract class NetworkService {
  Future<bool> get hasConnection;
}

class NetworkServiceImpl implements NetworkService {
  @override
  Future<bool> get hasConnection async {
    final result = await InternetAddress.lookup('www.google.com');
    return (result.isNotEmpty && result.first.rawAddress.isNotEmpty);
  }
}
