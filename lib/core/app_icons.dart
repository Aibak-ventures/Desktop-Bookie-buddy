import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIcons {
  static const String searchSvg = 'assets/icons/search.svg';
  static const String infoDangerSvg = 'assets/icons/info_danger.svg';
  static const String homeSvg = 'assets/icons/home.svg';
  static const String filterSvg = 'assets/icons/filter.svg';
  static const String unknownProduct = 'assets/images/unknown_product.png';
  static const String upiIcon = 'assets/icons/upi-icon.webp';
  static const String cashIcon = 'assets/icons/cash-icon.png';
  static const String product3d = 'assets/images/product_3d.webp';
  static const String onboardingPersonImage =
      'assets/images/onboarding_person_image.png';
  static const String onboardingPersonSvg =
      'assets/images/onboarding_person_image.svg';

  static const String user = 'assets/icons/user.png';

  static final Image upi = Image.asset(
    upiIcon,
    height: 38.w,
    width: 38.w,
  );
  static final Image cash = Image.asset(
    cashIcon,
    width: 38.w,
    height: 38.w,
  );
}
