import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A keyboard-navigable time picker.
///
/// - Left/Right arrows move between the hour, minute and AM/PM segments.
/// - Up/Down arrows increase/decrease the focused segment.
/// - Enter confirms and closes; Escape cancels.
/// - Segments are also tappable, with +/- buttons for mouse users.
class KeyboardNavigableTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  final Color? selectedColor;

  const KeyboardNavigableTimePicker({
    super.key,
    required this.initialTime,
    this.selectedColor,
  });

  @override
  State<KeyboardNavigableTimePicker> createState() =>
      _KeyboardNavigableTimePickerState();
}

class _KeyboardNavigableTimePickerState
    extends State<KeyboardNavigableTimePicker> {
  late int _hour; // 1..12
  late int _minute; // 0..59
  late bool _isAm;

  /// 0 = hour, 1 = minute, 2 = meridiem.
  int _segment = 0;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final t = widget.initialTime;
    _isAm = t.hour < 12;
    final h12 = t.hourOfPeriod; // 0..11
    _hour = h12 == 0 ? 12 : h12;
    _minute = t.minute;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color get _accent =>
      widget.selectedColor ?? Theme.of(context).colorScheme.primary;

  TimeOfDay get _result {
    int hour24;
    if (_isAm) {
      hour24 = _hour == 12 ? 0 : _hour;
    } else {
      hour24 = _hour == 12 ? 12 : _hour + 12;
    }
    return TimeOfDay(hour: hour24, minute: _minute);
  }

  void _increment() {
    setState(() {
      switch (_segment) {
        case 0:
          _hour = (_hour % 12) + 1;
          break;
        case 1:
          _minute = (_minute + 1) % 60;
          break;
        case 2:
          _isAm = !_isAm;
          break;
      }
    });
  }

  void _decrement() {
    setState(() {
      switch (_segment) {
        case 0:
          _hour = ((_hour - 2 + 12) % 12) + 1;
          break;
        case 1:
          _minute = (_minute - 1 + 60) % 60;
          break;
        case 2:
          _isAm = !_isAm;
          break;
      }
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        setState(() => _segment = (_segment - 1 + 3) % 3);
        break;
      case LogicalKeyboardKey.arrowRight:
        setState(() => _segment = (_segment + 1) % 3);
        break;
      case LogicalKeyboardKey.arrowUp:
        _increment();
        break;
      case LogicalKeyboardKey.arrowDown:
        _decrement();
        break;
      case LogicalKeyboardKey.enter:
      case LogicalKeyboardKey.numpadEnter:
        Navigator.of(context).pop(_result);
        break;
      case LogicalKeyboardKey.escape:
        Navigator.of(context).pop();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select time',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Use ← → to move, ↑ ↓ to change, Enter to confirm',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSegment(
                  index: 0,
                  text: _hour.toString().padLeft(2, '0'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ':',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                _buildSegment(
                  index: 1,
                  text: _minute.toString().padLeft(2, '0'),
                ),
                const SizedBox(width: 12),
                _buildSegment(index: 2, text: _isAm ? 'AM' : 'PM'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(_result),
                  style: FilledButton.styleFrom(backgroundColor: _accent),
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegment({required int index, required String text}) {
    final isFocused = _segment == index;
    return GestureDetector(
      onTap: () => setState(() => _segment = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.keyboard_arrow_up),
            onPressed: () {
              setState(() => _segment = index);
              _increment();
            },
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isFocused
                  ? _accent.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isFocused ? _accent : Colors.grey.shade300,
                width: isFocused ? 2 : 1,
              ),
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isFocused ? _accent : null,
                  ),
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              setState(() => _segment = index);
              _decrement();
            },
          ),
        ],
      ),
    );
  }
}

Future<TimeOfDay?> showKeyboardTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  Color? selectedColor,
}) {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) => Dialog(
      child: KeyboardNavigableTimePicker(
        initialTime: initialTime,
        selectedColor: selectedColor,
      ),
    ),
  );
}
