import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_list_tile.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/ledger_simple_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SecurityAmountTab extends StatelessWidget {
  const SecurityAmountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        _fetchData(context);
      },
      child: BlocBuilder<LedgerSecurityAmountsBloc, LedgerSecurityAmountsState>(
        builder: (context, state) {
          return state.when(
            loading: () => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 15,
              itemBuilder: (context, index) {
                return const LedgerListTileShimmer(); // Use shimmer for loading
              },
            ),
            error: (error) => Center(
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () {
                  _fetchData(context);
                },
              ),
            ),
            loaded:
                (ledgerSecurityAmounts, nextPageUrl, isPaginating, clientId) {
              if (ledgerSecurityAmounts.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No data found',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<LedgerSecurityAmountsBloc>().add(
                          const LedgerSecurityAmountsEvent
                              .loadNextPageSecurityAmounts(),
                        );
                  }
                  return false;
                },
                child: RepaintBoundary(
                  child: ListView.builder(
                    key: const PageStorageKey('security-amount-tab-list'),
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: ledgerSecurityAmounts.length,
                    itemBuilder: (context, index) {
                      final securityAmountModel = ledgerSecurityAmounts[index];

                      final date =
                          securityAmountModel.bookingDate.parseToDateTime();

                      return LedgerListTile(
                        onTap: () {
                          context.push(BookingDetailsScreen(
                            bookingId: securityAmountModel.bookingId,
                          ));
                        },
                        icon: Icon(
                          LucideIcons.shieldUser,
                          size: 28.sp,
                        ),
                        content: Column(
                          children: [
                            Text(
                              securityAmountModel.clientName,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Booking date: ',
                                children: [
                                  TextSpan(
                                    text: date.format(),
                                    style: TextStyle(
                                      color: AppColors.black.lighten(0.2),
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.grey,
                                ),
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        amount: securityAmountModel.securityAmount,
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _fetchData(BuildContext context) {
    final clientId = context.read<ClientBloc>().getSelectedClient()?.id;
    context.read<LedgerSecurityAmountsBloc>().add(
          LedgerSecurityAmountsEvent.loadSecurityAmounts(clientId: clientId),
        );
    _fetchSummary(context, clientId);
  }

  void _fetchSummary(BuildContext context, int? clientId) {
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
          DateTime.now().format(),
          clientId: clientId,
          force: true,
        );
  }
}
