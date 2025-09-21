import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;
    
    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : null,
      body: isDesktop 
          ? _buildDesktopAppLayout(context)
          : _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopAppLayout(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          // Left Panel - Branding/Image Section
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF667eea),
                    const Color(0xFF764ba2),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern or decoration
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg.png'),
                          fit: BoxFit.cover,
                          opacity: 0.1,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // App Logo/Branding
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.business_center_outlined,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Bookie Buddy',
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Text(
                            'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        // Feature highlights
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildFeatureItem(Icons.calendar_today, 'Bookings'),
                            _buildFeatureItem(Icons.inventory_2, 'Inventory'),
                            _buildFeatureItem(Icons.account_balance_wallet, 'Ledger'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Login Section
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1a1a1a),
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF6b7280),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 60),
                        // Illustration - using a placeholder since we don't have the SVG asset
                        Center(
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 280),
                            child: Icon(
                              Icons.business_center,
                              size: 120,
                              color: const Color(0xFF667eea),
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                        // Login Button - keeping original behavior
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667eea),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                        MediaQuery.of(context).padding.top - 
                        MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF696969),
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                // Placeholder for SVG illustration
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 200,
                  child: Icon(
                    Icons.business_center,
                    size: 100,
                    color: const Color(0xFF667eea),
                  ),
                ),
                SizedBox(height: 30),
                _LoginButton(
                  text: 'Log in',
                  isFilled: false,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.text,
    required this.onPressed,
    this.isFilled = true,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isFilled;
  
  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 0 : 30,
        vertical: 8,
      ),
      child: SizedBox(
        width: isDesktop ? null : double.infinity,
        height: isDesktop ? 50 : 60,
        child: ElevatedButton(
          onPressed: onPressed,
          style: isFilled ? _buttonFilledStyle() : _buttonOutlinedStyle(),
          child: Text(
            text,
            style: TextStyle(
              fontSize: isDesktop ? 16 : 18,
              color: isFilled ? Colors.black : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buttonFilledStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
    );
  }

  ButtonStyle _buttonOutlinedStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.white,
          width: 2,
        ),
      ),
      elevation: 0,
      shadowColor: Colors.white24,
    );
  }
}
