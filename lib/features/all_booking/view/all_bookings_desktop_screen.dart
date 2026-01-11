import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
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
  String _activeStatusTab = 'upcoming'; // API status value
  final TextEditingController _searchController = TextEditingController();

  final List<String> _actionTabs = ['Booking', 'Sales', 'Custom work'];

  // Map display labels to API status values
  final Map<String, String> _statusApiMap = {
    'Upcoming': 'upcoming',
    'Returns': 'returns',
    'Pending': 'pending',
    'Not Returned': 'not_returned',
    'Completed': 'completed',
  };

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    // Debounce search - you can add a timer here if needed
    _loadData();
  }

  void _loadData() {
    context.read<AllBookingBloc>().add(
          AllBookingEvent.loadBookings(
            status: _activeStatusTab,
            searchQuery: _searchController.text.trim().isEmpty
                ? null
                : _searchController.text.trim(),
          ),
        );
  }

  void _onStatusTabChanged(String displayLabel) {
    final apiStatus = _statusApiMap[displayLabel];
    if (apiStatus != null) {
      setState(() => _activeStatusTab = apiStatus);
      _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content
          Padding(
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
          // Drawer overlay
          const BookingDetailsDrawer(),
        ],
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
        //  color: ,
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
    return BlocBuilder<AllBookingBloc, AllBookingState>(
      builder: (context, state) {
        // Get status counts from the loaded state
        final statusCounts = state.maybeMap(
          loaded: (loadedState) => loadedState.statusCounts,
          orElse: () => null,
        );

        return Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _statusApiMap.keys.map((displayLabel) {
                    final apiStatus = _statusApiMap[displayLabel]!;
                    final isActive = _activeStatusTab == apiStatus;

                    // Get count from API response
                    int count = 0;
                    if (statusCounts != null) {
                      switch (apiStatus) {
                        case 'upcoming':
                          count = statusCounts.upcoming;
                          break;
                        case 'returns':
                          count = statusCounts.returns;
                          break;
                        case 'pending':
                          count = statusCounts.pending;
                          break;
                        case 'not_returned':
                          count = statusCounts.notReturned;
                          break;
                        case 'completed':
                          count = statusCounts.completed;
                          break;
                      }
                    }

                    return GestureDetector(
                      onTap: () => _onStatusTabChanged(displayLabel),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color:
                              isActive ? const Color(0xFFE7E4FF) : Colors.white,
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
                              displayLabel,
                              style: TextStyle(
                                color: isActive
                                    ? const Color(0xFF8A63FE)
                                    : Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
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
                                '$count',
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
      },
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
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
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
            loaded: (bookings, _, __, ___, ____, _____, ______, _______) {
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

  Widget _buildTable(List<DesktopBookingItemModel> bookings) {
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
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0FF),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 11), // Match the bar (3px) + spacing (8px)
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
            width: 95,
            child: Text(
              'Pickup',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 12),
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
          const SizedBox(width: 12),
          const SizedBox(
            width: 105,
            child: Text(
              'Delivery',
              style: TextStyle(
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
          const SizedBox(width: 12),
          const SizedBox(
            width: 90,
            child: Text(
              'Payment',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(width: 28), // Match chevron icon width + spacing
        ],
      ),
    );
  }

  Widget _buildTableRow(DesktopBookingItemModel booking) {
    // Parse staff color from hex string (e.g., "FF64B5F6")
    Color barColor = Colors.purple;
    if (booking.staffColor != null && booking.staffColor!.isNotEmpty) {
      try {
        final colorString = booking.staffColor!.toUpperCase();
        barColor = Color(int.parse('0x$colorString'));
      } catch (e) {
        // Fall back to purple if parsing fails
        barColor = Colors.purple;
      }
    }

    return GestureDetector(
      onTap: () {
        if (booking.id != null) {
          // Open drawer
          context.read<BookingDetailsDrawerCubit>().openDrawer(booking.id);
          // Fetch booking details
          context.read<BookingDetailsBloc>().add(
                BookingDetailsEvent.fetchBookingDetails(booking.id),
              );
        }
      },
      child: Container(
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
            SizedBox(
              width: 100,
              child: Text(
                booking.shopBookingId,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 95,
              child: Text(
                booking.pickupDate.formatToUiDate(),
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 110,
              child: Text(
                booking.client,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 80,
              child: Text(
                booking.staffName ?? '-',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 105,
              child: _buildDeliveryStatus(booking),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                booking.bookedItems,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Text(
                '₹${booking.advanceAmount}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Text(
                '₹${booking.remainingAmount}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 90,
              child: _buildPaymentStatus(booking.paymentStatus),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right, size: 18, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatus(DesktopBookingItemModel booking) {
    final status = booking.deliveryStatus;
    return PopupMenuButton<DeliveryStatus>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (DeliveryStatus newStatus) {
        if (booking.id != null) {
          context.read<AllBookingBloc>().add(
                AllBookingEvent.updateDeliveryStatus(
                  bookingId: booking.id,
                  deliveryStatus: newStatus,
                ),
              );
        }
      },
      itemBuilder: (context) => DeliveryStatus.values.map((s) {
        return PopupMenuItem<DeliveryStatus>(
          value: s,
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: s.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                s.name,
                style: TextStyle(
                  fontSize: 13,
                  color: s.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: status.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: status.color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                status.name,
                style: TextStyle(
                  fontSize: 10,
                  color: status.color,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down, size: 12, color: status.color),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentStatus(bool isPaid) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: isPaid
            ? const Color(0xFF20D400).withOpacity(0.1)
            : const Color(0xFFD4B800).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isPaid ? 'Completed' : 'Pending',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10,
          color: isPaid ? const Color(0xFF20D400) : const Color(0xFFD4B800),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
