import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/splash/domain/usecases/splash_initialization_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _brandImagePath = 'assets/images/brand_light_img.png';
  static const _logoImagePath = 'assets/images/new_splash_color_img.svg';
  static const _logoAnimationPath = 'assets/animations/splash_animation.json';

  @override
  void initState() {
    super.initState();
    getIt<SplashInitializationUseCase>().call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    final animationWidth = context.screenWidthClamped(
      maxWidth: 550,
      minWidth: 200,
      maxWidthInPercent: 0.45,
    );
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo
          Flexible(
            flex: 2,
            child: SizedBox(
              width: animationWidth,
              child: ClipRect(
                child: LottieBuilder.asset(
                  _logoAnimationPath,
                  fit: BoxFit.contain,
                  addRepaintBoundary: true,
                  repeat: false,
                  errorBuilder: (context, error, stackTrace) {
                    return Transform.scale(
                      scale: 0.5,
                      child: SvgPicture.asset(
                        _logoImagePath,
                        fit: BoxFit.contain,
                        width: animationWidth,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          // Brand info
          Flexible(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Developed by',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Image.asset(_brandImagePath, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
