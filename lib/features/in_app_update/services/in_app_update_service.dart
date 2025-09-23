import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppUpdateService {
  static const String _updateRequiredKey = "updateRequired";
  static const String _appStoreId = "6740146706";
  static const String bundleId = "com.bookingbuddy.bookingapp";

  String? appStoreVersion;

  Future<bool> checkForUpdate() async {
    bool needsUpdate = false;
    debugPrint("🔍 Checking for update...");
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      if (defaultTargetPlatform == TargetPlatform.android) {
        final updateInfo = await InAppUpdate.checkForUpdate();
        needsUpdate =
            updateInfo.updateAvailability == UpdateAvailability.updateAvailable;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        needsUpdate = await isIosUpdateAvailable(currentVersion);
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_updateRequiredKey, needsUpdate);
    } catch (e) {
      debugPrint("❌ Error checking update: $e");
    }
    return needsUpdate;
  }

  /// *Force users to update before continuing (Android Only)*
  Future<void> forceUpdate(BuildContext context) async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e) {
      debugPrint("❌ Error performing update: $e");
    }
  }

  /// *Check if an iOS update is available using Apple's iTunes Lookup API*
  Future<bool> isIosUpdateAvailable(String currentVersion) async {
    // final url = "https://itunes.apple.com/lookup?bundleId=$bundleId";
    final url = "https://itunes.apple.com/lookup?id=$_appStoreId&country=IN";

    try {
      debugPrint("🚀 Initiating iOS update check...");

      final response = await Dio().get(url);

      debugPrint("🔍 iOS Update Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data is String
            ? json.decode(response.data)
            : response.data;

        debugPrint("✅ Decoded API Response: $jsonData");

        if (jsonData['resultCount'] > 0) {
          final latestVersion = jsonData['results'][0]['version'];
          appStoreVersion = latestVersion;
          debugPrint(
              "✅ Latest Version: $latestVersion, Installed: $currentVersion");
          return _isVersionNewer(latestVersion, currentVersion);
        }
      } else {
        debugPrint("❌ Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❌ Exception while checking iOS update: $e");
    }
    return false;
  }

  /// *Redirect user to the App Store*
  Future<void> redirectToAppStore() async {
    final Uri url = Uri.parse("https://apps.apple.com/app/id$_appStoreId");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("❌ Could not launch App Store URL");
    }
  }

  bool _isVersionNewer(String latestVersion, String installedVersion) {
    final latest =
        latestVersion.split('.').map(int.tryParse).whereType<int>().toList();
    final installed =
        installedVersion.split('.').map(int.tryParse).whereType<int>().toList();

    final length =
        latest.length > installed.length ? latest.length : installed.length;
    for (int i = 0; i < length; i++) {
      final latestNum = i < latest.length ? latest[i] : 0;
      final installedNum = i < installed.length ? installed[i] : 0;
      if (latestNum > installedNum) return true;
      if (latestNum < installedNum) return false;
    }
    return false;
  }
}
