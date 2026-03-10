import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

enum DeviceScreenType {
  mobile,
  tablet,
  desktop;

  bool get isMobile => this == DeviceScreenType.mobile;
  bool get isTablet => this == DeviceScreenType.tablet;
  bool get isDesktop => this == DeviceScreenType.desktop;
}

class CustomResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceScreenType deviceType)
      builder;

  const CustomResponsiveBuilder({super.key, required this.builder});

  DeviceScreenType _getDeviceType(BuildContext context) {
    if (context.isDesktop) return DeviceScreenType.desktop;
    if (context.isTablet) return DeviceScreenType.tablet;
    return DeviceScreenType.mobile;
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = _getDeviceType(context);

    return builder(context, deviceType);
  }
}
