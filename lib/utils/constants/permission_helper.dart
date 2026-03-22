import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermission(
      {required Permission permission}) async {
    final status = await permission.request();


    log("PERMISSION REQUEST FOR $permission ;result is: ${status.isGranted}");
    if (status.isPermanentlyDenied) {
      log("Camera permission permanently denied. Open settings.");
      await launchAppSettings(); // Open settings if permanently denied
    }
    return status.isGranted;
  }

  static Future<bool> checkPermission({required Permission permission}) async {
    final permissionStatus = await permission.status;
    log("perm ststa: ${permissionStatus.isGranted}");
    return permissionStatus.isGranted;
  }

  static Future<void> launchAppSettings() async {
    final result = await openAppSettings();
    log("OPEN SETTINGS: ");
  }
}
