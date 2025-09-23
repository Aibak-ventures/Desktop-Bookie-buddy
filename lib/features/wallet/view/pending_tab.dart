import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_list_tile.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_pendings_grouped_container.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/ledger_simple_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        _fetchData(context);
      },
      child: BlocBuilder<WalletPendingBloc, WalletPendingState>(
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
                onRetry: () => _fetchData(context),
              ),
            ),
            loaded: (walletPending, nextPageUrl, isPaginating, clientId) {
              if (walletPending.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No pendings',
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
                    context.read<WalletPendingBloc>().add(
                          const WalletPendingEvent.loadNextPagePending(),
                        );
                  }
                  return false;
                },
                child: RepaintBoundary(
                  child: ListView.builder(
                    key: const PageStorageKey('pending-tab-list'),
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: walletPending.length,
                    itemBuilder: (context, index) {
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
          );
        },
      ),
    );
  }

  void _fetchData(BuildContext context) {
    final clientId = context.read<ClientBloc>().getSelectedClient()?.id;
    context.read<WalletPendingBloc>().add(
          WalletPendingEvent.loadPending(clientId: clientId),
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
