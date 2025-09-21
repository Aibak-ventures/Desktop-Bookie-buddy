import 'package:flutter/material.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: _buildWebResponsiveLayout(context),
    );
  }

  Widget _buildWebResponsiveLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive breakpoints
    final bool isLargeScreen = screenWidth > 1200;
    final bool isSmallScreen = screenWidth <= 768;
    
    if (isSmallScreen) {
      // Single column layout for small screens
      return _buildSingleColumnLayout(context);
    } else {
      // Two column layout for medium and large screens
      return _buildTwoColumnLayout(context, isLargeScreen);
    }
  }

  Widget _buildTwoColumnLayout(BuildContext context, bool isLargeScreen) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          // Left Panel - Branding/Image Section
          Expanded(
            flex: isLargeScreen ? 3 : 2,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF667eea),
                    Color(0xFF764ba2),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern with subtle design
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topRight,
                          radius: 2.0,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // App Logo/Branding
                          Container(
                            padding: EdgeInsets.all(isLargeScreen ? 24 : 20),
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
                              size: isLargeScreen ? 100 : 80,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: isLargeScreen ? 50 : 40),
                          Text(
                            'Bookie Buddy',
                            style: TextStyle(
                              fontSize: isLargeScreen ? 48 : 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: isLargeScreen ? 24 : 16),
                          Container(
                            constraints: BoxConstraints(maxWidth: isLargeScreen ? 500 : 400),
                            child: Text(
                              'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isLargeScreen ? 20 : 16,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.6,
                              ),
                            ),
                          ),
                          SizedBox(height: isLargeScreen ? 80 : 60),
                          // Feature highlights
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildFeatureItem(Icons.calendar_today, 'Bookings', isLargeScreen),
                              _buildFeatureItem(Icons.inventory_2, 'Inventory', isLargeScreen),
                              _buildFeatureItem(Icons.account_balance_wallet, 'Ledger', isLargeScreen),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Welcome Section
          Expanded(
            flex: isLargeScreen ? 2 : 3,
            child: Container(
              color: Colors.white,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isLargeScreen ? 80 : 60,
                    vertical: 40,
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: isLargeScreen ? 500 : 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 42 : 32,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1a1a1a),
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: isLargeScreen ? 16 : 12),
                        Text(
                          'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                          style: TextStyle(
                            fontSize: isLargeScreen ? 18 : 16,
                            color: const Color(0xFF6b7280),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: isLargeScreen ? 80 : 60),
                        // Illustration placeholder
                        Center(
                          child: Container(
                            constraints: BoxConstraints(maxHeight: isLargeScreen ? 350 : 280),
                            child: Icon(
                              Icons.business_center_outlined,
                              size: isLargeScreen ? 250 : 200,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        SizedBox(height: isLargeScreen ? 80 : 60),
                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: isLargeScreen ? 64 : 56,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF667eea),
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shadowColor: const Color(0xFF667eea).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                fontSize: isLargeScreen ? 18 : 16,
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

  Widget _buildSingleColumnLayout(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667eea),
            Color(0xFF764ba2),
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF667eea).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.business_center_outlined,
                          size: 80,
                          color: Color(0xFF667eea),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Bookie Buddy',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF667eea),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Hi there!\nWe\'re here to help you manage your bookings, ledger, and inventory — all in one smooth flow.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6b7280),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Feature highlights
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildFeatureItem(Icons.calendar_today, 'Bookings', false),
                          _buildFeatureItem(Icons.inventory_2, 'Inventory', false),
                          _buildFeatureItem(Icons.account_balance_wallet, 'Ledger', false),
                        ],
                      ),
                      const SizedBox(height: 40),
                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF667eea),
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shadowColor: const Color(0xFF667eea).withOpacity(0.3),
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
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String label, bool isLargeScreen) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(isLargeScreen ? 16 : 12),
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
            size: isLargeScreen ? 28 : 24,
          ),
        ),
        SizedBox(height: isLargeScreen ? 12 : 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: isLargeScreen ? 16 : 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
