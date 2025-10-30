import 'package:another_flushbar/flushbar.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

void CustomSnackBar({
  required String message,
  String? title,
  bool isError = true,
  bool isTitleVisible = true,
  Duration duration = const Duration(seconds: 4),
}) async {
  await Flushbar(
    title: !isTitleVisible ? null : title ?? (isError ? 'Error' : 'Success'),
    message: message,
    duration: duration,
    titleColor: Colors.white,
    messageColor: Colors.white,
    backgroundColor: isError ? Colors.red : Colors.green,
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    margin: 10.padding,
    maxWidth: kIsWeb ? 500 : null,
  ).show(navigatorKey.currentContext!);
}
