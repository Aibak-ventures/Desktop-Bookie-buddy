import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/all_booking/view/all_booking_screen.dart';
import 'package:bookie_buddy_web/features/completed_bookings/view/completed_bookings_screen.dart';
import 'package:bookie_buddy_web/features/home/models/carousel_data_model/carousel_data_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselHome extends StatelessWidget {
  final CarouselDataModel data;
  const CarouselHome({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || 
        Theme.of(context).platform == TargetPlatform.windows ||
        Theme.of(context).platform == TargetPlatform.macOS ||
        Theme.of(context).platform == TargetPlatform.linux;

    return isDesktop 
        ? _buildDesktopCarousel(context)
        : _buildMobileCarousel(context);
  }

  Widget _buildDesktopCarousel(BuildContext context) {
    return Container(
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: _buildDesktopCard(
              context,
              title: 'Upcoming',
              value: data.upComingCount.toString(),
              gradient: [
                const Color(0xFF4C0FFF).withValues(alpha: 0.9),
                const Color(0xFF8A63FE).withValues(alpha: 0.9),
              ],
              icon: Icons.schedule,
              onTap: () => context.push(AllBookingScreen()),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildDesktopCard(
              context,
              title: 'Completed',
              value: data.completedCount.toString(),
              gradient: [
                const Color(0xFF015DFF).withValues(alpha: 0.9),
                const Color(0xFF05ADFF).withValues(alpha: 0.9),
              ],
              icon: Icons.check_circle,
              onTap: () => context.push(CompletedBookingsScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCard(
    BuildContext context, {
    required String title,
    required String value,
    required List<Color> gradient,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 32,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_outward,
                  color: Colors.white,
                  size: 20,
                ),
              ).onTap(onTap),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileCarousel(BuildContext context) {
    return SizedBox(
      height: context.mediaQueryHeight(0.24),
      width: context.mediaQueryWidth(1),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          viewportFraction: context.isMobile ? 0.75 : 0.5,
          padEnds: false,
        ),
        items: [
          CarouselCard(
            title: 'Upcoming',
            value: data.upComingCount.toString(),
            gradient: [
              const Color(0xFF4C0FFF).withValues(alpha: 0.9),
              const Color(0xFF8A63FE).withValues(alpha: 0.9),
            ],
            onTap: () => context.push(AllBookingScreen()),
          ),
          CarouselCard(
            title: 'Completed',
            value: data.completedCount.toString(),
            gradient: [
              const Color(0xFF015DFF).withValues(alpha: 0.9),
              const Color(0xFF05ADFF).withValues(alpha: 0.9),
            ],
            onTap: () => context.push(CompletedBookingsScreen()),
          ),
        ],
      ),
    );
  }
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    required this.title,
    required this.value,
    required this.onTap,
    required this.gradient,
    super.key,
  });
  final String title;
  final String value;
  final List<Color> gradient;
  final VoidCallback onTap;

  final double firstHeight = 200.0;
  final double secondHeight = 240.0;
  @override
  Widget build(BuildContext context) {
    final width = context.mediaQueryWidth(0.8);
    const circleColor = Color.fromARGB(255, 166, 166, 166);
    return Stack(
      children: [
        // Main container with clipped background circles
        Container(
          width: width,
          margin: 10.paddingOnly(right: true),
          child: ClipRRect(
            borderRadius: 20.radiusBorder,
            child: Stack(
              children: [
                // Bottom circle
                Positioned(
                  left: -65,
                  bottom: -140,
                  child: Container(
                    height: firstHeight,
                    width: firstHeight,
                    decoration: const BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                // Top circle
                Positioned(
                  right: -120,
                  top: -100,
                  child: Container(
                    height: secondHeight,
                    width: secondHeight,
                    decoration: const BoxDecoration(
                      color: circleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Main content container
                Container(
                  width: width,
                  padding: 20.padding,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: gradient,
                      stops: const [0.0, 1.0],
                    ),
                    borderRadius: 20.radiusBorder,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "My profile" label
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      16.height,
                      // Business/User Name
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Container(
                    padding: 18.padding,
                    decoration: BoxDecoration(
                      color: AppColors.purpleLight.withValues(alpha: 0.15),
                      borderRadius: 15.radiusBorder,
                    ),
                    child: Icon(
                      Icons.arrow_outward_outlined,
                      color: AppColors.white,
                      size: 24.sp,
                    ),
                  ).onTap(onTap),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
