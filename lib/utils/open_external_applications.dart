import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final class OpenExternalApplications {
  const OpenExternalApplications._();

  static const webOnlyWindowName = '_blank';

  static Future<void> launchEmail({
    required String mailTo,
    String? subject,
    String? body,
  }) async {
    final query =
        '${subject.isNotNullOrEmpty ? 'subject=$subject' : ''}&${body.isNotNullOrEmpty ? 'body=$body' : ''}';
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: mailTo,
      query: query.isNotNullOrEmpty ? query : null,
    );

    final canLaunch = await canLaunchUrl(emailUri);
    if (!canLaunch) {
      debugPrint('No direct email app found, trying anyway...');
    }
    try {
      await launchUrl(emailUri, webOnlyWindowName: webOnlyWindowName);
    } catch (e) {
      debugPrint('Error launching email app: $e ');
      rethrow;
    }
  }

  static Future<void> launchWhatsApp({
    required String phone,
    int countryCode = 91,
    String? message,
  }) async {
    assert(phone.trim().length == 10, 'Phone number need to me 10 digit');
    final text = message.isNotNullOrEmpty
        ? '?text=${Uri.encodeComponent(message!)}'
        : null;
    final fullNumber = '+$countryCode${phone.trim()}';

    final Uri whatsappUri = Uri.parse('https://wa.me/$fullNumber${text ?? ''}');

    if (await canLaunchUrl(whatsappUri)) {
      debugPrint('WhatsApp available');
      debugPrint('Launching WhatsApp...');
      await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: webOnlyWindowName,
      );
    } else {
      debugPrint('WhatsApp not available');
    }
  }

  static Future<void> makePhoneCall({
    required String phoneNumber,
    int countryCode = 91,
  }) async {
    final phone = '+${countryCode}$phoneNumber';
    try {
      final Uri launchUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(launchUri)) {
        debugPrint('Phone call is available and trying to make call');
        await launchUrl(launchUri, webOnlyWindowName: webOnlyWindowName);
      } else {
        throw 'Could not launch $launchUri';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }
}
