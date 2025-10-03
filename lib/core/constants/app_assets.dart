import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAssets {
  const AppAssets._();

  // base paths
  static const String _asset = 'assets/';
  static const String _icons = '${_asset}icons/';
  static const String _images = '${_asset}images/';
  static const String _animations = '${_asset}animations/';
  static const String _fonts = '${_asset}fonts/';

  // icons
  static const String searchSvg = '${_icons}search.svg';
  static const String infoDangerSvg = '${_icons}info_danger.svg';
  static const String homeSvg = '${_icons}home.svg';
  static const String filterSvg = '${_icons}filter.svg';
  static const String unknownProduct = '${_images}unknown_product.png';
  static const String reset = '${_images}reset.png';
  static const String upiIcon = '${_icons}upi-icon.webp';
  static const String cashIcon = '${_icons}cash-icon.png';
  static const String product3d = '${_images}product_3d.webp';
  static const String onboardingPersonImage =
      '${_images}onboarding_person_image.png';
  static const String onboardingPersonSvg =
      '${_images}onboarding_person_image.svg';
  static const String user = '${_icons}user.png';
  static const String whatsAppSvg = '${_icons}whatsapp.svg';
  static const String calendarPlus = '${_icons}calendar_plus.png';
  static const String cartPlus = '${_icons}cart_plus.png';

  // widgets
  static final Image upi = Image.asset(upiIcon, height: 38.w, width: 38.w);
  static final Image cash = Image.asset(cashIcon, width: 38.w, height: 38.w);

  // images
  static const String appLogoLight = '${_images}logo_light.png';
  static const String companyBrandLight = '${_images}brand_light_img.png';
  static const String onboardingBg = '${_images}bg.png';

  // animations
  static const String aniAnimation = '${_animations}ani.json';
  static const String transferProductAnimation =
      '${_animations}transfer_product.json';
  static const String noDataAnimation = '${_animations}nodata.json';
  static const String noProductAnimation =
      '${_animations}no_product_animation.json';
  static const String searchAnimation = '${_animations}search.json';

  // fonts
  static const String interFont = '${_fonts}Inter.ttf';
  static const String interRegularFont = '${_fonts}Inter_Regular.ttf';
  static const String interSemiBoldFont = '${_fonts}Inter_SemiBold.ttf';
  static const String interExtraBoldFont = '${_fonts}Inter_ExtraBold.ttf';
  static const String notoSansMalayalamFont = '${_fonts}NotoSansMalayalam.ttf';
  static const String materialIconFont = '${_fonts}MaterialIcons-Regular.ttf';

  // pdf layout svg
  static const String bookingPdfLayoutHeaderSvg =
      '${_images}booking_pdf_layout_header.svg';
  static const String bookingPdfLayoutFooterSvg =
      '${_images}booking_pdf_layout_footer.svg';
}
