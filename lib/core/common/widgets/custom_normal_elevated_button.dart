import 'package:flutter/material.dart';

class CustomNormalElevatedButton extends StatelessWidget {
  const CustomNormalElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.child,
    this.color,
    this.isLoading = false,
    this.loadingWidget,
  });
  final VoidCallback? onPressed;
  final Widget? child;
  final String text;
  final Color? color;
  final bool isLoading;
  final Widget? loadingWidget;
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? loadingWidget ??
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                  strokeCap: StrokeCap.round,
                  strokeWidth: 3,
                  constraints: BoxConstraints(minHeight: 25, minWidth: 25),
                )
            : Text(text, style: const TextStyle(color: Colors.white)),
      );
}
