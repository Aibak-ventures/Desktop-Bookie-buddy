import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/auth/view_model/bloc_auth/auth_bloc.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:bookie_buddy_web/features/profile/view_model/contact_support_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

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

  // void _loadSavedCredentials() async {
  //   final saved = await SharedPreferenceHelper.getBool('remember_me') ?? false;

  //   if (saved) {
  //     final username = SharedPreferenceHelper.getString('username') ?? '';
  //     final password = SharedPreferenceHelper.getString('password') ?? '';

  //     setState(() {
  //       rememberMe = saved;
  //       _usernameController.text = username;
  //       _passwordController.text = password;
  //     });

  //     // Auto Navigate or Auto Fill
  //   }
  // }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    rememberMeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;
    
    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : AppColors.white,
      body: Form(
        key: formKey,
        child: isDesktop 
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        children: [
          // Left Panel - Branding Section
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
                  // Background pattern
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
                            'Your complete business management solution for bookings, inventory, and financial tracking',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Login Form Section
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
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1a1a1a),
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Ready to continue your journey?\nYour smart business path starts here',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color(0xFF6b7280),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 40),
                        // Phone Number Field
                        CustomTextField(
                          hintText: 'Phone number',
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          validator: kDebugMode
                              ? AppInputValidators.numberOnly
                              : AppInputValidators.phoneNumber,
                        ),
                        SizedBox(height: 20),
                        // Password Field
                        CustomTextField(
                          hintText: 'Password',
                          controller: passwordController,
                          validator: AppInputValidators.password,
                        ),
                        SizedBox(height: 40),
                        // Login Button
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              authenticated: () async {
                                Future.delayed(const Duration(seconds: 1), () {
                                  context.showSnackBar(
                                    'Login successful!',
                                    isTitleVisible: false,
                                  );
                                });
                                await SharedPreferenceHelper.setBool(
                                  'onboarding',
                                  true,
                                );
                                if (kDebugMode)
                                  log('set onboarding: ${SharedPreferenceHelper.getBool('onboarding')}');
                                context.read<UserCubit>().loadUserData();
                                context.read<DashboardBloc>().add(
                                      const DashboardEvent.loadDashboardData(),
                                    );
                                context.pushAndRemoveUntil(const BottomBarScreen());
                              },
                              error: (error) => context.showSnackBar(
                                error,
                                isError: true,
                              ),
                              orElse: () {},
                            );
                          },
                          builder: (context, state) {
                            final isLoading = state.maybeWhen(
                              loading: () => true,
                              orElse: () => false,
                            );
                            return SizedBox(
                              width: double.infinity,
                              height: 56,
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
                                        AuthEvent.loginRequested(
                                          phone: phone,
                                          password: password,
                                        ),
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
                                child: Text(
                                  isLoading ? 'Please wait...' : 'Log In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        // Contact Support
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Contact us',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.blackShade,
                                ),
                              ),
                              SizedBox(width: 10),
                              SvgPicture.asset(
                                'assets/icons/whatsapp.svg',
                                colorFilter: const ColorFilter.mode(
                                  Color.fromARGB(255, 33, 192, 92),
                                  BlendMode.srcIn,
                                ),
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Whatsapp',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 33, 192, 92),
                                ),
                              ),
                            ],
                          ).onTap(() async {
                            await const ContactSupportViewModel().launchWhatsApp();
                          }),
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

  Widget _buildMobileLayout(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/bg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: context.isMobile
              ? double.infinity
              : context.mediaQueryWidth(0.8),
          height: context.mediaQueryHeight(0.7),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: 60.radius,
              topRight: 60.radius,
            ),
          ),
          padding: 20.paddingHorizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              const SizedBox(height: 30),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                'Ready to continue your journey? \nYour smart business path starts here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF696969),
                ),
              ),
              15.height,
              Column(
                spacing: 20,
                children: [
                  CustomTextField(
                    hintText: 'Phone number',
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    validator: kDebugMode
                        ? AppInputValidators.numberOnly
                        : AppInputValidators.phoneNumber,
                  ),
                  CustomTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    validator: AppInputValidators.password,
                  ),
                ],
              ),
              15.height,
              // Login button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  state.maybeWhen(
                    authenticated: () async {
                      Future.delayed(const Duration(seconds: 1), () {
                        context.showSnackBar(
                          'Login successful!',
                          isTitleVisible: false,
                        );
                      });
                      await SharedPreferenceHelper.setBool(
                        'onboarding',
                        true,
                      );
                      if (kDebugMode)
                        log('set onboarding: ${SharedPreferenceHelper.getBool('onboarding')}');
                      context.read<UserCubit>().loadUserData();
                      context.read<DashboardBloc>().add(
                            const DashboardEvent.loadDashboardData(),
                          );
                      context.pushAndRemoveUntil(const BottomBarScreen());
                    },
                    error: (error) => context.showSnackBar(
                      error,
                      isError: true,
                    ),
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                  return _loginButton(
                    text: 'Login',
                    isLoading: isLoading,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        context.showSnackBar(
                          'Please enter username and password',
                          isError: true,
                        );
                        return;
                      }
                      final phone = phoneController.text.trim();
                      final password = passwordController.text.trim();

                      context.read<AuthBloc>().add(
                            AuthEvent.loginRequested(
                              phone: phone,
                              password: password,
                            ),
                          );
                    },
                  );
                },
              ),
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Contact us',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.blackShade,
                    ),
                  ),
                  10.width,
                  SvgPicture.asset(
                    'assets/icons/whatsapp.svg',
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(
                          255, 33, 192, 92), // WhatsApp green color
                      BlendMode.srcIn,
                    ),
                    semanticsLabel: 'WhatsApp Icon',
                    width: 20,
                    height: 20,
                  ),
                  2.5.width,
                  Text(
                    'Whatsapp',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 33, 192, 92),
                    ),
                  ),
                ],
              ).onTap(
                () async {
                  await const ContactSupportViewModel().launchWhatsApp();
                },
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  LinearGradient _gradient() => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xFF53A0FF).lighten(0.45),
          const Color(0xFF6132E4).lighten(.6),
        ],
      );

  Widget _loginButton({
    required String text,
    required Null Function() onPressed,
    required bool isLoading,
  }) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      height: 60,
      decoration: ShapeDecoration(
        gradient: _gradient(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: AppColors.grey400,
            blurRadius: 11,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          )
        ],
      ),
      child: Text(
        isLoading ? 'Please wait...' : 'Log In',
        style: TextStyle(
          fontSize: 18.sp,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).onTap(onPressed);
  }
}
