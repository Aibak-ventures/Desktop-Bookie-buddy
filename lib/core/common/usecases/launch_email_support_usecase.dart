import 'package:bookie_buddy_web/utils/open_external_applications.dart';

class LaunchEmailSupportUsecase {
  const LaunchEmailSupportUsecase();
  
  Future<void> call() async {
    await OpenExternalApplications.launchEmail(
      mailTo: 'bookiebuddyofficial@gmail.com',
      subject: 'Support Needed',
      body: 'Hi Team,',
    );
  }
}
