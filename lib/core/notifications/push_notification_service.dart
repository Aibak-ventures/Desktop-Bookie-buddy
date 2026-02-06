import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_booking_screen.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking_past/all_booking_past_bloc.dart';
import 'package:bookie_buddy_web/features/auth/view/login_screen.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../features/booking_details/view/booking_details_screen.dart';
import '../navigation/navigations.dart';
import 'firebase_notification_manager.dart';

/// Handles push + local notification setup & routing.
class PushNotificationService {
  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for important notifications.',
    importance: Importance.max,
  );

  static bool _initialized = false;

  static Future<void> init() async {
    if (_initialized) return;
    // Skip full push + local notification setup on web (current implementation is mobile/desktop specific).
    if (kIsWeb) {
      _initialized = true;
      return;
    }
    await _requestPermission();
    await _initLocal();
    await FirebaseNotificationManager.initTokenHandling();
    await _wireCallbacks();
    _initialized = true;
  }

  static Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.notification.request();
    }
  }

  static Future<void> _initLocal() async {
    const androidInit = AndroidInitializationSettings(
      '@drawable/ic_stat_ic_notification',
    );
    const iosInit = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload != null) {
          final data = jsonDecode(resp.payload!);
          _navigateFromData(data);
        }
      },
    );

    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> _wireCallbacks() async {
    // iOS foreground presentation
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      final data = message.data;
      final imageUrl =
          // "https://wpengine.com/wp-content/uploads/2021/05/optimize-images-1024x681.jpg";
          notification?.android?.imageUrl ??
              notification?.apple?.imageUrl ??
              notification?.web?.image ??
              data['image'] ??
              data['image_url'];

      String? bigPicturePath;
      if (imageUrl != null) {
        bigPicturePath = await cacheImage(
          imageUrl,
          fileName: 'booking${message.messageId}',
        );
      }

      final details = _notificationDetailsWithStyle(bigPicturePath);
      final title = notification?.title ?? data['title'] ?? 'Notification';
      final body =
          notification?.body ?? data['body'] ?? 'You have a new update';
      log(
        'New push notification message: id=${message.messageId} title=$title body=$body',
      );
      if (notification != null) {
        await _local.show(
          notification.hashCode,
          title,
          body,
          details,
          payload: jsonEncode(message.data),
        );
      } else if (message.data.isNotEmpty) {
        await _local.show(
          message.hashCode,
          title,
          body,
          details,
          payload: jsonEncode(message.data),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) _navigateFromData(message.data);
    });

    // ignore: unawaited_futures
    FirebaseMessaging.instance.getInitialMessage().then((initial) {
      if (initial != null && initial.data.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _navigateFromData(initial.data);
        });
      }
    });
  }

  static NotificationDetails _notificationDetailsWithStyle(
    String? bigPicturePath,
  ) {
    // final icon = '@drawable/ic_stat_ic_notification';
    AndroidNotificationDetails androidDetails;
    if (bigPicturePath != null) {
      final bigStyle = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
      );
      androidDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        styleInformation: bigStyle,
        visibility: NotificationVisibility.public,
      );
    } else {
      androidDetails = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        visibility: NotificationVisibility.public,
      );
    }
    return NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  static void _navigateFromData(Map<String, dynamic> data) {
    try {
      final nav = navigatorKey.currentState;
      if (nav == null) return;
      if (!TokenManager.isTokenValid) {
        nav.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
        return;
      }
      final redirectTo = data['redirect_to'] ?? data['type'];

      // Ensure a base/root screen exists if this is a cold start (no pop stack).
      if (!nav.canPop()) {
        // Replace whatever single initial route exists with BottomBarScreen so back works.
        nav.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const BottomBarScreen()),
          (r) => false,
        );
      }

      if (redirectTo == 'UPCOMING') {
        if (_NavigationGuard.shouldNavigate('upcoming:list')) {
          nav.push(
            MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        AllBookingBloc(repository: getIt.get()),
                  ),
                  BlocProvider(
                    create: (context) =>
                        AllBookingPastBloc(repository: getIt.get()),
                  ),
                ],
                child: AllBookingScreen(),
              ),
            ),
          );
        }
        return;
      }

      final bookingIdString = data['booking_id'] ?? data['bookingId'];
      if (bookingIdString != null) {
        final id = int.tryParse('$bookingIdString');
        if (id != null) {
          // Debounce duplicate navigations (e.g., initial + onMessageOpenedApp)
          if (_NavigationGuard.shouldNavigate('booking:$id')) {
            nav.push(
              MaterialPageRoute(
                builder: (_) => BookingDetailsScreen(bookingId: id),
              ),
            );
          }
          return;
        }
      }

      log('No matching navigation for notification data (ignored): $data');
    } catch (e, stack) {
      log('Navigation error (notification): $e', stackTrace: stack);
    }
  }

  static Future<String?> cacheImage(
    String url, {
    String fileName = 'notification_image',
  }) async {
    // Disabled to support Web (no dart:io).
    // If mobile specific caching is needed, use a separate file with conditional imports.
    return null;
    /*
    try {
      final response = await Dio().get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode != 200) return null;
      final imageBytes = Uint8List.fromList(response.data!);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      await file.writeAsBytes(imageBytes);
      return file.path;
    } catch (e, stack) {
      log('Error caching image: $e', stackTrace: stack);
      return null;
    }
    */
  }

  static void showLocalNotification({
    required String title,
    required String body,
    String? imageUrl,
    Map<String, dynamic>? data,
  }) async {
    String? bigPicturePath;
    if (imageUrl != null) {
      bigPicturePath = await cacheImage(
        imageUrl,
        fileName: 'local_${DateTime.now().millisecondsSinceEpoch}',
      );
    }
    final details = _notificationDetailsWithStyle(bigPicturePath);
    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: data != null ? jsonEncode(data) : null,
    );
  }
}

// Simple debounce / duplicate guard to avoid double navigation on cold start
// (getInitialMessage + onMessageOpenedApp) or rapid taps.
class _NavigationGuard {
  static String? _lastSig;
  static DateTime? _lastTime;
  static bool shouldNavigate(String signature) {
    final now = DateTime.now();
    if (_lastSig == signature &&
        _lastTime != null &&
        now.difference(_lastTime!) < const Duration(seconds: 2)) {
      return false;
    }
    _lastSig = signature;
    _lastTime = now;
    return true;
  }
}
