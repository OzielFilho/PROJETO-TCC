import 'package:flutter/services.dart';

class EventVolumeActions {
  static var methodChannel = MethodChannel("com.lum.volume");

  static Future<String> call({required dynamic arguments}) async {
    return await methodChannel.invokeMethod("startService", arguments);
  }
}
