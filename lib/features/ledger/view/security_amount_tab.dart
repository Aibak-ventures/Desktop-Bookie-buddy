import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_security_amount_list_tile.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_security_amounts_grouped_container.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityAmountTab extends StatelessWidget {
  const SecurityAmountTab({super.key});

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<LedgerSimpleSummaryCubit>().reset();
          _fetchData(context);
        },
        child:
            BlocBuilder<LedgerSecurityAmountsBloc, LedgerSecurityAmountsState>(
          builder: (context, state) => state.when(
            loading: () => ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 15,
              // Use shimmer for loading
              itemBuilder: (context, index) =>
                  const LedgerSecurityAmountListTileShimmer(),
            ),
            error: (error) => Center(
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () {
                  _fetchData(context);
                },
              ),
            ),
            loaded: (
              ledgerSecurityAmounts,
              nextPageUrl,
              isPaginating,
              clientId,
              isFirstFetch,
            ) {
              if (ledgerSecurityAmounts.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No data found',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }

              if (isFirstFetch && ledgerSecurityAmounts.isNotEmpty) {
                final firstDate = ledgerSecurityAmounts.first.date;
                _fetchSummary(context, clientId, firstDate);
                log('✅✅ Fetched summary for first date: $firstDate ✅✅');
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
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount:
                        ledgerSecurityAmounts.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == ledgerSecurityAmounts.length) {
                        return const LedgerSecurityAmountListTileShimmer();
                      }
                      final securityAmountModel = ledgerSecurityAmounts[index];

                      return LedgerSecurityAmountsGroupedContainer(
                        groupedDate: securityAmountModel.date,
                        securityAmounts: securityAmountModel.items,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );

  void _fetchData(BuildContext context) {
    final clientId = context.read<ClientCubit>().getSelectedClient()?.id;
    context.read<LedgerSecurityAmountsBloc>().add(
          LedgerSecurityAmountsEvent.loadSecurityAmounts(clientId: clientId),
        );
  }

  void _fetchSummary(BuildContext context, int? clientId, String? date) {
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
          date ?? DateTime.now().format(),
          clientId: clientId,
          force: true,
        );
  }
}
