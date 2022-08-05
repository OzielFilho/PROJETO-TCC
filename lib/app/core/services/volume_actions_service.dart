import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class VolumeActionsService {
  Future<bool> initialization(List<String> contacts);
}

class VolumeActionsServiceImpl implements VolumeActionsService {
  final _methodChannel = MethodChannel("com.lum.volume");

  @override
  Future<bool> initialization(List<String> contacts) async {
    try {
      final bool result = await _methodChannel
          .invokeMethod("startService", {'phones': contacts});
      print('SEU RESULT $result');
      return result;
    } catch (e) {
      debugPrint('Error $e');
      return false;
    }
  }
}
