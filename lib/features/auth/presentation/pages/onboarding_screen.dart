import 'package:bookie_buddy_web/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/desktop_login_background.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),

                  Image.asset('assets/images/app_icon_dart.png', height: 82),

                  const Spacer(),

                  Center(
                    child: Row(
                      children: [
                        SizedBox(width: 101),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 57,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              "Manage bookings, ledger,\nand inventory — all in one smooth flow",
                              style: TextStyle(
                                fontSize: 26,
                                height: 1.4,
                                color: Color(0xFF555555),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: 164,
                              height: 67,
                              child: ElevatedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B6CFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Log in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 30),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.56,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/onboarding_dashboard.png',
                                fit: BoxFit.contain,
                              ),
                              const Positioned(
                                bottom: 44,
                                child: Text(
                                  "Trusted by 500+ businesses",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
