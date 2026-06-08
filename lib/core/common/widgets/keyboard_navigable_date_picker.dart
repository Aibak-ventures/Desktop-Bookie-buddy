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
  late DateTime _focusedDate;
  late DateTime _selectedDate;
  late PageController _pageController;
  int _currentMonthOffset = 0;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusedDate = widget.initialDate;
    _selectedDate = widget.initialDate;
    _pageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isInRange(DateTime date) =>
      !date.isBefore(widget.firstDate) && !date.isAfter(widget.lastDate);

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    setState(() {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowLeft:
          final newDate = _focusedDate.subtract(const Duration(days: 1));
          if (_isInRange(newDate)) {
            _focusedDate = newDate;
            _updateMonthIfNeeded(newDate);
          }
          break;
        case LogicalKeyboardKey.arrowRight:
          final newDate = _focusedDate.add(const Duration(days: 1));
          if (_isInRange(newDate)) {
            _focusedDate = newDate;
            _updateMonthIfNeeded(newDate);
          }
          break;
        case LogicalKeyboardKey.arrowUp:
          final newDate = _focusedDate.subtract(const Duration(days: 7));
          if (_isInRange(newDate)) {
            _focusedDate = newDate;
            _updateMonthIfNeeded(newDate);
          }
          break;
        case LogicalKeyboardKey.arrowDown:
          final newDate = _focusedDate.add(const Duration(days: 7));
          if (_isInRange(newDate)) {
            _focusedDate = newDate;
            _updateMonthIfNeeded(newDate);
          }
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.space:
          _selectedDate = _focusedDate;
          widget.onDateSelected?.call(_selectedDate);
          Navigator.of(context).pop(_selectedDate);
          break;
        case LogicalKeyboardKey.escape:
          Navigator.of(context).pop();
          break;
        default:
          break;
      }
    });
  }

  void _updateMonthIfNeeded(DateTime newDate) {
    final currentMonth = DateTime(
      widget.initialDate.year,
      widget.initialDate.month + _currentMonthOffset,
    );
    if (newDate.month != currentMonth.month ||
        newDate.year != currentMonth.year) {
      _currentMonthOffset = (newDate.year - widget.initialDate.year) * 12 +
          newDate.month -
          widget.initialDate.month;
      _pageController.jumpToPage(_currentMonthOffset);
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
            _buildCalendarGrid(),
            const SizedBox(height: 16),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final displayDate = DateTime(
      widget.initialDate.year,
      widget.initialDate.month + _currentMonthOffset,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            setState(() {
              _currentMonthOffset--;
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
        ),
        Text(
          '${_getMonthName(displayDate.month)} ${displayDate.year}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            setState(() {
              _currentMonthOffset++;
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            });
          },
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    return SizedBox(
      height: 240,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentMonthOffset = index;
          });
        },
        itemBuilder: (context, index) {
          final monthDate = DateTime(
            widget.initialDate.year,
            widget.initialDate.month + index,
          );
          return _buildMonthCalendar(monthDate);
        },
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime monthDate) {
    final daysInMonth =
        DateTime(monthDate.year, monthDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final startOffset = (firstDayOfMonth.weekday - 1) % 7;

    return GridView.builder(
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

        final date = DateTime(
          monthDate.year,
          monthDate.month,
          dayOffset + 1,
        );
        final isSelected = _isSameDay(date, _selectedDate);
        final isFocused = _isSameDay(date, _focusedDate);
        final isInRange = _isInRange(date);
        final isToday = _isSameDay(date, DateTime.now());

        return GestureDetector(
          onTap: isInRange
              ? () {
                  setState(() {
                    _selectedDate = date;
                    _focusedDate = date;
                  });
                  widget.onDateSelected?.call(date);
                  Navigator.of(context).pop(date);
                }
              : null,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? (widget.selectedColor ??
                      Theme.of(context).colorScheme.primary)
                  : isFocused
                      ? Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.2)
                      : null,
              borderRadius: BorderRadius.circular(8),
              border: isToday
                  ? Border.all(
                      color: widget.selectedColor ??
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
                  fontWeight:
                      isFocused || isToday ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        );
      },
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
          onPressed: () {
            widget.onDateSelected?.call(_selectedDate);
            Navigator.of(context).pop(_selectedDate);
          },
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
