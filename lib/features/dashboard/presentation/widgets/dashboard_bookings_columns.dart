import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/core/common/widgets/no_result_found_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Two-column booking list (Upcoming + Returns) for [DashboardScreen].
/// Shows shimmer while loading, grouped date sections when loaded.
/// Triggers next-page load when either column is scrolled to its bottom.
class DashboardBookingsColumns extends StatefulWidget {
  const DashboardBookingsColumns({super.key});

  @override
  State<DashboardBookingsColumns> createState() =>
      _DashboardBookingsColumnsState();
}

class _DashboardBookingsColumnsState extends State<DashboardBookingsColumns> {
  final _upcomingScrollController = ScrollController();
  final _returnsScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _upcomingScrollController.addListener(_onScroll);
    _returnsScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final upcoming = _upcomingScrollController;
    final returns = _returnsScrollController;

    final nearBottom =
        (upcoming.hasClients &&
            upcoming.position.pixels >=
                upcoming.position.maxScrollExtent - 200) ||
        (returns.hasClients &&
            returns.position.pixels >=
                returns.position.maxScrollExtent - 200);

    if (!nearBottom) return;
    _tryLoadNextPage();
  }

  /// Called after each loaded state to auto-load more data when the content
  /// doesn't fill the viewport (no scroll events would fire otherwise).
  void _checkAndLoadIfContentFitsViewport() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final upcoming = _upcomingScrollController;
      final returns = _returnsScrollController;

      final upcomingFits =
          upcoming.hasClients && upcoming.position.maxScrollExtent == 0;
      final returnsFits =
          returns.hasClients && returns.position.maxScrollExtent == 0;

      if (upcomingFits || returnsFits) {
        _tryLoadNextPage();
      }
    });
  }

  void _tryLoadNextPage() {
    final bloc = context.read<DashboardBloc>();
    bloc.state.maybeWhen(
      loaded: (_, __, ___, nextPageUrl, ____, _____, isPaginating) {
        if (nextPageUrl != null && !isPaginating) {
          bloc.add(const DashboardEvent.loadDashboardNextPageData());
        }
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _upcomingScrollController.dispose();
    _returnsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (_, __, ___, nextPageUrl, ____, _____, isPaginating) {
              if (nextPageUrl != null && !isPaginating) {
                _checkAndLoadIfContentFitsViewport();
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ShimmerColumn(
                    color: const Color(0xFF667eea),
                    title: 'Upcoming Bookings',
                    icon: Icons.schedule,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _ShimmerColumn(
                    color: const Color(0xFFff8a00),
                    title: 'Returns Booking',
                    icon: Icons.assignment_return,
                  ),
                ),
              ],
            ),
            loaded: (
              upcomingGrouped,
              returnsGrouped,
              carouselData,
              nextPageUrl,
              __,
              ___,
              isPaginating,
            ) {
              final upcomingCount = carouselData.upcomingCount;
              final returnsCount = returnsGrouped.values.fold<int>(
                0,
                (sum, list) => sum + list.length,
              );

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _BookingColumn(
                      title: 'Upcoming Bookings',
                      icon: Icons.schedule,
                      groupedBookings: upcomingGrouped,
                      totalCount: upcomingCount,
                      color: const Color(0xFF667eea),
                      useReturnDate: false,
                      scrollController: _upcomingScrollController,
                      isPaginating: isPaginating,
                      hasMore: nextPageUrl != null,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: _BookingColumn(
                      title: 'Returns Booking',
                      icon: Icons.assignment_return,
                      groupedBookings: returnsGrouped,
                      totalCount: returnsCount,
                      color: const Color(0xFFff8a00),
                      useReturnDate: true,
                      scrollController: _returnsScrollController,
                      isPaginating: isPaginating,
                      hasMore: nextPageUrl != null,
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _ShimmerColumn extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;

  const _ShimmerColumn({
    required this.color,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: BookingListShimmer(itemCount: 4, alwaysScrollable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingColumn extends StatelessWidget {
  final String title;
  final IconData icon;
  final Map<String, List<BookingEntity>> groupedBookings;
  final int totalCount;
  final Color color;
  final bool useReturnDate;
  final ScrollController scrollController;
  final bool isPaginating;
  final bool hasMore;

  const _BookingColumn({
    required this.title,
    required this.icon,
    required this.groupedBookings,
    required this.totalCount,
    required this.color,
    required this.useReturnDate,
    required this.scrollController,
    required this.isPaginating,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$totalCount',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (totalCount == 0)
            const Expanded(
              child: Center(
                child: NoResultFoundAnimationWidget(isScrollable: false),
              ),
            )
          else
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                children: [
                  if (groupedBookings['today']?.isNotEmpty == true) ...[
                    _DateSection(
                      title: 'Today',
                      bookings: groupedBookings['today']!,
                      color: Colors.red,
                      useReturnDate: useReturnDate,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (groupedBookings['tomorrow']?.isNotEmpty == true) ...[
                    _DateSection(
                      title: 'Tomorrow',
                      bookings: groupedBookings['tomorrow']!,
                      color: Colors.orange,
                      useReturnDate: useReturnDate,
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (groupedBookings['upcoming']?.isNotEmpty == true)
                    _DateSection(
                      title: 'Upcoming',
                      bookings: groupedBookings['upcoming']!,
                      color: Colors.blue,
                      useReturnDate: useReturnDate,
                    ),
                  // Pagination footer
                  if (isPaginating)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  else if (!hasMore && totalCount > 0)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          'All caught up',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DateSection extends StatelessWidget {
  final String title;
  final List<BookingEntity> bookings;
  final Color color;
  final bool useReturnDate;

  const _DateSection({
    required this.title,
    required this.bookings,
    required this.color,
    required this.useReturnDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${bookings.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...bookings.map(
          (booking) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: BookingCard(
              booking: booking,
              useReturnDate: useReturnDate,
              onTap: () {
                context.read<BookingDetailsDrawerCubit>().openDrawer(
                  booking.id!,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
