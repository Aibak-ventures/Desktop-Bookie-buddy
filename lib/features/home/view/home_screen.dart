import 'package:bookie_buddy_web/core/api/baseurl.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
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
      backgroundColor: ResponsiveHelper.isMobile(context) 
          ? null 
          : const Color(0xFFF5F7FA),
      body: ResponsiveWidget(
        mobile: _buildMobileLayout(context, bloc),
        tablet: _buildTabletLayout(context, bloc),
        desktop: _buildDesktopLayout(context, bloc),
        largeDesktop: _buildLargeDesktopLayout(context, bloc),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, DashboardBloc bloc) {
    return _buildResponsiveLayout(
      context, 
      bloc,
      containerPadding: const EdgeInsets.all(24),
      titleFontSize: 32,
      headerSpacing: 32,
      cardSpacing: 24,
      maxContentWidth: 1200,
    );
  }

  Widget _buildTabletLayout(BuildContext context, DashboardBloc bloc) {
    return _buildResponsiveLayout(
      context, 
      bloc,
      containerPadding: const EdgeInsets.all(20),
      titleFontSize: 28,
      headerSpacing: 24,
      cardSpacing: 20,
      maxContentWidth: 800,
    );
  }

  Widget _buildLargeDesktopLayout(BuildContext context, DashboardBloc bloc) {
    return _buildResponsiveLayout(
      context, 
      bloc,
      containerPadding: const EdgeInsets.all(32),
      titleFontSize: 36,
      headerSpacing: 40,
      cardSpacing: 32,
      maxContentWidth: 1400,
    );
  }

  Widget _buildResponsiveLayout(
    BuildContext context, 
    DashboardBloc bloc, {
    required EdgeInsets containerPadding,
    required double titleFontSize,
    required double headerSpacing,
    required double cardSpacing,
    required double maxContentWidth,
  }) {
    return Container(
      height: double.infinity,
      padding: containerPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header Section
              _buildResponsiveHeader(context, bloc, titleFontSize),
              SizedBox(height: headerSpacing),
              // Scrollable Content Area
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () async {
                    bloc.add(const DashboardEvent.loadDashboardData());
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      final (nextPageUrl, isPaginating) = bloc.state.maybeWhen(
                        orElse: () => (null, false),
                        loaded: (bookings, carouselResponse, nextPageUrl, isPaginating) =>
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
                          // Carousel Section
                          _buildResponsiveCard(
                            context,
                            title: 'Overview',
                            child: CarouselHome(data: bloc.carouselResponse),
                            bloc: bloc,
                          ),
                          SizedBox(height: cardSpacing),
                          // Bookings Section
                          _buildResponsiveCard(
                            context,
                            title: 'Recent Bookings',
                            child: HomeBookingListWidget(),
                          ),
                          // Add bottom padding for better scrolling
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

  Widget _buildResponsiveHeader(BuildContext context, DashboardBloc bloc, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Welcome Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<UserCubit, UserModel?>(
                builder: (context, user) {
                  return Text.rich(
                    TextSpan(
                      text: 'Hello ',
                      children: [
                        TextSpan(
                          text: '${user?.userFullName ?? 'Owner'}!',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF667eea),
                          ),
                        )
                      ],
                    ),
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1F2937),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Have a nice day',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 14,
                    tablet: 16,
                    desktop: 16,
                    largeDesktop: 18,
                  ),
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        // Refresh Button
        IconButton(
          onPressed: () {
            bloc.add(const DashboardEvent.loadDashboardData());
          },
          icon: const Icon(Icons.refresh),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF6B7280),
            padding: EdgeInsets.all(
              ResponsiveHelper.getValue(
                context,
                mobile: 8.0,
                tablet: 10.0,
                desktop: 12.0,
                largeDesktop: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveCard(
    BuildContext context, {
    required String title,
    required Widget child,
    DashboardBloc? bloc,
  }) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) {
        return bloc?.previousCarousel != bloc?.carouselResponse;
      },
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.getValue(
                context,
                mobile: 12.0,
                tablet: 14.0,
                desktop: 16.0,
                largeDesktop: 18.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: ResponsiveHelper.getValue(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 10.0,
                  largeDesktop: 12.0,
                ),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: ResponsiveHelper.getPadding(
            context,
            mobile: const EdgeInsets.all(16),
            tablet: const EdgeInsets.all(18),
            desktop: const EdgeInsets.all(20),
            largeDesktop: const EdgeInsets.all(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 18,
                    tablet: 19,
                    desktop: 20,
                    largeDesktop: 22,
                  ),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 12,
                  tablet: 14,
                  desktop: 16,
                  largeDesktop: 18,
                ),
              ),
              child,
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, DashboardBloc bloc) {
    return SafeArea(
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          bloc.add(const DashboardEvent.loadDashboardData());
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            final (nextPageUrl, isPaginating) = bloc.state.maybeWhen(
              orElse: () => (null, false),
              loaded: (bookings, carouselResponse, nextPageUrl, isPaginating) =>
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
          child: ListView(
            padding: ResponsiveHelper.getPadding(
              context,
              mobile: const EdgeInsets.all(16),
              tablet: const EdgeInsets.all(16),
              desktop: const EdgeInsets.all(16),
              largeDesktop: const EdgeInsets.all(16),
            ),
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<UserCubit, UserModel?>(
                          builder: (context, user) {
                            return Text.rich(
                              TextSpan(
                                text: 'Hello ',
                                children: [
                                  TextSpan(
                                    text: '${user?.userFullName ?? 'Owner'}!',
                                    style: const TextStyle(
                                      color: AppColors.purple,
                                    ),
                                  )
                                ],
                              ),
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getFontSize(
                                  context,
                                  mobile: 24,
                                  tablet: 26,
                                  desktop: 28,
                                  largeDesktop: 30,
                                ),
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: ResponsiveHelper.getSpacing(context, mobile: 8, tablet: 8, desktop: 8, largeDesktop: 8)),
                        Text(
                          'Have a nice day',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getFontSize(
                              context,
                              mobile: 14,
                              tablet: 15,
                              desktop: 16,
                              largeDesktop: 16,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveHelper.getSpacing(context, mobile: 15, tablet: 18, desktop: 20, largeDesktop: 24)),
              
              // Carousel Section
              BlocBuilder<DashboardBloc, DashboardState>(
                buildWhen: (previous, current) {
                  return bloc.previousCarousel != bloc.carouselResponse;
                },
                builder: (context, state) {
                  return CarouselHome(
                    data: bloc.carouselResponse,
                  );
                },
              ),
              SizedBox(height: ResponsiveHelper.getSpacing(context, mobile: 20, tablet: 22, desktop: 24, largeDesktop: 28)),
              
              // Bookings Section
              HomeBookingListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
