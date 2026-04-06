import 'package:flutter/material.dart';

/// Column header row for the sales table in [AllBookingsDesktopScreen].
class AllBookingsSalesTableHeader extends StatelessWidget {
  const AllBookingsSalesTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F0FF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Row(
        children: [
          SizedBox(width: 11),
          SizedBox(
            width: 100,
            child: Text('Sale ID', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 95,
            child: Text('Sale Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 110,
            child: Text('Phone', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text('Items', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text('Total', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text('Paid', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text('Discount', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 28),
        ],
      ),
    );
  }
}
