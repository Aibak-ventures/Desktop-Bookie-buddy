import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/enums/event_status.dart';
import '../../../../common/extensions/context_extensions.dart';
import '../../../../common/extensions/widget_extensions.dart';
import '../../../../common/theme/app_colors.dart';
import '../../../../common/widgets/custom_textfield.dart';
import '../../../../common/utils/app_input_validators.dart';
import '../state/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final rememberMeNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    rememberMeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Form(
        key: formKey,
        child: _buildWebResponsiveLayout(context),
      ),
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
          // Left Panel - Branding Section
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
                              'Your complete business management solution for bookings, inventory, and financial tracking',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isLargeScreen ? 20 : 16,
                                color: Colors.white.withOpacity(0.9),
                                height: 1.6,
                              ),
                            ),
                          ),
                          if (isLargeScreen) ...[
                            const SizedBox(height: 60),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildFeatureItem(Icons.calendar_today, 'Bookings'),
                                _buildFeatureItem(Icons.inventory_2, 'Inventory'),
                                _buildFeatureItem(Icons.account_balance_wallet, 'Ledger'),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Login Form Section
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
                    child: _buildLoginForm(context, isLargeScreen),
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
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF667eea).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.business_center_outlined,
                          size: 60,
                          color: Color(0xFF667eea),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Bookie Buddy',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF667eea),
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildLoginForm(context, false),
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

  Widget _buildLoginForm(BuildContext context, bool isLargeScreen) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: isLargeScreen ? 42 : 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1a1a1a),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: isLargeScreen ? 16 : 12),
        Text(
          'Ready to continue your journey?\nYour smart business path starts here',
          style: TextStyle(
            fontSize: isLargeScreen ? 18 : 16,
            color: const Color(0xFF6b7280),
            height: 1.5,
          ),
        ),
        SizedBox(height: isLargeScreen ? 50 : 40),
        
        // Phone Number Field
        SizedBox(
          height: 48,
          child: CustomTextField(
            hintText: 'Phone number',
            controller: phoneController,
            keyboardType: TextInputType.number,
            validator: kDebugMode
                ? AppInputValidators.numberOnly
                : AppInputValidators.phoneNumber,
          ),
        ),
        const SizedBox(height: 16),
        
        // Password Field
        SizedBox(
          height: 48,
          child: CustomTextField(
            hintText: 'Password',
            controller: passwordController,
            isPassword: true,
            validator: AppInputValidators.password,
          ),
        ),
        SizedBox(height: isLargeScreen ? 40 : 32),
        
        // Login Button
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.eventStatus == EventStatus.success && 
                state.status == AuthStatus.loggedIn) {
              Future.delayed(const Duration(seconds: 1), () {
                context.showSnackBar(
                  'Login successful!',
                  isTitleVisible: false,
                );
              });
              // TODO: Navigate to home screen
            } else if (state.eventStatus == EventStatus.error) {
              context.showSnackBar(
                state.message ?? 'Login failed!',
                isError: true,
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.status == AuthStatus.logging;
            return SizedBox(
              width: double.infinity,
              height: isLargeScreen ? 64 : 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : () {
                  print('🔥 LOGIN BUTTON PRESSED');
                  if (!formKey.currentState!.validate()) {
                    context.showSnackBar(
                      'Please enter username and password',
                      isError: true,
                    );
                    return;
                  }
                  final phone = phoneController.text.trim();
                  final password = passwordController.text.trim();
                  print('🔥 About to call AuthBloc with phone: $phone');
                  
                  context.read<AuthBloc>().add(
                        AuthEvent.login(phone, password),
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
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Please wait...',
                            style: TextStyle(
                              fontSize: isLargeScreen ? 18 : 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 18 : 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            );
          },
        ),
        SizedBox(height: isLargeScreen ? 40 : 30),
        
        // Contact Support
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contact us',
                style: TextStyle(
                  fontSize: isLargeScreen ? 16 : 14,
                  color: AppColors.blackShade,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.support_agent,
                color: Color.fromARGB(255, 33, 192, 92),
                size: 20,
              ),
              const SizedBox(width: 5),
              Text(
                'Support',
                style: TextStyle(
                  fontSize: isLargeScreen ? 16 : 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 33, 192, 92),
                ),
              ),
            ],
          ).onTap(() {
            // TODO: Implement contact support
          }),
        ),
      ],
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
        const SizedBox(height: 8),
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

}
