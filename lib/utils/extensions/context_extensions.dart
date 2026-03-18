import 'package:bookie_buddy_web/core/common/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

/// Extensions on [BuildContext] that provide convenience methods for
/// getting [MediaQuery] information.
extension MediaQueryX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// This method is a convenience wrapper around [MediaQuery.of] to get the
  /// screen size.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Returns the screen current width
  double get screenWidth => MediaQuery.widthOf(this);

  /// Returns the screen current height
  double get screenHeight => MediaQuery.heightOf(this);

  /// Returns the screen current orientation
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Calculates a height based on a proportion of the screen height.
  ///
  /// [value] is the proportion of the screen height to return. For example,
  /// passing 0.5 will return half of the screen height.
  ///
  /// This method is a convenience wrapper around [MediaQuery.of] to get the
  /// screen height, and then multiply it by [value].
  double mediaQueryHeight(double value) => screenHeight * value;

  /// Calculates a width based on a proportion of the screen width.
  ///
  /// [value] is the proportion of the screen width to return. For example,
  /// passing 0.5 will return half of the screen width.
  ///
  /// This method is a convenience wrapper around [MediaQuery.of] to get the
  /// screen width, and then multiply it by [value].
  double mediaQueryWidth(double value) => screenWidth * value;

  /// Calculates a width based on a proportion of the screen width, given a
  /// design width of 375.
  ///
  /// [inputWidth] is the design width to return the proportionate width for.
  ///
  /// This method is useful for designing a responsive layout, where the
  /// width of a widget should be a proportion of the screen width.
  ///
  /// For example, if the design width is 375, and the screen width is 414,
  /// passing 200 as [inputWidth] will return 221.28 (200 / 375 * 414).
  double getProportionateScreenWidth(double inputWidth) =>
      (inputWidth / 375.0) * screenWidth;

  /// Calculates a height based on a proportion of the screen height, given a
  /// design height of 812.
  ///
  /// [inputHeight] is the design height to return the proportionate height for.
  ///
  /// This method is useful for designing a responsive layout, where the
  /// height of a widget should be a proportion of the screen height.
  ///
  /// For example, if the design height is 812, and the screen height is 896,
  /// passing 200 as [inputHeight] will return 221.28 (200 / 812 * 896).
  double getProportionateScreenHeight(double inputHeight) =>
      (inputHeight / 812.0) * screenHeight;

  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600;
  bool get isDesktop => screenWidth >= 900;
}

//--------------------------------------------------------------------------------------

/// Extensions on [BuildContext] that provide convenience methods for common
/// operations.
extension GlobalX on BuildContext {
  /// Hides the keyboard.
  void hideKeyboard() => FocusScope.of(this).unfocus();

  /// Returns true if the keyboard is currently visible, otherwise returns false.
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  ///
  ThemeData get theme => Theme.of(this);

  /// Shows a normal [SnackBar] with a message.
  ///
  /// If [isError] is true, the background color of the snackbar is red,
  /// otherwise it is green.
  void showSnackBar(
    String message, {
    bool isError = false,
    Color? color,
    bool positionTop = true,
    String? title,
    bool isTitleVisible = true,
    Duration duration = const Duration(seconds: 4),
  }) {
    // Always use CustomSnackBar for consistent positioning
    CustomSnackBar(
      message: message,
      isError: isError,
      title: title,
      isTitleVisible: isTitleVisible,
      duration: duration,
    );
  }

  void clearSnackBars() => ScaffoldMessenger.of(this).clearSnackBars();
}

//--------------------------------------------------------------------------------------

/// Extensions on [Navigator] that provide convenience methods for common
/// operations.
extension NavigatorX<T> on BuildContext {
  /// Pushes a new [screen] onto the navigator that most tightly encloses the
  /// given [BuildContext].
  ///
  /// The [screen] is the widget that is pushed onto the navigator.
  ///
  /// The [transitionType] is the style of the transition to use when pushing
  /// the screen. By default, the transition type is [TransitionType.normal].
  /// If [TransitionType.fade] is used, the screen will fade in when it is
  /// pushed, and it will fade out when it is popped.
  Future<T?> push<T>(Widget screen) async =>
      Navigator.of(this).push<T>(_createRoute<T>(screen));

  /// Pops the top-most route off the navigator that most tightly encloses the
  /// given [BuildContext].
  ///
  /// The given [result] is used to return data from the route that was popped.
  /// If [result] is null, the route's default value is used instead.
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// Replaces the current route of the navigator with the given [screen].
  ///
  /// The [screen] is the widget to display as the new route.
  ///
  /// The [transitionType] determines the animation used for the transition
  /// when replacing the route. Defaults to [TransitionType.normal].
  ///
  /// Returns a [Future] that completes to the [T] type once the push
  /// operation is complete.
  Future<T?> pushReplacement<T>(Widget screen) async =>
      Navigator.of(this).pushReplacement(_createRoute<T>(screen));

  /// Pushes the given [screen] onto the navigator that most tightly encloses the
  /// given [BuildContext] and removes all the previous routes until the
  /// predicate returns true.
  ///
  /// The [screen] is the widget that is pushed onto the navigator.
  ///
  /// The [transitionType] is the style of the transition to use when pushing
  /// the screen. By default, the transition type is [TransitionType.normal].
  /// If [TransitionType.fade] is used, the screen will fade in when it is
  /// pushed, and it will fade out when it is popped.
  ///
  /// The [predicate] is a function that takes a [Route] object as an argument
  /// and returns a boolean. While the predicate returns false, the navigator
  /// will keep pushing new routes until the predicate returns true.
  ///
  /// Returns a [Future] that completes to the [T] type once the push
  /// operation is complete.
  Future<T?> pushAndRemoveUntil<T>(Widget screen) async => Navigator.of(
        this,
      ).pushAndRemoveUntil<T>(_createRoute<T>(screen), (_) => false);

  /// Creates a route for navigation based on the specified [transitionType].
  ///
  /// [widget] is the target screen to navigate to.
  /// [transitionType] determines the type of transition animation. It supports
  /// two types: [TransitionType.fade] for a fade transition and [TransitionType.normal]
  /// for a standard material page route transition.
  ///
  /// Returns a [Route] object configured with the appropriate transition.
  Route<T> _createRoute<T>(Widget widget) =>
      MaterialPageRoute<T>(builder: (context) => widget);
}
