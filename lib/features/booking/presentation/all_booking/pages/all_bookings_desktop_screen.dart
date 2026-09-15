import 'dart:async';
import 'package:bookie_buddy_shared/core/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/custom_date_filter_widget.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_entity/sale_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_booking_table_header.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_booking_table_row.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_sales_table_header.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_sales_table_row.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/common/models/date_filter.dart';
import 'package:flutter/material.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_details_drawer.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/all_sales_bloc/all_sales_bloc.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sales_details_drawer_cubit/sales_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/mode_toggle_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBookingsDesktopScreen extends StatefulWidget {
  final String?
  initialStatusTab; // Optional: 'upcoming', 'completed', 'not_returned'

  const AllBookingsDesktopScreen({super.key, this.initialStatusTab});

  @override
  State<AllBookingsDesktopScreen> createState() =>
      AllBookingsDesktopScreenState();
}

class AllBookingsDesktopScreenState extends State<AllBookingsDesktopScreen> {
  int _activeActionTab = 0; // 0: Booking, 1: Sales, 2: Custom work
  String _activeStatusTab = 'upcoming'; // API status value
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<DateFilter> _dateFilterNotifier = ValueNotifier(
    const DateFilter(),
  );
  final ValueNotifier<PurchaseMode?> _purchaseModeFilterNotifier =
      ValueNotifier(null);
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  bool _hasSalesFeature(UserEntity? userState) =>
      userState?.subscription?.features.contains(AppPremiumFeatures.sales) ??
      false;

  // Map display labels to API status values
  final Map<String, String> _statusApiMap = {
    'Upcoming': 'upcoming',
    'Returns': 'returns',
    'Pending': 'pending',
    'Not Returned': 'not_returned',
    'Completed': 'completed',
    'Cancelled': 'cancelled',
  };

  /// Public method to change the active status tab from outside (via GlobalKey)
  void changeStatusTab(String statusTab) {
    if (mounted) {
      setState(() => _activeStatusTab = statusTab);
      _loadData();
    }
  }

