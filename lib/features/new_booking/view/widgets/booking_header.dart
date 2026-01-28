import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:flutter/material.dart';

class BookingHeader extends StatelessWidget {
  final BookingType selectedBookingType;
  final ValueChanged<BookingType> onTabSwitch;
  final VoidCallback onBack;

  const BookingHeader({
    super.key,
    required this.selectedBookingType,
    required this.onTabSwitch,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Color(0xFFE5E0F5), // Light lavender background
      ),
      child: Row(
        children: [
          // Back button (Icon only)
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back, size: 20, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 16),
          // Tab buttons (Centered relative to the available space or just next to back button)
          _buildTabButtons(),
          const Spacer(),
          // Company Info
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'AIBAK VENTURES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Inter',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.keyboard_arrow_down,
                      size: 14, color: Colors.black87),
                  Text(
                    'KOZHIKODE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 12),
          // Logo Placeholder
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: const Icon(Icons.business, size: 18, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabButton('Booking', BookingType.booking),
          _buildTabButton('Sales', BookingType.sales),
          _buildTabButton('Custom work', BookingType.customWork),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, BookingType type) {
    final isSelected = selectedBookingType == type;
    return GestureDetector(
      onTap: () => onTabSwitch(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6132E4) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
