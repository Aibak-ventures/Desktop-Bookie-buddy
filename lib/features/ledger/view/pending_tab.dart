import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_pendings_grouped_container.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
    onRefresh: () async {
      context.read<LedgerSimpleSummaryCubit>().reset();
      _fetchData(context);
    },
    child: BlocBuilder<WalletPendingBloc, WalletPendingState>(
      builder: (context, state) => state.when(
        loading: () => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 15,
          // Use shimmer for loading
          itemBuilder: (context, index) =>
              const LedgerPendingsListTileShimmer(),
        ),
        error: (error) => Center(
          child: CustomErrorWidget(
            errorText: error,
            onRetry: () => _fetchData(context),
          ),
        ),
        loaded:
            (walletPending, nextPageUrl, isPaginating, clientId, isFirstFetch) {
              if (walletPending.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No pendings',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }

              if (isFirstFetch && walletPending.isNotEmpty) {
                final firstDate = walletPending.first.date;
                _fetchSummary(context, clientId, firstDate);
                log('✅✅ Fetched summary for first date: $firstDate ✅✅');
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<WalletPendingBloc>().add(
                      const WalletPendingEvent.loadNextPagePending(),
                    );
                  }
                  return false;
                },
                child: RepaintBoundary(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: walletPending.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == walletPending.length) {
                        return const LedgerPendingsListTileShimmer();
                      }
                      final groupedData = walletPending[index];

                      return LedgerPendingsGroupedContainer(
                        groupedDate: groupedData.date,
                        pendings: groupedData.pendings,
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
    context.read<WalletPendingBloc>().add(
      WalletPendingEvent.loadPending(clientId: clientId),
    );
    // _fetchSummary(context, clientId);
  }

  void _fetchSummary(BuildContext context, int? clientId, String? date) {
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
      date ?? DateTime.now().format(),
      clientId: clientId,
      force: true,
    );
  }
}
