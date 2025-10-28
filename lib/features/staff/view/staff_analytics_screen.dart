import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/premium_badge.dart';
import 'package:bookie_buddy_web/features/staff/staff_analytics_model/staff_analytics_model.dart';
// import 'package:bookie_buddy_web/features/staff/models/staff_analytics_model/staff_analytics_model.dart';
import 'package:bookie_buddy_web/features/staff/view/widgets/staff_analytics_count_section.dart';
import 'package:bookie_buddy_web/features/staff/view/widgets/staff_analytics_pie_chart_section.dart';
import 'package:bookie_buddy_web/features/staff/view_model/bloc_staff_analytics/staff_analytics_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StaffAnalyticsScreen extends StatelessWidget {
  final int staffId;
  final String staffName;
  const StaffAnalyticsScreen({
    super.key,
    required this.staffId,
    required this.staffName,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('${staffName} Analytics'),
      actions: const [PremiumBadge(needOnTap: true)],
    ),
    body: BlocBuilder<StaffAnalyticsBloc, StaffAnalyticsState>(
      builder: (context, state) => state.when(
        error: (message, month, year) => CustomErrorWidget(
          errorText: message,
          onRetry: () {
            final now = DateTime.now();
            context.read<StaffAnalyticsBloc>().add(
              StaffAnalyticsEvent.getStaffAnalytics(
                staffId: staffId,
                month: month ?? now.month,
                year: year ?? now.year,
              ),
            );
          },
        ),
        // loading: () => const Center(child: CircularProgressIndicator()),
        loading: (year, monthNumber) {
          final month = Month.fromInt(monthNumber);
          final staffReport = StaffAnalyticsModel(
            staffId: staffId,
            staffName: staffName,
            year: year,
            month: month,
            monthName: month.name.capitalizeFirstLetter(),
            totalBookingsCount: 0,
            totalSalesCount: 0,
            totalPendingsCount: 0,
            totalBookingsAmount: 0,
            totalSalesAmount: 0,
            totalPendingAmount: 0,
            totalAmount: 0,
            performancePercent: 0,
          );
          return _buildBody(staffReport);
        },
        loaded: (staffReport) => _buildBody(staffReport),
      ),
    ),
  );

  SingleChildScrollView _buildBody(StaffAnalyticsModel staffReport) =>
      SingleChildScrollView(
        padding: 24.padding,
        child: Column(
          children: [
            StaffAnalyticsPieChartSection(staffReport: staffReport),
            20.height,
            StaffAnalyticsCountSection(staffReport: staffReport),
          ],
        ),
      );
}
