import 'package:bookie_buddy_web/core/route/app_routes.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_analytics_model/staff_analytics_model.dart';
// import 'package:bookie_buddy_web/features/staff/models/staff_analytics_model/staff_analytics_model.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_analytics_card.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_analytics_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StaffAnalyticsCountSection extends StatelessWidget {
  const StaffAnalyticsCountSection({super.key, required this.staffReport});
  final StaffAnalyticsModel staffReport;
  @override
  Widget build(BuildContext context) => StaffAnalyticsCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StaffAnalyticsTile(
                title: 'Bookings',
                count: staffReport.totalBookingsCount,
                onTap: () {
                  _pushBookings(context);
                },
              ),
              const Divider(height: 0.5),
              StaffAnalyticsTile(
                title: 'Sales',
                count: staffReport.totalSalesCount,
                onTap: () {
                  _pushSales(context);
                },
              ),
              // if (staffReport.totalPendingsCount > 0) ...[
              //   const Divider(height: 0.5),
              //   StaffAnalyticsTile(
              //     title: 'Pendings',
              //     count: staffReport.totalPendingsCount,
              //     onTap: () {
              //       _pushBookings(context);
              //     },
              //   ),
              // ],
            ],
          ),
        ),
      );

  void _pushSales(BuildContext context) {
    context.pushNamed(
      AppRoutes.staffAnalyticsSales.name,
      pathParameters: {'id': staffReport.staffId.toString()},
      queryParameters: {'year': staffReport.year.toString()},
      extra: staffReport.month,
    );
  }

  void _pushBookings(BuildContext context) {
    context.pushNamed(
      AppRoutes.staffAnalyticsBookings.name,
      pathParameters: {'id': staffReport.staffId.toString()},
      queryParameters: {'year': staffReport.year.toString()},
      extra: staffReport.month,
    );
  }
}
