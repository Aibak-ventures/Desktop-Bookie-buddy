import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingDateSelectionWidget extends StatelessWidget {
  final bool isSales;
  final DateTime pickupDate;
  final DateTime returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final int coolingPeriodDays;
  final Future<void> Function() onSelectPickupDate;
  final Future<void> Function() onSelectReturnDate;
  final Future<void> Function() onSelectPickupTime;
  final Future<void> Function() onSelectReturnTime;
  final ValueChanged<int> onCoolingPeriodChanged;

  const BookingDateSelectionWidget({
    super.key,
    required this.isSales,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupTime,
    required this.returnTime,
    required this.coolingPeriodDays,
    required this.onSelectPickupDate,
    required this.onSelectReturnDate,
    required this.onSelectPickupTime,
    required this.onSelectReturnTime,
    required this.onCoolingPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSales ? 'Sale date' : 'Select dates',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 7),
          if (isSales)
            SizedBox(
              width: 400,
              child: _buildNewDateField(
                context: context,
                label: 'Sale date',
                value: pickupDate.format(),
                onTap: onSelectPickupDate,
              ),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Pickup Date
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    context: context,
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: onSelectPickupDate,
                  ),
                ),
                const SizedBox(width: 12),
                // Pickup Time
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    context: context,
                    label: 'time',
                    value: pickupTime?.format(context) ?? '--:--',
                    onTap: onSelectPickupTime,
                  ),
                ),
                const SizedBox(width: 16),

                // Divider between Pickup and Return
                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                // Return Date
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    context: context,
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: onSelectReturnDate,
                  ),
                ),
                const SizedBox(width: 12),
                // Return Time
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    context: context,
                    label: 'time',
                    value: returnTime?.format(context) ?? '--:--',
                    onTap: onSelectReturnTime,
                  ),
                ),

                const SizedBox(width: 16),

                // Divider between Return and Cooling Period
                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                // Cooling Period (Days)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cooling period',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: coolingPeriodDays,
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                            items: [
                              const DropdownMenuItem(
                                value: 0,
                                child: Text('None'),
                              ),
                              ...List.generate(10, (index) {
                                final days = index + 1;
                                return DropdownMenuItem(
                                  value: days,
                                  child: Text(
                                    '$days day${days > 1 ? 's' : ''}',
                                  ),
                                );
                              }),
                            ],
                            onChanged: (val) {
                              if (val != null) onCoolingPeriodChanged(val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNewDateField({
    required BuildContext context,
    required String label,
    required String value,
    required Future<void> Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) => FocusScope.of(context).nextFocus());
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () =>
                onTap().then((_) => FocusScope.of(context).nextFocus()),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: Color(0xFF9A76E8),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTimeField({
    required BuildContext context,
    required String label,
    required String value,
    required Future<void> Function() onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) => FocusScope.of(context).nextFocus());
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () =>
                onTap().then((_) => FocusScope.of(context).nextFocus()),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9FC),
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

}
