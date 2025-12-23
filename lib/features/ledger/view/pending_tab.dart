import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<WalletPendingBloc, WalletPendingState>(
      builder: (context, state) {
        return state.when(
          loading: () => ListView.builder(
            itemCount: 10,
            itemBuilder: (_, __) => const LedgerPendingsListTileShimmer(),
          ),

          error: (error) => Center(
            child: CustomErrorWidget(
              errorText: error,
              onRetry: () => _fetchData(context),
            ),
          ),

          loaded: (
            walletPending,
            nextPageUrl,
            isPaginating,
            clientId,
            isFirstFetch,
          ) {
            if (walletPending.isEmpty) {
              return const EmptyDataWidget(
                message: 'No pendings',
                isShowIcon: false,
              );
            }

            if (isFirstFetch && walletPending.isNotEmpty) {
              _fetchSummary(context, clientId, walletPending.first.date);
            }

            return Scrollbar(
              thumbVisibility: true,
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 300 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<WalletPendingBloc>().add(
                          const WalletPendingEvent.loadNextPagePending(),
                        );
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  itemCount: walletPending.length + (isPaginating ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == walletPending.length) {
                      return const LedgerPendingsListTileShimmer();
                    }

                    final groupedData = walletPending[index];

                    /// 🔴 IMPORTANT FIX
                    /// If API gives only date-level data
                    if (groupedData.pendings.isEmpty) {
                      return _DateOnlyPendingTile(
                        date: groupedData.date,
                        total: groupedData.total,
                      );
                    }

                    /// Normal detailed view
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
    );
  }

  void _fetchData(BuildContext context) {
    final clientId = context.read<ClientCubit>().getSelectedClient()?.id;
    context.read<WalletPendingBloc>().add(
          WalletPendingEvent.loadPending(clientId: clientId),
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
class _DateOnlyPendingTile extends StatelessWidget {
  final String date;
  final num total;

  const _DateOnlyPendingTile({
    required this.date,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(
          date.getDateHeading(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text('Pending total for the day'),
        trailing: Text(
          total.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
