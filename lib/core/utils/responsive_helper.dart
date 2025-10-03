import 'package:flutter/material.dart';

class ResponsiveHelper {
  static const double _mobileMaxWidth = 600;
  static const double _tabletMaxWidth = 1024;
  static const double _desktopMaxWidth = 1440;

  /// Get screen breakpoint type
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < _mobileMaxWidth) {
      return ScreenType.mobile;
    } else if (width < _tabletMaxWidth) {
      return ScreenType.tablet;
    } else if (width < _desktopMaxWidth) {
      return ScreenType.desktop;
    } else {
      return ScreenType.largeDesktop;
    }
  }

  /// Check if screen is mobile size
  static bool isMobile(BuildContext context) {
    return getScreenType(context) == ScreenType.mobile;
  }

  /// Check if screen is tablet size
  static bool isTablet(BuildContext context) {
    return getScreenType(context) == ScreenType.tablet;
  }

  /// Check if screen is desktop size (includes large desktop)
  static bool isDesktop(BuildContext context) {
    final type = getScreenType(context);
    return type == ScreenType.desktop || type == ScreenType.largeDesktop;
  }

  /// Get responsive value based on screen size
  static T getValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
    }
  }

  /// Get responsive font size
  static double getFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return getValue<double>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Get responsive padding
  static EdgeInsets getPadding(
    BuildContext context, {
    required EdgeInsets mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
    EdgeInsets? largeDesktop,
  }) {
    return getValue<EdgeInsets>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Get responsive spacing
  static double getSpacing(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    return getValue<double>(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Get responsive grid columns count
  static int getGridColumns(
    BuildContext context, {
    int mobile = 1,
    int? tablet,
    int? desktop,
    int? largeDesktop,
  }) {
    return getValue<int>(
      context,
      mobile: mobile,
      tablet: tablet ?? 2,
      desktop: desktop ?? 3,
      largeDesktop: largeDesktop ?? 4,
    );
  }

  /// Get responsive container width (for centering content)
  static double getMaxContentWidth(BuildContext context) {
    return getValue<double>(
      context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1200,
      largeDesktop: 1400,
    );
  }

  /// Get responsive sidebar width
  static double getSidebarWidth(BuildContext context) {
    return getValue<double>(
      context,
      mobile: 0, // No sidebar on mobile
      tablet: 240,
      desktop: 280,
      largeDesktop: 320,
    );
  }
}

enum ScreenType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Widget that builds different layouts based on screen size
/// Responsive breakpoint widget for conditional rendering
class ResponsiveBreakpoints extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveBreakpoints({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = ResponsiveHelper.getScreenType(context);
    
    switch (screenType) {
      case ScreenType.mobile:
        return mobile ?? const SizedBox.shrink();
      case ScreenType.tablet:
        return tablet ?? mobile ?? const SizedBox.shrink();
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
      case ScreenType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile ?? const SizedBox.shrink();
    }
  }
}