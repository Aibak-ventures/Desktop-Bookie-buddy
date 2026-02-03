import 'dart:async';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_sales/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_date_filter.dart';
import 'package:flutter/material.dart';
import 'package:bookie_buddy_web/features/all_booking/view/widgets/sales_details_drawer.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_sales_details/sales_details_bloc.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_sales_details_drawer/sales_details_drawer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final ValueNotifier<DateFilterModel> _dateFilterNotifier =
      ValueNotifier(const DateFilterModel());
  Timer? _debounce;

  final List<String> _actionTabs = ['Booking', 'Sales'];

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
    _dateFilterNotifier.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  void _loadData() {
    if (_activeActionTab == 1) {
      // Load sales data
      context.read<AllSalesBloc>().add(
            AllSalesEvent.loadSales(
              searchQuery: _searchController.text.trim().isEmpty
                  ? null
                  : _searchController.text.trim(),
            ),
          );
    } else {
      // Load booking data
      // Load booking data
      context.read<AllBookingBloc>().add(
            AllBookingEvent.loadBookings(
              status: _activeStatusTab,
              searchQuery: _searchController.text.trim().isEmpty
                  ? null
                  : _searchController.text.trim(),
              startDate: _dateFilterNotifier.value.startDate?.format(),
              endDate: _dateFilterNotifier.value.endDate?.format(),
            ),
          );
    }
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
      body: BlocListener<AllBookingBloc, AllBookingState>(
        listener: (context, state) {
          state.mapOrNull(
            loaded: (s) {
              if (s.actionError != null) {
                // Show SnackBar
                context.showSnackBar(s.actionError!, isError: true);
              }
            },
          );
        },
        child: Stack(
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
            const SalesDetailsDrawer(),
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
        //  color: ,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(_actionTabs.length, (index) {
          final isActive = _activeActionTab == index;
          return GestureDetector(
            onTap: () {
              setState(() => _activeActionTab = index);
              _loadData();
            },
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
    // Hide status tabs when Sales tab is active
    if (_activeActionTab == 1) {
      return Row(
        children: [
          const Spacer(),
          _buildSearchBar(),
        ],
      );
    }

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

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        elevation: isActive ? 3 : 1,
                        shadowColor: isActive
                            ? const Color(0xFF8A63FE).withOpacity(0.3)
                            : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => _onStatusTabChanged(displayLabel),
                          borderRadius: BorderRadius.circular(8),
                          hoverColor: const Color(0xFFE7E4FF).withOpacity(0.5),
                          splashColor: const Color(0xFF8A63FE).withOpacity(0.2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFE7E4FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: isActive ? 1.5 : 1,
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
                                    fontWeight: isActive
                                        ? FontWeight.w600
                                        : FontWeight.w400,
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
              decoration: InputDecoration(
                hintText: _activeActionTab == 1
                    ? 'Search sales...'
                    : 'Search in ${_activeStatusTab.replaceAll('_', ' ')}...',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(height: 20, width: 1, color: Colors.grey.shade300),
          const SizedBox(width: 8),
          ValueListenableBuilder<DateFilterModel>(
            valueListenable: _dateFilterNotifier,
            builder: (context, filter, _) {
              final hasFilter = filter.hasActiveFilter;
              return InkWell(
                onTap: () => _showDateFilterModal(context),
                borderRadius: BorderRadius.circular(4),
                child: Icon(
                  hasFilter ? Icons.filter_list_alt : Icons.tune,
                  size: 20,
                  color: hasFilter
                      ? const Color(0xFF8A63FE)
                      : Colors.grey.shade600,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showDateFilterModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BookingDateFilter(
                isGeneratePdf: false,
                initialStartDate: _dateFilterNotifier.value.startDate,
                initialEndDate: _dateFilterNotifier.value.endDate,
                onDateFilterChanged: (startDate, endDate) {
                  _dateFilterNotifier.value =
                      _dateFilterNotifier.value.copyWith(
                    startDate: startDate,
                    endDate: endDate,
                  );
                  _loadData();
                  Navigator.pop(context);
                },
                onApplyFilter: (p0, p1, p2) {},
              ),
            ),
          ),
        ),
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
      child: _activeActionTab == 1
          ? _buildSalesContent()
          : BlocBuilder<AllBookingBloc, AllBookingState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF8A63FE))),
                  loaded: (bookings, _, __, ___, ____, _____, ______, _______,
                      ________) {
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

  Widget _buildSalesContent() {
    return BlocBuilder<AllSalesBloc, AllSalesState>(
      builder: (context, state) {
        return state.maybeWhen(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF8A63FE)),
          ),
          loaded: (sales, _, __) {
            if (sales.isEmpty) {
              return const Center(child: Text('No sales found'));
            }
            return _buildSalesTable(sales);
          },
          error: (msg) => Center(child: Text('Error: $msg')),
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildSalesTable(List<SaleModel> sales) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildTableHeader(),
        ...sales.map((sale) => _buildSalesTableRow(sale)),
      ],
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
    // Sales table header
    if (_activeActionTab == 1) {
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
                'Sale ID',
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
                'Sale Date',
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
                'Phone',
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
                'Products',
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
                'Total',
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
              width: 70,
              child: Text(
                'Discount',
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

    // Booking table header (original)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0FF),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
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
              'Delivery',
              textAlign: TextAlign.center,
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
            SizedBox(
              width: 100,
              child: Tooltip(
                message: booking.staffName ?? 'No staff assigned',
                decoration: BoxDecoration(
                  color: _parseStaffColor(booking.staffColor),
                  borderRadius: BorderRadius.circular(4),
                ),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                child: Text(
                  booking.shopBookingId ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 105,
              child: _buildDeliveryStatusDisplay(booking.deliveryStatus),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 95,
              child: Text(
                _formatDateWithLabel(booking.pickupDate ?? ''),
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                booking.bookedItems ?? '',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 110,
              child: Text(
                booking.client ?? '',
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
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

  Widget _buildDeliveryStatusDisplay(DeliveryStatus? status) {
    final effectiveStatus = status ?? DeliveryStatus.booked;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveStatus.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: effectiveStatus.color.withOpacity(0.2)),
      ),
      child: Text(
        effectiveStatus.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 11,
          color: effectiveStatus.color,
          fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDeliveryStatus(DesktopBookingItemModel booking) {
    final status = booking.deliveryStatus ?? DeliveryStatus.booked;
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                status.name,
                textAlign: TextAlign.center,
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

  /// Format date with Today/Tomorrow labels
  String _formatDateWithLabel(String dateStr) {
    if (dateStr.isEmpty) return 'N/A';
    try {
      final bookingDate = dateStr.parseToDateTime();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));
      final dateOnly = DateTime(
        bookingDate.year,
        bookingDate.month,
        bookingDate.day,
      );

      if (dateOnly == today) {
        return 'Today';
      } else if (dateOnly == tomorrow) {
        return 'Tomorrow';
      }

      // Default: Use formatted date
      return dateStr.formatToUiDate();
    } catch (e) {
      // Fallback to original format if parsing fails
      return dateStr.formatToUiDate();
    }
  }

  /// Parse staff color from hex string (e.g., "FF64B5F6")
  Color _parseStaffColor(String? staffColor) {
    if (staffColor != null && staffColor.isNotEmpty) {
      try {
        final colorString = staffColor.toUpperCase();
        return Color(int.parse('0x$colorString'));
      } catch (e) {
        // Fall back to grey if parsing fails
        return Colors.grey.shade700;
      }
    }
    return Colors.grey.shade700;
  }

  Widget _buildSalesTableRow(SaleModel sale) {
    final balance = sale.totalAmount - sale.paidAmount;
    final paymentStatus = balance == 0;

    return GestureDetector(
      onTap: () {
        context.read<SalesDetailsDrawerCubit>().openDrawer(sale.id);
        context.read<SalesDetailsBloc>().add(
              SalesDetailsEvent.fetchSaleDetails(sale.id),
            );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            const SizedBox(width: 11),
            SizedBox(
              width: 100,
              child: Text(
                '#${sale.id}',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 95,
              child: Text(
                sale.saleDate,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 110,
              child: Text(
                sale.clientPhone?.toString() ?? 'N/A',
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sale.products,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 80,
              child: Text(
                '₹${sale.totalAmount}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Text(
                '₹${sale.paidAmount}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Text(
                '₹$balance',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 70,
              child: Text(
                '₹${sale.discountAmount}',
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right, size: 18, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}
