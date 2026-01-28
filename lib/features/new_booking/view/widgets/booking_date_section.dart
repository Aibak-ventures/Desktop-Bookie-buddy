import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookingDateSection extends StatelessWidget {
  final DateTime pickupDate;
  final DateTime returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final int coolingPeriodDays;
  final VoidCallback onPickupDateTap;
  final VoidCallback onReturnDateTap;
  final VoidCallback onPickupTimeTap;
  final VoidCallback onReturnTimeTap;
  final ValueChanged<int?> onCoolingPeriodChanged;

  const BookingDateSection({
    super.key,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupTime,
    required this.returnTime,
    required this.coolingPeriodDays,
    required this.onPickupDateTap,
    required this.onReturnDateTap,
    required this.onPickupTimeTap,
    required this.onReturnTimeTap,
    required this.onCoolingPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              // Pickup Date
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildCompactDateField(
                        label: 'Pickup Date',
                        value: pickupDate.format(),
                        onTap: onPickupDateTap,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: _buildCompactTimeField(
                        label: 'Time',
                        value: pickupTime?.format(context) ?? '--:--',
                        onTap: onPickupTimeTap,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Return Date
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildCompactDateField(
                        label: 'Return Date',
                        value: returnDate.format(),
                        onTap: onReturnDateTap,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: _buildCompactTimeField(
                        label: 'Time',
                        value: returnTime?.format(context) ?? '--:--',
                        onTap: onReturnTimeTap,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Cooling Period (Days Selector)
              Expanded(
                child: _buildCoolingPeriodSelector(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoolingPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooling Period',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Container(
          height: 38, // Match approximate height of date field
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: coolingPeriodDays,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  size: 16, color: Colors.grey.shade500),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Inter',
              ),
              items: [
                const DropdownMenuItem<int>(
                  value: 0,
                  child: Text('None'),
                ),
                ...List.generate(30, (index) {
                  final days = index + 1;
                  return DropdownMenuItem<int>(
                    value: days,
                    child: Text('$days Day${days > 1 ? 's' : ''}'),
                  );
                }),
              ],
              onChanged: onCoolingPeriodChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactDateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 14, color: AppColors.purple),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTimeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.access_time, size: 14, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
