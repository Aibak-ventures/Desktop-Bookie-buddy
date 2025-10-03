import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  final String message;
  final Widget? icon;
  final bool isScrollable;
  final double? height;
  final bool isShowIcon;

  const EmptyDataWidget({
    super.key,
    required this.message,
    this.icon,
    this.isScrollable = false,
    this.height,
    this.isShowIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isShowIcon)
            icon ??
                const Icon(
                  Icons.inbox,
                  size: 80,
                  color: Colors.grey,
                ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    // Make it scrollable if needed
    return isScrollable
        ? ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: context.screenHeight * (height ?? 0.6), // Centering
                child: content,
              ),
            ],
          )
        : content;
  }
}
