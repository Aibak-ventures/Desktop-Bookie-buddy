import 'dart:async';

import 'package:flutter/material.dart';

/// A class that helps with debouncing.
///
/// Debouncing is a process which ensures that a function is only run after a
/// certain amount of time has passed since the last time the function was
/// called. This is useful in scenarios where you want to limit the amount of
/// times a function is called, like on a text field's onChanged callback.
///
/// Example:
///
/// final debouncer = Debouncer();
///
/// onChanged: (value) {
///   debouncer.run(() {
///     // code here will only run after 500ms has passed since the last time onChanged was called
///   });
/// }
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void run(VoidCallback action) {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

  bool get isActive => _timer?.isActive ?? false;
}
