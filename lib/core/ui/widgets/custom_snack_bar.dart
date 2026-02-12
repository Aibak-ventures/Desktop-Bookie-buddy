import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:flutter/material.dart';

void CustomSnackBar({
  required String message,
  String? title,
  bool isError = true,
  bool isTitleVisible = true,
  Duration duration = const Duration(seconds: 4),
}) async {
  final context = navigatorKey.currentContext!;

  // Use custom overlay for all platforms
  _showWebSnackBar(
    context: context,
    message: message,
    title: title,
    isError: isError,
    isTitleVisible: isTitleVisible,
    duration: duration,
  );
}

void _showWebSnackBar({
  required BuildContext context,
  required String message,
  String? title,
  required bool isError,
  required bool isTitleVisible,
  required Duration duration,
}) {
  final overlay = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => _WebSnackBar(
      message: message,
      title: title,
      isError: isError,
      isTitleVisible: isTitleVisible,
      onDismiss: () => overlayEntry.remove(),
    ),
  );

  overlay.insert(overlayEntry);

  // Auto dismiss after duration
  Future.delayed(duration, () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
    }
  });
}

class _WebSnackBar extends StatefulWidget {
  final String message;
  final String? title;
  final bool isError;
  final bool isTitleVisible;
  final VoidCallback onDismiss;

  const _WebSnackBar({
    required this.message,
    this.title,
    required this.isError,
    required this.isTitleVisible,
    required this.onDismiss,
  });

  @override
  State<_WebSnackBar> createState() => _WebSnackBarState();
}

class _WebSnackBarState extends State<_WebSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // Slide in from right
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 320),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color:
                  widget.isError ? Colors.red.shade600 : Colors.green.shade600,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.isError
                      ? Icons.error_outline
                      : Icons.check_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isTitleVisible)
                        Text(
                          widget.title ??
                              (widget.isError ? 'Error' : 'Success'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (widget.isTitleVisible) const SizedBox(height: 2),
                      Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _dismiss,
                  child: const Icon(Icons.close, color: Colors.white, size: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
