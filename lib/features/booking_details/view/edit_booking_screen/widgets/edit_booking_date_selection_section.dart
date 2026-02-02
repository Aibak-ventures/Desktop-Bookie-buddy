import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Date selection section for edit booking screen
/// Handles booking mode (pickup + return) and sales mode (single date)
class EditBookingDateSelectionSection extends StatelessWidget {
  final DateTime pickupDate;
  final DateTime returnDate;
  final DateTime? coolingPeriodDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final TimeOfDay? coolingPeriodTime;
  final ValueChanged<DateTime> onPickupDateChanged;
  final ValueChanged<DateTime> onReturnDateChanged;
  final ValueChanged<DateTime?>? onCoolingPeriodDateChanged;
  final ValueChanged<TimeOfDay?> onPickupTimeChanged;
  final ValueChanged<TimeOfDay?> onReturnTimeChanged;
  final ValueChanged<TimeOfDay?>? onCoolingPeriodTimeChanged;
  final bool isSalesMode;

  const EditBookingDateSelectionSection({
    super.key,
    required this.pickupDate,
    required this.returnDate,
    this.coolingPeriodDate,
    required this.pickupTime,
    required this.returnTime,
    this.coolingPeriodTime,
    required this.onPickupDateChanged,
    required this.onReturnDateChanged,
    this.onCoolingPeriodDateChanged,
    required this.onPickupTimeChanged,
    required this.onReturnTimeChanged,
    this.onCoolingPeriodTimeChanged,
    this.isSalesMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSalesMode ? 'Sale Date' : 'Booking Period',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          if (isSalesMode)
            _buildDateTimeRow(
              context: context,
              label: 'Date',
              date: pickupDate,
              time: null,
              onDateTap: () => _selectDate(context, true),
              onTimeTap: null,
            )
          else ...[
            _buildDateTimeRow(
              context: context,
              label: 'Pickup',
              date: pickupDate,
              time: pickupTime,
              onDateTap: () => _selectDate(context, true),
              onTimeTap: () => _selectTime(context, true),
            ),
            const SizedBox(height: 12),
            _buildDateTimeRow(
              context: context,
              label: 'Return',
              date: returnDate,
              time: returnTime,
              onDateTap: () => _selectDate(context, false),
              onTimeTap: () => _selectTime(context, false),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDateTimeRow({
    required BuildContext context,
    required String label,
    required DateTime date,
    required TimeOfDay? time,
    required VoidCallback onDateTap,
    required VoidCallback? onTimeTap,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _buildCompactDateField(
            context: context,
            label: label,
            value: date.format(),
            onTap: onDateTap,
          ),
        ),
        if (onTimeTap != null) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _buildCompactTimeField(
              context: context,
              label: 'Time',
              value: time?.format(context) ?? '--:--',
              onTap: onTimeTap,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCompactDateField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: AppColors.purple),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTimeField({
    required BuildContext context,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.access_time, size: 16, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final initialDate = isPickup ? pickupDate : returnDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isPickup) {
        onPickupDateChanged(picked);
      } else {
        onReturnDateChanged(picked);
      }
    }
  }

  Future<void> _selectTime(BuildContext context, bool isPickup) async {
    final initialTime = isPickup
        ? (pickupTime ?? TimeOfDay.now())
        : (returnTime ?? TimeOfDay.now());
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (isPickup) {
        onPickupTimeChanged(picked);
      } else {
        onReturnTimeChanged(picked);
      }
    }
  }
}
