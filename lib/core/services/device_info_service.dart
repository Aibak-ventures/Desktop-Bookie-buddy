import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> getDeviceInfo() async {
    Map<String, dynamic> deviceData = {};

    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        deviceData = {
          'platform': 'web',
          'userAgent': webInfo.userAgent ?? 'Unknown',
          'browserName': webInfo.browserName.name,
          'timezone': DateTime.now().timeZoneName,
        };
      } else if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceData = {
          'platform': 'android',
          'model': androidInfo.model,
          'brand': androidInfo.brand,
          'version': androidInfo.version.release,
          'sdk': androidInfo.version.sdkInt.toString(),
          'timezone': DateTime.now().timeZoneName,
        };
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceData = {
          'platform': 'ios',
          'model': iosInfo.model,
          'name': iosInfo.name,
          'version': iosInfo.systemVersion,
          'timezone': DateTime.now().timeZoneName,
        };
      } else if (Platform.isWindows) {
        final windowsInfo = await _deviceInfo.windowsInfo;
        deviceData = {
          'platform': 'windows',
          'computerName': windowsInfo.computerName,
          'userName': windowsInfo.userName,
          'majorVersion': windowsInfo.majorVersion.toString(),
          'timezone': DateTime.now().timeZoneName,
        };
      } else if (Platform.isMacOS) {
        final macInfo = await _deviceInfo.macOsInfo;
        deviceData = {
          'platform': 'macos',
          'model': macInfo.model,
          'hostName': macInfo.hostName,
          'osRelease': macInfo.osRelease,
          'timezone': DateTime.now().timeZoneName,
        };
      }
    } catch (e) {
      deviceData = {
        'platform': 'unknown',
        'error': e.toString(),
        'timezone': DateTime.now().timeZoneName,
      };
    }

    return deviceData;
  }

  Future<Map<String, dynamic>> getClientInfo() async {
    return {
      'appVersion': '1.0.0',
      'platform': kIsWeb ? 'web' : Platform.operatingSystem,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
}
