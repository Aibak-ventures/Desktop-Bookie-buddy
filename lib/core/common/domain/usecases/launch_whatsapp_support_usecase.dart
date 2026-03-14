import 'package:bookie_buddy_web/utils/open_external_applications.dart';

class LaunchWhatsappSupportUsecase {
  const LaunchWhatsappSupportUsecase();

  Future<void> call() async {
    await OpenExternalApplications.launchWhatsApp(
      phone: '9744898185', // Removed +91 as utility adds it
      countryCode: 91,
      message: 'Hi Team, I need support',
    );
  }
}
