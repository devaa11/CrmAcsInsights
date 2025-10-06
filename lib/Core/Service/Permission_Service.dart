import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PermissionService {

static Future<bool> requestAllPermissions() async {
      bool gallery = await requestGalleryPermission();
      bool callLog = await requestCallLogPermission();
      return gallery && callLog;
    }

  static Future<bool> requestGalleryPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        // Android 13+ (TIRAMISU)
        return await _requestPermission(Permission.photos);
      } else {
        // Android 12 and below
        return await _requestPermission(Permission.storage);
      }
    } else if (Platform.isIOS) {
      return await _requestPermission(Permission.photos);
    } else {
      // Default allow for other platforms
      return true;
    }
  }

  static Future<bool> requestCallLogPermission() async {
      if (Platform.isAndroid) {
        return await _requestPermission(Permission.phone);
      } else {
        // Default allow for non-Android platforms
        return true;
      }
    }

  static Future<bool> _requestPermission(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) return true;

    final result = await permission.request();
    return result.isGranted;
  }
}
