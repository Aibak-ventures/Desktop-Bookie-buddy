import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardNavigableDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Color? selectedColor;
  final ValueChanged<DateTime>? onDateSelected;

  const KeyboardNavigableDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.selectedColor,
    this.onDateSelected,
  });

  @override
  State<KeyboardNavigableDatePicker> createState() =>
      _KeyboardNavigableDatePickerState();
}

class _KeyboardNavigableDatePickerState
    extends State<KeyboardNavigableDatePicker> {
  // Date-only normalized bounds, so time components never skew comparisons.
  late final DateTime _firstDate;
  late final DateTime _lastDate;

  // Single source of truth for what the calendar shows.
  late DateTime _displayedMonth; // first day of the visible month
  late DateTime _focusedDate; // keyboard cursor
  late DateTime _selectedDate; // the chosen date

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstDate = _dateOnly(widget.firstDate);
    _lastDate = _dateOnly(widget.lastDate);

    final initial = _clamp(_dateOnly(widget.initialDate));
    _selectedDate = initial;
    _focusedDate = initial;
    _displayedMonth = DateTime(initial.year, initial.month);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  DateTime _clamp(DateTime d) {
    if (d.isBefore(_firstDate)) return _firstDate;
    if (d.isAfter(_lastDate)) return _lastDate;
    return d;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isInRange(DateTime date) =>
      !date.isBefore(_firstDate) && !date.isAfter(_lastDate);

  bool get _canGoPrevious => DateTime(
    _displayedMonth.year,
    _displayedMonth.month,
    1,
  ).isAfter(DateTime(_firstDate.year, _firstDate.month, 1));

  bool get _canGoNext => DateTime(
    _displayedMonth.year,
    _displayedMonth.month,
    1,
  ).isBefore(DateTime(_lastDate.year, _lastDate.month, 1));

  void _goToPreviousMonth() {
    if (!_canGoPrevious) return;
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _goToNextMonth() {
    if (!_canGoNext) return;
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  void _moveFocus(int dayDelta) {
    final newDate = _focusedDate.add(Duration(days: dayDelta));
    if (!_isInRange(newDate)) return;
    setState(() {
      _focusedDate = newDate;
      _displayedMonth = DateTime(newDate.year, newDate.month);
    });
  }

  void _selectDate(DateTime date) {
    final selected = _dateOnly(date);
    widget.onDateSelected?.call(selected);
    Navigator.of(context).pop(selected);
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        _moveFocus(-1);
        break;
      case LogicalKeyboardKey.arrowRight:
        _moveFocus(1);
        break;
      case LogicalKeyboardKey.arrowUp:
        _moveFocus(-7);
        break;
      case LogicalKeyboardKey.arrowDown:
        _moveFocus(7);
        break;
      case LogicalKeyboardKey.enter:
      case LogicalKeyboardKey.space:
        if (_isInRange(_focusedDate)) _selectDate(_focusedDate);
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
        width: 320,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildWeekdayHeaders(),
            const SizedBox(height: 8),
            _buildMonthCalendar(),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: _canGoPrevious ? _goToPreviousMonth : null,
        ),
        Text(
          '${_getMonthName(_displayedMonth.month)} ${_displayedMonth.year}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: _canGoNext ? _goToNextMonth : null,
        ),
      ],
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map(
            (day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMonthCalendar() {
    final monthDate = _displayedMonth;
    final daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final startOffset = (firstDayOfMonth.weekday - 1) % 7;

    return SizedBox(
      height: 240,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 42,
        itemBuilder: (context, index) {
          final dayOffset = index - startOffset;
          if (dayOffset < 0 || dayOffset >= daysInMonth) {
            return const SizedBox.shrink();
          }

          final date = DateTime(monthDate.year, monthDate.month, dayOffset + 1);
          final isSelected = _isSameDay(date, _selectedDate);
          final isFocused = _isSameDay(date, _focusedDate);
          final isInRange = _isInRange(date);
          final isToday = _isSameDay(date, DateTime.now());

          return GestureDetector(
            onTap: isInRange ? () => _selectDate(date) : null,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? (widget.selectedColor ??
                          Theme.of(context).colorScheme.primary)
                    : isFocused
                    ? Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2)
                    : null,
                borderRadius: BorderRadius.circular(8),
                border: isToday
                    ? Border.all(
                        color:
                            widget.selectedColor ??
                            Theme.of(context).colorScheme.primary,
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: Text(
                  '${dayOffset + 1}',
                  style: TextStyle(
                    color: !isInRange
                        ? Theme.of(context).disabledColor
                        : isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : null,
                    fontWeight: isFocused || isToday ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => _selectDate(_selectedDate),
          child: const Text('OK'),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

Future<DateTime?> showKeyboardDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
  Color? selectedColor,
}) {
  return showDialog<DateTime>(
    context: context,
    builder: (context) => Dialog(
      child: KeyboardNavigableDatePicker(
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate,
        selectedColor: selectedColor,
      ),
    ),
  );
}
