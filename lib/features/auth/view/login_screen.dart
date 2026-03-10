import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/auth/view_model/bloc_auth/auth_bloc.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:bookie_buddy_web/features/profile/view_model/contact_support_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/desktop_login_backgrond.png',
              fit: BoxFit.cover,
            ),
          ),

          // TOP LEFT APP LOGO
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'assets/images/app_icon_dart.png',
              height: 110,
            ),
          ),

          Center(
            child: Form(
              key: formKey,
              child: _loginCard(),
            ),
          ),

          Positioned(bottom: 24, left: 0, right: 0, child: _contactSupport()),
        ],
      ),
    );
  }

  Widget _loginCard() {
    return Container(
      width: 420,
      // height: 515,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 30)],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 50),
        const Text("Welcome Back",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 13),
        const Text(
          "Ready to continue your journey?\nYour smart business path starts here",
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF7A7A7A)),
        ),
        const SizedBox(height: 28),
        _input('Phone number', phoneController, TextInputType.number,
            validator: AppInputValidators.phoneNumber,
            textInputAction: TextInputAction.next),
        const SizedBox(height: 22),
        _input('Password', passwordController, TextInputType.text,
            obscure: !_isPasswordVisible,
            validator: AppInputValidators.password,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _login(),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )),
        const SizedBox(height: 45),
        BlocConsumer<AuthBloc, AuthState>(
          listener: _authListener,
          builder: (context, state) {
            final loading =
                state.maybeWhen(loading: () => true, orElse: () => false);
            return SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: loading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B6CFF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  loading ? 'Please wait...' : 'Log In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 36),
      ]),
    );
  }

  Widget _input(
      String hint, TextEditingController controller, TextInputType type,
      {bool obscure = false,
      String? Function(String?)? validator,
      TextInputAction? textInputAction,
      void Function(String)? onFieldSubmitted,
      Widget? suffixIcon}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF8B6CFF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }

  void _login() {
    if (!formKey.currentState!.validate()) {
      context.showSnackBar('Please enter phone and password', isError: true);
      return;
    }

    context.read<AuthBloc>().add(AuthEvent.loginRequested(
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        ));
  }

  void _authListener(BuildContext context, AuthState state) {
    state.maybeWhen(
      authenticated: () async {
        await SharedPreferenceHelper.setBool('onboarding', true);
        context.read<UserCubit>().loadUserData();
        context
            .read<DashboardBloc>()
            .add(const DashboardEvent.loadDashboardData());
        context.pushAndRemoveUntil(const BottomBarScreen());
      },
      error: (e) => context.showSnackBar(e, isError: true),
      orElse: () {},
    );
  }

  Widget _contactSupport() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Contact us "),
      SvgPicture.asset('assets/icons/whatsapp.svg', width: 18, height: 18),
      const SizedBox(width: 6),
      const Text("Whatsapp", style: TextStyle(color: Colors.green)),
    ]).onTap(() => const ContactSupportViewModel().launchWhatsApp());
  }
}
