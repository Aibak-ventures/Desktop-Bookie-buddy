import 'package:flutter/material.dart';

/// Column header row for the bookings table in [AllBookingsDesktopScreen].
class AllBookingsBookingTableHeader extends StatelessWidget {
  const AllBookingsBookingTableHeader({super.key});

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
          SizedBox(
            width: 100,
            child: Text('Booking ID', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 105,
            child: Text('Delivery Status', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 20),
          SizedBox(
            width: 95,
            child: Text('Pickup', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text('Items', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(
            width: 110,
            child: Text('Customer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text('Paid', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 70,
            child: Text('Balance', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 90,
            child: Text('Payment Status', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 80,
            child: Text('Staff', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
          ),
          SizedBox(width: 28),
        ],
      ),
    );
  }
}
