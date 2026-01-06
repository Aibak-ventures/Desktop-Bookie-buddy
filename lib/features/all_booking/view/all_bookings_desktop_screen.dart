import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingsDesktopScreen extends StatefulWidget {
  const AllBookingsDesktopScreen({super.key});

  @override
  State<AllBookingsDesktopScreen> createState() =>
      _AllBookingsDesktopScreenState();
}

class _AllBookingsDesktopScreenState extends State<AllBookingsDesktopScreen> {
  int _activeActionTab = 0; // 0: Booking, 1: Sales, 2: Custom work
  String _activeStatusTab = 'Upcoming';

  final List<String> _actionTabs = ['Booking', 'Sales', 'Custom work'];
  final List<Map<String, dynamic>> _statusTabs = [
    {'label': 'Upcoming', 'count': 9, 'color': const Color(0xFF8A63FE)},
    {'label': 'Returns', 'count': 4, 'color': Colors.transparent},
    {'label': 'Pendings', 'count': 3, 'color': Colors.transparent},
    {'label': 'Not Returned', 'count': 4, 'color': Colors.transparent},
    {'label': 'completed', 'count': 4, 'color': Colors.transparent},
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<AllBookingBloc>().add(const AllBookingEvent.loadBookings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopHeader(),
            const SizedBox(height: 24),
            _buildFilterRow(),
            const SizedBox(height: 16),
            Expanded(child: _buildMainContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, size: 20),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 12),
        const Text(
          'All Orders > ',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          'Bookings list',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF2D3436),
          ),
        ),
        const Spacer(),
        _buildActionTabs(),
      ],
    );
  }

  Widget _buildActionTabs() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7E4FF).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(_actionTabs.length, (index) {
          final isActive = _activeActionTab == index;
          return GestureDetector(
            onTap: () => setState(() => _activeActionTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF8A63FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    index == 0
                        ? Icons.calendar_today_outlined
                        : index == 1
                            ? Icons.shopping_cart_outlined
                            : Icons.architecture_outlined,
                    size: 18,
                    color: isActive ? Colors.white : Colors.grey.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _actionTabs[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isActive ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _statusTabs.map((tab) {
                final isActive = _activeStatusTab == tab['label'];
                return GestureDetector(
                  onTap: () => setState(() => _activeStatusTab = tab['label']),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFE7E4FF) : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive
                            ? const Color(0xFF8A63FE).withOpacity(0.3)
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          tab['label'],
                          style: TextStyle(
                              color: isActive
                                  ? const Color(0xFF8A63FE)
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: isActive
                                ? const Color(0xFF8A63FE)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${tab['count']}',
                            style: TextStyle(
                              fontSize: 10,
                              color: isActive
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      width: 350,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE7E4FF).withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, size: 20, color: Colors.grey),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or id',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(height: 20, width: 1, color: Colors.grey.shade300),
          const SizedBox(width: 8),
          const Icon(Icons.tune, size: 20, color: Color(0xFF8A63FE)),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: BlocBuilder<AllBookingBloc, AllBookingState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF8A63FE))),
            loaded: (bookings, _, __, ___, ____, _____) {
              if (bookings.isEmpty)
                return const Center(child: Text('No bookings found'));
              return _buildTable(bookings);
            },
            error: (msg) => Center(child: Text('Error: $msg')),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }

  Widget _buildTable(List<BookingsModel> bookings) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildTableHeader(),
        ...bookings.map((b) => _buildTableRow(b)),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Row(
        children: const [
          SizedBox(width: 4),
          Expanded(flex: 2, child: _HeaderText('Booking ID')),
          Expanded(flex: 2, child: _HeaderText('Pickup')),
          Expanded(flex: 2, child: _HeaderText('Customer')),
          Expanded(flex: 2, child: _HeaderText('Delivery status')),
          Expanded(flex: 3, child: _HeaderText('items')),
          Expanded(flex: 1, child: _HeaderText('paid')),
          Expanded(flex: 1, child: _HeaderText('Balance')),
          Expanded(flex: 2, child: _HeaderText('Payment status')),
        ],
      ),
    );
  }

  Widget _buildTableRow(BookingsModel booking) {
    // Determine the indicator color (just a demo selection based on ID)
    final barColors = [
      Colors.yellow,
      Colors.cyan,
      Colors.purple,
      Colors.red,
      Colors.green
    ];
    final barColor = barColors[booking.id! % barColors.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Container(
              width: 3,
              height: 20,
              decoration: BoxDecoration(
                  color: barColor, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              booking.shopBookingId ?? '#${booking.id}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.pickupDate ?? 'N/A',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              booking.clientName,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child:
                SizedBox(child: _buildDeliveryStatus(booking.deliveryStatus)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              booking.bookedItems.join(', '),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text('₹3,400',
                style: const TextStyle(
                    fontSize: 13)), // Placeholder as per screenshot
          ),
          Expanded(
            flex: 1,
            child: Text('₹1,400',
                style: const TextStyle(
                    fontSize: 13)), // Placeholder as per screenshot
          ),
          Expanded(
            flex: 2,
            child: _buildPaymentStatus(booking.paymentStatus.isCompleted),
          ),
          const Icon(Icons.chevron_right, size: 18, color: Colors.blueAccent),
        ],
      ),
    );
  }

  Widget _buildDeliveryStatus(DeliveryStatus status) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFF20D400).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Ready to deliver',
            style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF20D400),
                fontWeight: FontWeight.w600),
          ),
          const Icon(Icons.keyboard_arrow_down,
              size: 14, color: Color(0xFF20D400)),
        ],
      ),
    );
  }

  Widget _buildPaymentStatus(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPaid
            ? const Color(0xFF20D400).withOpacity(0.1)
            : const Color(0xFFD4B800).withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isPaid ? 'Completed' : 'Pending',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: isPaid ? const Color(0xFF20D400) : const Color(0xFFD4B800),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  final String text;
  const _HeaderText(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
          color: Color(0xFFF1F0FF),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          )),
    );
  }
}
