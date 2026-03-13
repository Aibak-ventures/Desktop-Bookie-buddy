import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_month_and_year_picker.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_analytics_model/staff_analytics_model.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_analytics_card.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_analytics_indicator.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_analytics_bloc/staff_analytics_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../models/staff_analytics_model/staff_analytics_model.dart';

class StaffAnalyticsPieChartSection extends StatefulWidget {
  final StaffAnalyticsModel staffReport;
  const StaffAnalyticsPieChartSection({super.key, required this.staffReport});

  @override
  State<StaffAnalyticsPieChartSection> createState() =>
      _StaffAnalyticsPieChartSectionState();
}

class _StaffAnalyticsPieChartSectionState
    extends State<StaffAnalyticsPieChartSection> {
  bool get hasPending => widget.staffReport.totalPendingAmount > 0;
  int touchedIndex = -1;
  List<PieChartSectionData> showingSections() =>
      List.generate(widget.staffReport.totalAmount > 0 ? 2 : 1, (
        i,
      ) {
        final isTouched = i == touchedIndex;
        final fontSize = isTouched ? 25.0 : 16.0;
        final radius = isTouched ? 60.0 : 50.0;
        const shadows = [Shadow(blurRadius: 2)];

        if (widget.staffReport.totalAmount == 0) {
          return PieChartSectionData(
            color: AppColors.grey300,
            value: 1,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              shadows: shadows,
            ),
          );
        }

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: AppColors.purple,
              value: widget.staffReport.totalBookingsAmount.toDouble(),
              title:
                  '${widget.staffReport.totalBookingsAmount.percentageOf(widget.staffReport.totalAmount)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                shadows: shadows,
              ),
            );
          case 1:
            return PieChartSectionData(
              color: AppColors.aquamarineMedium,
              value: widget.staffReport.totalSalesAmount.toDouble(),
              title:
                  '${widget.staffReport.totalSalesAmount.percentageOf(widget.staffReport.totalAmount)}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                shadows: shadows,
              ),
            );
          // case 2:
          //   return PieChartSectionData(
          //     color: AppColors.green2,
          //     value: 3000,
          //     radius: radius,
          //     titleStyle: TextStyle(
          //       fontSize: fontSize,
          //       fontWeight: FontWeight.bold,
          //       color: AppColors.white,
          //       shadows: shadows,
          //     ),
          //   );

          default:
            throw Error();
        }
      });

  @override
  Widget build(BuildContext context) {
    final isPerformancePositive =
        !widget.staffReport.performancePercent.isNegative;
    return StaffAnalyticsCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            _buildDateChangeSection(context),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  isPerformancePositive
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: isPerformancePositive
                      ? AppColors.green2
                      : AppColors.redTomato,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${widget.staffReport.performancePercent.abs()}%',
                        style: TextStyle(
                          color: isPerformancePositive
                              ? AppColors.green2
                              : AppColors.redTomato,
                        ),
                      ),
                      const TextSpan(text: ' from last month'),
                    ],
                    style: TextStyle(color: AppColors.grey),
                  ),
                ),
              ],
            ),
            40.height,
            // Chart
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        sections: showingSections(),
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            setState(() {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                touchedIndex = -1;
                                return;
                              }
                              touchedIndex = pieTouchResponse
                                  .touchedSection!.touchedSectionIndex;
                            });
                          },
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,
                        centerSpaceRadius: 70,
                      ),
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.linearToEaseOut,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.staffReport.totalAmount.toCurrency(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Text('Total'),
                    ],
                  ),
                ],
              ),
            ),
            35.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StaffAnalyticsIndicator(
                  color: Colors.deepPurple,
                  title: 'Bookings',
                  amount: widget.staffReport.totalBookingsAmount,
                ),
                StaffAnalyticsIndicator(
                  color: AppColors.aquamarineMedium,
                  title: 'Sales',
                  amount: widget.staffReport.totalSalesAmount,
                ),
                // if (hasPending)
                //   StaffAnalyticsIndicator(
                //     color: Colors.orange,
                //     title: 'Pendings',
                //     amount: widget.staffReport.totalPendingAmount,
                //   ),
              ],
            ),
            const SizedBox(height: 16),
            // Actions
            // Row(
            //   children: [
            //     ElevatedButton.icon(
            //       onPressed: () {
            // !TODO: Implement screenshot sharing
            //       },
            //       icon: const Icon(Icons.share),
            //       label: const Text('Share'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Row _buildDateChangeSection(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _onPressPreviousMonth(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          Text(
            '${widget.staffReport.monthName} ${widget.staffReport.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ).onTapInkWell(() {
            showMonthAndYearPicker(
              context: context,
              initialDate: DateTime(
                widget.staffReport.year,
                widget.staffReport.month.number,
              ),
              onDateSelected: (selectedMonth, selectedYear) {
                context.read<StaffAnalyticsBloc>().add(
                      StaffAnalyticsEvent.getStaffAnalytics(
                        staffId: widget.staffReport.staffId,
                        year: selectedYear,
                        month: selectedMonth,
                      ),
                    );
              },
            );
          }),
          IconButton(
            onPressed: () {
              _onPressNextMonth(context);
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      );

  void _onPressPreviousMonth(BuildContext context) {
    final newMonth = widget.staffReport.month.number - 1;
    final month = newMonth < 1 ? 12 : newMonth;
    final year =
        newMonth < 1 ? widget.staffReport.year - 1 : widget.staffReport.year;
    context.read<StaffAnalyticsBloc>().add(
          StaffAnalyticsEvent.getStaffAnalytics(
            staffId: widget.staffReport.staffId,
            year: year,
            month: month,
          ),
        );
  }

  void _onPressNextMonth(BuildContext context) {
    final newMonth = widget.staffReport.month.number + 1;
    final month = newMonth > 12 ? 1 : newMonth;
    final year =
        newMonth > 12 ? widget.staffReport.year + 1 : widget.staffReport.year;
    context.read<StaffAnalyticsBloc>().add(
          StaffAnalyticsEvent.getStaffAnalytics(
            staffId: widget.staffReport.staffId,
            year: year,
            month: month,
          ),
        );
  }
}
