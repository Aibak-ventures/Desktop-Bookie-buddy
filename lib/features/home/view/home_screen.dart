import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/home/view/widgets/carousel_home.dart';
import 'package:bookie_buddy_web/features/home/view/widgets/home_booking_list_widget.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('Current used domain: $baseUrl ✅');
    final bloc = context.read<DashboardBloc>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: _buildDesktopLayout(context, bloc),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, DashboardBloc bloc) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, bloc),
              const SizedBox(height: 32),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    bloc.add(
                      const DashboardEvent.loadDashboardData(
                        useOldState: true,
                      ),
                    );
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      final (nextPageUrl, isPaginating) =
                          bloc.state.maybeWhen(
                        orElse: () => (null, false),
                        loaded: (_, __, nextPageUrl, isPaginating, ___) =>
                            (nextPageUrl, isPaginating),
                      );

                      if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 200 &&
                          nextPageUrl != null &&
                          !isPaginating) {
                        bloc.add(
                          const DashboardEvent.loadDashboardNextPageData(),
                        );
                      }
                      return false;
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCard(
                            title: 'Overview',
                            child:
                                CarouselHome(data: bloc.carouselResponse),
                          ),
                          const SizedBox(height: 24),
                          _buildCard(
                            title: 'Recent Bookings',
                            child: HomeBookingListWidget(),
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
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

  Widget _buildHeader(BuildContext context, DashboardBloc bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<UserCubit, UserModel?>(
          builder: (context, user) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Hello ',
                    children: [
                      TextSpan(
                        text: '${user?.userFullName ?? 'Owner'}!',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF667eea),
                        ),
                      ),
                    ],
                  ),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Have a nice day',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            );
          },
        ),
        IconButton(
          onPressed: () {
            bloc.add(
              const DashboardEvent.loadDashboardData(useOldState: true),
            );
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
