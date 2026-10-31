import 'package:material_ui/material_ui.dart';

/// Column header row for the bookings table in [AllBookingsDesktopScreen].
class AllBookingsBookingTableHeader extends StatelessWidget {
  /// Shows "Booked" instead of "Pickup" for the date column.
  final bool showBookedDate;

  const AllBookingsBookingTableHeader({super.key, this.showBookedDate = false});

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
      child: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Text(
              'Booking ID',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            width: 105,
            child: Text(
              'Delivery Status',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 95,
            child: Text(
              showBookedDate ? 'Booked' : 'Pickup',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Items',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(
            width: 110,
            child: Text(
              'Customer',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            width: 70,
            child: Text(
              'Paid',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            width: 70,
            child: Text(
              'Balance',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 5),
          const SizedBox(
            width: 90,
            child: Text(
              'Payment Status',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            width: 80,
            child: Text(
              'Staff',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(
            width: 80,
            child: Text(
              'Total',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}