  @override
  void initState() {
    super.initState();
    // Use initialStatusTab if provided, otherwise default to 'upcoming'
    if (widget.initialStatusTab != null) {
      _activeStatusTab = widget.initialStatusTab!;
    }
    _loadData();
    _searchController.addListener(_onSearchChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_activeActionTab == 1) {
        context.read<AllSalesBloc>().add(const AllSalesEvent.loadMoreSales());
      } else {
        context.read<AllBookingBloc>().add(
          const AllBookingEvent.loadNextPageBookings(),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dateFilterNotifier.dispose();
    _purchaseModeFilterNotifier.dispose();
    _scrollController.dispose();
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
          fromDate: _dateFilterNotifier.value.startDate?.format(reverse: true),
          toDate: _dateFilterNotifier.value.endDate?.format(reverse: true),
        ),
      );
    } else {
      // Load booking data
      context.read<AllBookingBloc>().add(
        AllBookingEvent.loadBookings(
          status: _activeStatusTab,
          searchQuery: _searchController.text.trim().isEmpty
              ? null
              : _searchController.text.trim(),
          startDate: _dateFilterNotifier.value.startDate?.format(),
          endDate: _dateFilterNotifier.value.endDate?.format(),
          purchaseMode: _purchaseModeFilterNotifier.value,
        ),
      );
    }
  }

  void _onStatusTabChanged(String displayLabel) {
    final apiStatus = _statusApiMap[displayLabel];
    if (apiStatus != null) {
      setState(() => _activeStatusTab = apiStatus);
      _loadData();
      // Close the booking details drawer when switching status tabs
      context.read<BookingDetailsDrawerCubit>().closeDrawer();
      context.read<SalesDetailsDrawerCubit>().closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserEntity?>(
      listenWhen: (previous, current) {
        // Only trigger when shop actually changes
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, userState) {
        // When shop changes, reload data and close drawers
        if (userState != null) {
          _loadData();
          // Close drawers when shop changes
          context.read<BookingDetailsDrawerCubit>().closeDrawer();
          context.read<SalesDetailsDrawerCubit>().closeDrawer();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocListener(
          listeners: [
            BlocListener<AllBookingBloc, AllBookingState>(
              listener: (context, state) {
                state.mapOrNull(
                  loaded: (s) {
                    if (s.actionError != null) {
                      // Show SnackBar
                      context.showSnackBar(s.actionError!, isError: true);
                    }
                  },
                );
                // If the loaded page didn't fill the viewport, there's no
                // scroll event to trigger loading the next page, so check
                // again after this frame renders.
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _onScroll();
                });
              },
            ),
            BlocListener<AllSalesBloc, AllSalesState>(
              listener: (context, state) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _onScroll();
                });
              },
            ),
          ],
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
              // Drawer overlay - drawers stay open unless:
              // 1. User explicitly closes via X button
              // 2. Tab is switched (handled in _onStatusTabChanged and action tabs)
              // 3. Shop is switched (handled in UserCubit listener)
              const BookingDetailsDrawer(),
              const SalesDetailsDrawer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return Row(
      children: [
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.arrow_back, size: 20),
        //   padding: EdgeInsets.zero,
        //   constraints: const BoxConstraints(),
        // ),
        // const SizedBox(width: 12),
        // const Text(
        //   'All Orders > ',
        //   style: TextStyle(
        //     fontSize: 18,
        //     color: Colors.grey,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        Text(
          _activeActionTab == 1 ? 'Sales list' : 'Bookings list',
          style: const TextStyle(
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
    return BlocBuilder<UserCubit, UserEntity?>(
      builder: (context, userState) {
        final hasSales = _hasSalesFeature(userState);
        final tabCount = hasSales ? 2 : 1;

        // If Sales tab was selected but is no longer available, reset to Booking.
        if (_activeActionTab >= tabCount) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _activeActionTab = 0);
          });
        }

        return ModeToggleWidget<int>(
          selectedValue: _activeActionTab,
          onChanged: (index) {
            setState(() => _activeActionTab = index);
            _loadData();
            // Close the booking details drawer when switching tabs
            context.read<BookingDetailsDrawerCubit>().closeDrawer();
            context.read<SalesDetailsDrawerCubit>().closeDrawer();
          },
          tabs: [
            const ModeToggleTab(
              value: 0,
              label: 'Booking',
              icon: Icons.calendar_today_outlined,
            ),
            if (hasSales)
              const ModeToggleTab(
                value: 1,
                label: 'Sales',
                icon: Icons.shopping_cart_outlined,
              ),
          ],
        );
      },
    );
  }

  Widget _buildFilterRow() {
    // Hide status tabs when Sales tab is active
    if (_activeActionTab == 1) {
      return Row(children: [_buildSearchBar(), const Spacer()]);
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
                        case 'cancelled':
                          count = statusCounts.cancelled;
                          break;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Material(
                        elevation: isActive ? 3 : 1,
                        shadowColor: isActive
                            ? const Color(0xFF8A63FE).withValues(alpha: 0.3)
                            : Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => _onStatusTabChanged(displayLabel),
                          borderRadius: BorderRadius.circular(8),
                          hoverColor: const Color(
                            0xFFE7E4FF,
                          ).withValues(alpha: 0.5),
                          splashColor: const Color(
                            0xFF8A63FE,
                          ).withValues(alpha: 0.2),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? const Color(0xFFE7E4FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: isActive ? 1.5 : 1,
                                color: isActive
                                    ? const Color(
                                        0xFF8A63FE,
                                      ).withValues(alpha: 0.3)
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
                                    horizontal: 4,
                                    vertical: 1,
                                  ),
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
        color: const Color(0xFFE7E4FF).withValues(alpha: 0.3),
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
          ListenableBuilder(
            listenable: Listenable.merge([
              _dateFilterNotifier,
              _purchaseModeFilterNotifier,
            ]),
            builder: (context, _) {
              final hasFilter =
                  _dateFilterNotifier.value.hasActiveFilter ||
                  _purchaseModeFilterNotifier.value != null;
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
    // Hide the purchase-type filter for Sales, which has no purchase mode.
    final showPurchaseModeFilter = _activeActionTab != 1;
    final checkboxExclusiveIds = PurchaseMode.filteredValues
        .map((e) => e.value)
        .toList();

    showDateFilterDialog(
      context: context,
      isGeneratePdf: false,
      initialStartDate: _dateFilterNotifier.value.startDate,
      initialEndDate: _dateFilterNotifier.value.endDate,
      showCheckboxOptions: showPurchaseModeFilter,
      title: 'Purchase Type',
      selectionStrategy: CheckboxSelectionStrategy.exclusiveStrategy(
        checkboxExclusiveIds,
      ),
      checkboxOptions: [
        for (final mode in PurchaseMode.filteredValues)
          CheckboxOption(
            id: mode.value,
            label: mode.label,
            isSelected: _purchaseModeFilterNotifier.value == mode,
          ),
      ],
      onDateFilterChanged: (startDate, endDate) {
        _dateFilterNotifier.value = _dateFilterNotifier.value.copyWith(
          startDate: startDate,
          endDate: endDate,
        );
        _loadData();
        if (!showPurchaseModeFilter) Navigator.pop(context);
      },
      onCheckboxChanged: (options) {
        final selected = options.firstWhereOrNull((o) => o.isSelected);
        if (selected == null) {
          _purchaseModeFilterNotifier.value = null;
        } else {
          PurchaseMode? selectedMode;
          for (final mode in PurchaseMode.filteredValues) {
            if (mode.value == selected.id) selectedMode = mode;
          }
          _purchaseModeFilterNotifier.value = selectedMode;
        }
        _loadData();
      },
      onApplyButtonPressed: (p0, p1, p2) => Navigator.pop(context),
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
                    child: CircularProgressIndicator(color: Color(0xFF8A63FE)),
                  ),
                  loaded:
                      (
                        bookings,
                        _,
                        __,
                        ___,
                        ____,
                        _____,
                        ______,
                        _______,
                        ________,
                        _________,
                      ) {
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
          loaded: (sales, _, __, ___, ____, _____) {
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

  Widget _buildSalesTable(List<SaleEntity> sales) {
    return BlocBuilder<AllSalesBloc, AllSalesState>(
      builder: (context, state) {
        final isPaginating = state.maybeWhen(
          loaded: (_, __, ___, isPaginating, ____, _____) => isPaginating,
          orElse: () => false,
        );

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: sales.length + 1, // +1 for header
          itemBuilder: (context, index) {
            if (index == 0) return _buildTableHeader();
            final itemIndex = index - 1;

            if (itemIndex < sales.length) {
              return _buildSalesTableRow(sales[itemIndex]);
            } else {
              if (isPaginating) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return const SizedBox(height: 20); // Bottom padding
              }
            }
          },
        );
      },
    );
  }

  Widget _buildTable(List<DesktopBookingItemEntity> bookings) {
    return BlocBuilder<AllBookingBloc, AllBookingState>(
      builder: (context, state) {
        final isPaginating = state.maybeWhen(
          loaded:
              (
                _,
                __,
                isPaginating,
                ___,
                ____,
                _____,
                ______,
                _______,
                ________,
                _________,
              ) => isPaginating,
          orElse: () => false,
        );

        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: bookings.length + 1, // +1 for header
          itemBuilder: (context, index) {
            if (index == 0) return _buildTableHeader();
            final itemIndex = index - 1;

            if (itemIndex < bookings.length) {
              return AllBookingsBookingTableRow(booking: bookings[itemIndex]);
            } else {
              // Loading indicator or bottom padding
              if (isPaginating) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return const SizedBox(height: 20);
              }
            }
          },
        );
      },
    );
  }

  Widget _buildTableHeader() => _activeActionTab == 1
      ? const AllBookingsSalesTableHeader()
      : const AllBookingsBookingTableHeader();

  Widget _buildSalesTableRow(SaleEntity sale) =>
      AllBookingsSalesTableRow(sale: sale);
}
