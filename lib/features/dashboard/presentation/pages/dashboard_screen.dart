import 'package:bookie_buddy_web/core/constants/endpoints/baseurl.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_carousel_entity/desktop_dashboard_carousel_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/widgets/carousel_dashboard.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/widgets/dashboard_bookings_columns.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/widgets/dashboard_card.dart';
import 'package:bookie_buddy_web/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart'
    as all_booking;
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  final void Function(String statusTab)? onNavigateToBookings;

  const DashboardScreen({super.key, this.onNavigateToBookings});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<all_booking.AllBookingBloc>().stream.listen((state) {
        state.maybeWhen(
          loaded:
              (_, __, ___, ____, _____, ______, _______, ________, _________) {
                context.read<DashboardBloc>().add(
                  const DashboardEvent.loadDashboardData(useOldState: true),
                );
              },
          orElse: () {},
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Current used domain: $baseUrl ✅');
    final bloc = context.read<DashboardBloc>();

    return BlocListener<UserCubit, UserEntity?>(
      listener: (context, userState) {
        if (userState != null) {
          bloc.add(const DashboardEvent.loadDashboardData(useOldState: true));
        }
      },
      child: BlocListener<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
        listener: (context, drawerState) {
          if (drawerState.isOpen && drawerState.selectedBookingId != null) {
            context.read<BookingDetailsBloc>().add(
              BookingDetailsEvent.fetchBookingDetails(
                drawerState.selectedBookingId!,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Stack(
            children: [
              _buildDesktopLayout(bloc),
              const BookingDetailsDrawer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(DashboardBloc bloc) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: 24),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(
                      const DashboardEvent.loadDashboardData(useOldState: true),
                    );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardCard(
                          title: 'Overview',
                          child: BlocBuilder<DashboardBloc, DashboardState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                loaded: (
                                  _,
                                  __,
                                  carouselData,
                                  ___,
                                  ____,
                                  _____,
                                  ______,
                                ) =>
                                    SizedBox(
                                      height: 120,
                                      child: CarouselDashboard(
                                        data: carouselData,
                                        onNavigateToBookings:
                                            widget.onNavigateToBookings,
                                      ),
                                    ),
                                orElse: () => SizedBox(
                                  height: 120,
                                  child: CarouselDashboard(
                                    data:
                                        DesktopDashboardCarouselEntity.empty(),
                                    onNavigateToBookings:
                                        widget.onNavigateToBookings,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Recent Bookings',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const DashboardBookingsColumns(),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
