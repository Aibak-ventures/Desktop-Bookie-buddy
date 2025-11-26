import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SwipeStatus { initial, swiping, loading, success, failure }

/// Controller to programmatically change the state of a [CustomSwipeButton].
class CustomSwipeButtonController extends ChangeNotifier {
  SwipeStatus _status = SwipeStatus.initial;

  SwipeStatus get status => _status;

  bool get isLoading => _status == SwipeStatus.loading;
  bool get isSuccess => _status == SwipeStatus.success;
  bool get isFailure => _status == SwipeStatus.failure;

  void _set(SwipeStatus newStatus) {
    if (_status == newStatus) return;
    _status = newStatus;
    notifyListeners();
  }

  void reset() => _set(SwipeStatus.initial);
  void setLoading() => _set(SwipeStatus.loading);
  void setSuccess() => _set(SwipeStatus.success);
  void setFailure() => _set(SwipeStatus.failure);
}

class CustomSwipeButton extends StatefulWidget {
  final String text;
  final VoidCallback onSwipe; // Triggered when fully swiped
  final bool isLoading; // legacy manual control
  final bool isSuccess; // legacy manual control
  final bool isFailure; // legacy manual control
  final CustomSwipeButtonController? controller; // programmatic control

  final double height;
  final double? width; // allow parent to specify explicit width
  final double completionThreshold; // % of track to count as success (0-1)

  // Colors & styling
  final Color? backgroundColor;
  final Color? successColor;
  final Color? failureColor;
  final Color? thumbColor;
  final Color? textColor;
  final BorderRadius? borderRadius;

  const CustomSwipeButton({
    super.key,
    required this.text,
    required this.onSwipe,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
    this.controller,
    this.height = 56,
    this.width,
    this.completionThreshold = 0.90,
    this.backgroundColor,
    this.successColor,
    this.failureColor,
    this.thumbColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  State<CustomSwipeButton> createState() => _CustomSwipeButtonState();
}

class _CustomSwipeButtonState extends State<CustomSwipeButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _completed = false;
  late double _maxDrag;
  CustomSwipeButtonController? _controller;
  late AnimationController _resetController;
  Animation<double>? _resetAnimation;

  bool get _isLoading =>
      (_controller?.isLoading ?? false) ||
      (widget.controller == null && widget.isLoading);
  bool get _isSuccess =>
      (_controller?.isSuccess ?? false) ||
      (widget.controller == null && widget.isSuccess);

  @override
  void initState() {
    super.initState();
    _attachController();
    _resetController = AnimationController(vsync: this);
    _resetController.addListener(() {
      if (_resetAnimation != null) {
        setState(() {
          _dragPosition = _resetAnimation!.value;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomSwipeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _detachController(oldWidget.controller);
      _attachController();
    } else {
      // Legacy flags mode: detect transitions for reset
      if (widget.controller == null) {
        final failureJustOccurred = !oldWidget.isFailure && widget.isFailure;
        final backToIdle = !widget.isLoading &&
            !widget.isSuccess &&
            !widget.isFailure &&
            (oldWidget.isLoading || oldWidget.isSuccess || oldWidget.isFailure);
        if (failureJustOccurred || backToIdle) _reset();
      }
    }
  }

  void _attachController() {
    _controller = widget.controller;
    _controller?.addListener(_handleControllerChange);
  }

  void _detachController(CustomSwipeButtonController? old) {
    old?.removeListener(_handleControllerChange);
  }

  void _handleControllerChange() {
    if (!mounted) return;
    setState(() {
      // Reset behaviors based on controller status transitions
      if (_controller!.status == SwipeStatus.initial ||
          _controller!.status == SwipeStatus.failure) {
        _reset();
      } else if (_controller!.status == SwipeStatus.success) {
        _completed = true;
      }
    });
  }

  void _reset() {
    if (!mounted) return;
    _completed = false;
    _animateBackToStart();
  }

  void _animateBackToStart() {
    _resetController.stop();
    final start = _dragPosition;
    if (start == 0) return; // nothing to animate
    // Duration proportional to distance (max 280ms)
    final fraction = (_maxDrag == 0) ? 1.0 : (start / _maxDrag).clamp(0, 1);
    final durationMs = (120 + (160 * fraction)).round();
    _resetController.duration = Duration(milliseconds: durationMs);
    _resetAnimation = Tween<double>(begin: start, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
    );
    _resetController.forward(from: 0);
  }

  @override
  void dispose() {
    _detachController(_controller);
    _resetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseRadius = widget.borderRadius ?? 10.radiusBorder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = widget.width ?? constraints.maxWidth;
        // Fallback if unconstrained (e.g., in Column w/o expanded) -> use screen width *0.9
        final effectiveWidth = trackWidth == double.infinity
            ? context.screenWidth * 0.9
            : trackWidth;
        // Estimate thumb width: padding (24) + icon (24) + horizontal margin (16) ~ 64
        const estimatedThumbTotal = 64.0;
        _maxDrag =
            (effectiveWidth - estimatedThumbTotal).clamp(0, double.infinity);

        final bgColor = _isSuccess
            ? (widget.successColor ?? Colors.green)
            : (widget.backgroundColor ?? AppColors.purpleLight);

        final labelStyle = TextStyle(
          color: widget.textColor ?? AppColors.purple,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        );

        return Semantics(
          label: widget.text,
          button: true,
          enabled: !_isLoading && !_isSuccess,
          child: Container(
            width: effectiveWidth,
            height: widget.height,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: baseRadius,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Label / state text
                if (!_completed && !_isLoading && !_isSuccess)
                  Text(
                    widget.text,
                    style: labelStyle,
                    textAlign: TextAlign.center,
                  ),
                if (_isLoading)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 18.sp,
                        height: 18.sp,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.textColor ?? AppColors.purple,
                          ),
                        ),
                      ),
                      8.width,
                      Text('Processing', style: labelStyle),
                    ],
                  ),
                if (_isSuccess)
                  Icon(
                    Icons.check_circle_rounded,
                    color: Colors.white,
                    size: 32.sp,
                  ),

                // Thumb (no animation during drag for smoother performance)
                Positioned(
                  left: _dragPosition,
                  child: IgnorePointer(
                    ignoring: _isLoading ||
                        _isSuccess, // disable drag while busy/success
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (_isLoading || _isSuccess) return; // safety
                        if (_resetController.isAnimating) {
                          _resetController.stop();
                        }
                        setState(() {
                          _dragPosition += details.delta.dx;
                          if (_dragPosition < 0) _dragPosition = 0;
                          if (_dragPosition > _maxDrag)
                            _dragPosition = _maxDrag;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        if (_isLoading || _isSuccess) return;
                        if (_dragPosition >=
                            _maxDrag * widget.completionThreshold) {
                          setState(() => _completed = true);
                          widget.onSwipe();
                        } else {
                          // animate back smoothly
                          _animateBackToStart();
                        }
                      },
                      child: Container(
                        padding: 12.padding,
                        margin: 8.paddingHorizontal,
                        decoration: BoxDecoration(
                          color: widget.thumbColor ?? AppColors.purple,
                          borderRadius: baseRadius,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          _isLoading
                              ? Icons.hourglass_top_rounded
                              : _isSuccess
                                  ? Icons.check
                                  : Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
