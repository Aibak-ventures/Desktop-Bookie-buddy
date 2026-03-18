import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/route/app_routes.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_card.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_analytics_sales_bloc/staff_analytics_sales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StaffAnalyticsSalesScreen extends StatelessWidget {
  const StaffAnalyticsSalesScreen({
    super.key,
    required this.month,
    required this.staffId,
    required this.year,
  });
  final Month month;
  final int staffId;
  final int year;
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('${month.value} Sales')),
        body: Padding(
          padding: 12.padding,
          child: BlocBuilder<StaffAnalyticsSalesBloc, StaffAnalyticsSalesState>(
            builder: (context, state) => state.when(
              loading: () => ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => const SalesCardShimmer(),
              ),
              loaded: (sales, nextPageUrl, isPaginating, _1, _2, _3) =>
                  RefreshIndicator.adaptive(
                onRefresh: () async => _fetchData(context),
                child: sales.isEmpty
                    ? const EmptyDataWidget(
                        message: 'No sales found for this month',
                        isScrollable: true,
                        isShowIcon: false,
                        height: 0.75,
                      )
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (!isPaginating &&
                              scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 100) {
                            context.read<StaffAnalyticsSalesBloc>().add(
                                  const StaffAnalyticsSalesEvent
                                      .loadNextPageSales(),
                                );
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: sales.length + (isPaginating ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= sales.length) {
                              return const BookingCardShimmer();
                            }
                            final sale = sales[index];
                            return SalesCard(
                              sale: sale,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.saleDetails.name,
                                  pathParameters: {'id': sale.id.toString()},
                                );
                              },
                            );
                          },
                        ),
                      ),
              ),
              error: (message) => CustomErrorWidget(
                errorText: message,
                onRetry: () {
                  _fetchData(context);
                },
              ),
            ),
          ),
        ),
      );

  void _fetchData(BuildContext context) {
    context.read<StaffAnalyticsSalesBloc>().add(
          StaffAnalyticsSalesEvent.loadSales(
            staffId: staffId,
            month: month.number,
            year: year,
          ),
        );
  }
}
