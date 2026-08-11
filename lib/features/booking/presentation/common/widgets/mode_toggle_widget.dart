import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// A single tab spec for [ModeToggleWidget].
class ModeToggleTab<T> {
  final T value;
  final String label;
  final IconData icon;

  const ModeToggleTab({
    required this.value,
    required this.label,
    required this.icon,
  });
}

/// A pill-shaped, multi-tab segmented toggle used to switch between modes
/// (e.g. Booking/Sales, Expense/Income/Transfer).
///
/// ```dart
/// ModeToggleWidget<_ActionTab>(
///   selectedValue: _activeTab,
///   onChanged: _switchTab,
///   tabs: const [
///     ModeToggleTab(
///       value: _ActionTab.booking,
///       label: 'Booking',
///       icon: Icons.calendar_today_outlined,
///     ),
///     ModeToggleTab(
///       value: _ActionTab.sales,
///       label: 'Sales',
///       icon: Icons.shopping_cart_outlined,
///     ),
///   ],
/// )
/// ```
class ModeToggleWidget<T> extends StatelessWidget {
  const ModeToggleWidget({
    super.key,
    required this.tabs,
    required this.selectedValue,
    required this.onChanged,
    this.activeColor = AppColors.purpleAccent,
    this.trackColor = AppColors.purpleLight,
  });

  final List<ModeToggleTab<T>> tabs;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final Color activeColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: trackColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tabs
            .map(
              (tab) => _ModeToggleTabItem(
                label: tab.label,
                icon: tab.icon,
                isSelected: tab.value == selectedValue,
                activeColor: activeColor,
                onTap: () => onChanged(tab.value),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ModeToggleTabItem extends StatelessWidget {
  const _ModeToggleTabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
