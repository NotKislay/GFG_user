import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class ApiLevel{
  static Future<int> get() async{
      /*const platform = MethodChannel('api_level');
      try {
        final int apiLevel = await platform.invokeMethod('getApiLevel');
        return apiLevel;
      } on PlatformException catch (e) {
        print("Failed to get API level: ${e.message}");
        return -1; // Default value on failure
      }*/
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.version.sdkInt;
  }
}