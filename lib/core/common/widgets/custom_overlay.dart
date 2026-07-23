import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Anchors [overlayBuilder]'s content to [builder]'s trigger widget, showing
/// it in an [Overlay] on tap and dismissing it on an outside tap.
///
/// [builder] renders the trigger (an icon, a button, a card — anything) and
/// receives a [toggle] callback to open/close the overlay from any gesture
/// it wants (`onTap`, `onPressed`, etc.). [overlayBuilder] renders whatever
/// content should appear in the popover, and receives a [close] callback so
/// the content itself can dismiss it (e.g. a "Close" button inside).
///
/// Use this instead of a dialog/tooltip whenever extra detail should stay
/// hidden until asked for, without a full-screen modal interrupting the
/// screen (e.g. tax breakdowns, field explanations, computed value sources).
class CustomOverlay extends StatefulWidget {
  const CustomOverlay({
    super.key,
    required this.builder,
    required this.overlayBuilder,
    this.targetAnchor = Alignment.bottomLeft,
    this.followerAnchor = Alignment.topLeft,
    this.offset = const Offset(0, 6),
    this.width,
    this.decorated = true,
  });

  /// Builds the trigger widget. Call [toggle] to open/close the overlay.
  final Widget Function(BuildContext context, VoidCallback toggle) builder;

  /// Builds the overlay content. Call [close] to dismiss it from within.
  final Widget Function(BuildContext context, VoidCallback close)
  overlayBuilder;

  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;

  /// Fixed width for the overlay content. Leave null to size to content.
  final double? width;

  /// When true (default), wraps [overlayBuilder]'s content in a rounded,
  /// elevated [Material] card. Set to false to render raw content and
  /// handle styling yourself.
  final bool decorated;

  @override
  State<CustomOverlay> createState() => CustomOverlayState();
}

class CustomOverlayState extends State<CustomOverlay> {
  final _link = LayerLink();
  OverlayEntry? _overlayEntry;

  bool get isOpen => _overlayEntry != null;

  void toggle() {
    if (isOpen) {
      close();
    } else {
      _open();
    }
  }

  void _open() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => _CustomOverlayFollower(
        link: _link,
        targetAnchor: widget.targetAnchor,
        followerAnchor: widget.followerAnchor,
        offset: widget.offset,
        width: widget.width,
        decorated: widget.decorated,
        onDismiss: close,
        contentBuilder: widget.overlayBuilder,
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void close() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CompositedTransformTarget(
    link: _link,
    child: widget.builder(context, toggle),
  );
}

class _CustomOverlayFollower extends StatelessWidget {
  const _CustomOverlayFollower({
    required this.link,
    required this.targetAnchor,
    required this.followerAnchor,
    required this.offset,
    required this.width,
    required this.decorated,
    required this.onDismiss,
    required this.contentBuilder,
  });

  final LayerLink link;
  final Alignment targetAnchor;
  final Alignment followerAnchor;
  final Offset offset;
  final double? width;
  final bool decorated;
  final VoidCallback onDismiss;
  final Widget Function(BuildContext context, VoidCallback close)
  contentBuilder;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      // Full-screen transparent barrier to dismiss on outside tap.
      Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onDismiss,
        ),
      ),
      CompositedTransformFollower(
        link: link,
        targetAnchor: targetAnchor,
        followerAnchor: followerAnchor,
        offset: offset,
        child: _buildContent(context),
      ),
    ],
  );

  Widget _buildContent(BuildContext context) {
    final content = contentBuilder(context, onDismiss);
    if (!decorated) return content;

    return Material(
      elevation: 6,
      borderRadius: 10.radiusBorder,
      color: AppColors.white,
      child: Container(width: width?.w, padding: 12.padding, child: content),
    );
  }
}
