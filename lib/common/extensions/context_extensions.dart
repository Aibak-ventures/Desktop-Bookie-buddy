import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  // MediaQuery shortcuts
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  Size get screenSize => MediaQuery.of(this).size;
  
  EdgeInsets get padding => MediaQuery.of(this).padding;
  EdgeInsets get viewPadding => MediaQuery.of(this).viewPadding;
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;
  
  // Device type helpers
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1024;
  bool get isDesktop => screenWidth >= 1024;
  
  // Navigation helpers
  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  
  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }
  
  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
  
  void pop([dynamic result]) {
    Navigator.of(this).pop(result);
  }
  
  bool canPop() {
    return Navigator.of(this).canPop();
  }
  
  // Theme helpers
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  
  // SnackBar helper
  void showSnackBar(
    String message, {
    bool isError = false,
    bool isTitleVisible = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  // Media query percentage helpers
  double mediaQueryWidth(double percentage) {
    return screenWidth * percentage;
  }
  
  double mediaQueryHeight(double percentage) {
    return screenHeight * percentage;
  }
}
