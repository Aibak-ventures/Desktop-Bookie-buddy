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
  static const String infoDangerSvg = '${_icons}info_danger.svg';
  static const String unknownProduct = '${_images}unknown_product.png';
  static const String reset = '${_images}reset.png';
  static const String upiIcon = '${_icons}upi-icon.webp';
  static const String cashIcon = '${_icons}cash-icon.png';
  static const String product3d = '${_images}product_3d.webp';
  static const String whatsAppSvg = '${_icons}whatsapp.svg';
  // widgets
  static final Image upi = Image.asset(upiIcon, height: 38.w, width: 38.w);
  static final Image cash = Image.asset(cashIcon, width: 38.w, height: 38.w);

  // images
  static const String appLogoLight = '${_images}logo_light.png';
  static const String companyBrandLight = '${_images}brand_light_img.png';

  // animations
  static const String noDataAnimation = '${_animations}nodata.json';
  static const String noProductAnimation =
      '${_animations}no_product_animation.json';

  // fonts
  static const String interRegularFont = '${_fonts}Inter_Regular.ttf';
  static const String interSemiBoldFont = '${_fonts}Inter_SemiBold.ttf';
  static const String interExtraBoldFont = '${_fonts}Inter_ExtraBold.ttf';
  static const String notoSansMalayalamFont = '${_fonts}NotoSansMalayalam.ttf';

  static const String crown = '${_icons}crown.png';
}
