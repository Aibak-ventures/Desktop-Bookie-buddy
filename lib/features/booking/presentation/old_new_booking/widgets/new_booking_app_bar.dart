import 'package:flutter/material.dart';

enum BookingTabType { booking, sales, customWork, oldBooking }

class NewBookingAppBar extends StatefulWidget {
  final BookingTabType selectedTab;
  final Function(BookingTabType) onTabChanged;
  final VoidCallback? onBack;

  const NewBookingAppBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    this.onBack,
  });

  @override
  State<NewBookingAppBar> createState() => _NewBookingAppBarState();
}

class _NewBookingAppBarState extends State<NewBookingAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Back button
            // if (widget.onBack != null) ...[
            //   InkWell(
            //     onTap: widget.onBack,
            //     borderRadius: BorderRadius.circular(4),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8),
            //       child: Icon(
            //         Icons.arrow_back_ios,
            //         size: 16,
            //         color: Colors.grey.shade600,
            //       ),
            //     ),
            //   ),
            //   const SizedBox(width: 8),
            // ],
            // Tabs
            _buildTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab('Booking', BookingTabType.booking),
          _buildTab('Sales', BookingTabType.sales),
          _buildTab('Old Booking', BookingTabType.oldBooking),
          // _buildTab('Custom work', BookingTabType.customWork),
        ],
      ),
    );
  }

  Widget _buildTab(String label, BookingTabType type) {
    final isSelected = widget.selectedTab == type;
    return GestureDetector(
      onTap: () => widget.onTabChanged(type),
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
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
