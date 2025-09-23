import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportViewModel {
  const ContactSupportViewModel();

  Future<void> launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'bookiebuddyofficial@gmail.com',
      query: 'subject=Support Needed&body=Hi Team,',
    );

    final canLaunch = await canLaunchUrl(emailUri);
    if (!canLaunch) {
      debugPrint('No direct email app found, trying anyway...');
    }
    try {
      await launchUrl(emailUri);
    } catch (e) {
      debugPrint(
        'Error launching email app: $e ',
      );
      rethrow;
    }
  }

  Future<void> launchWhatsApp() async {
    const phone = '+9197448 98185';
    const message = 'Hi Team, I need support';

    final Uri whatsappUri =
        Uri.parse('https://wa.me/$phone?text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUri)) {
      debugPrint('WhatsApp available');
      debugPrint('Launching WhatsApp...');
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('WhatsApp not available');
    }
  }
}
