import 'dart:developer';

import 'package:flutter/services.dart';

abstract class SmsService {
  Future<void> sendSms(List<String> contacts);
}

class SmsServiceImpl implements SmsService {
  @override
  Future<void> sendSms(List<String> contacts) async {
    final _methodChannel = MethodChannel("com.lum.volume");
    try {
      final result = await _methodChannel.invokeMethod("sendSms", {
        "contacts": contacts
            .map((e) =>
                e.replaceAll("-", "").replaceAll("(", "").replaceAll(")", ""))
            .toList()
      });
      log('Seu result $result');
    } catch (e) {
      log("e $e");
    }
  }
}
