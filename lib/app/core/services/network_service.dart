import 'dart:io';

abstract class NetworkService {
  Future<bool> get hasConnection;
}

class NetworkServiceImpl implements NetworkService {
  @override
  Future<bool> get hasConnection async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      return result.first.rawAddress.isNotEmpty;
    } on Exception catch (exception) {
      throw exception;
    } catch (e) {
      return false;
    }
  }
}
