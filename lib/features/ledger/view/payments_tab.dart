import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_sized_box.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_payments_summary_model/ledger_payments_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_payment_group_container.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_payments/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTab extends StatefulWidget {
  const PaymentsTab({super.key});

  @override
  State<PaymentsTab> createState() => _PaymentsTabState();
}

class _PaymentsTabState extends State<PaymentsTab> {
  final ScrollController _scrollController = ScrollController();
  //
  final Map<String, (GlobalKey globalKey, LedgerPaymentsSummaryModel summary)>
      _groupKeysWithTotal = {};

  //
  final Debouncer debouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );
  String _currentlyShowingDate = '';
  double? _screenHeight; // Cache screen height
  double? _appBarHeight; // Store AppBar + TabBar height

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibleSection();
    });
  }

  void _onScroll() {
    // Handle pagination
    final bloc = context.read<WalletPaymentsBloc>();
    if (bloc.state.isLoaded) {
      final state = bloc.getLoadedState;
      if (!state.isPaginating &&
          state.nextPageUrl != null &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100) {
        bloc.add(const WalletPaymentsEvent.loadNextPagePayments());
      }
    }

    _checkVisibleSection();
  }

  void _checkVisibleSection() {
    if (!mounted) return;

    // Cache screen height and AppBar height
    _screenHeight ??= context.screenHeight.toDouble();
    _appBarHeight ??= _calculateAppBarHeight();

    log('🔍 Checking visible section. Keys count: ${_groupKeysWithTotal.length}');

    String? targetDate;
    double minPosition = double.infinity;

    for (final entry in _groupKeysWithTotal.entries) {
      final key = entry.value.$1;
      final ctx = key.currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;

      // Calculate position relative to the top of the ListView (below AppBar)
      final position = box.localToGlobal(Offset.zero).dy - _appBarHeight!;

      // Check if the section is in the top third of the visible screen
      final visibleHeight = _screenHeight! - _appBarHeight!;
      if (position > 0 &&
          position < visibleHeight / 2.5 &&
          position < minPosition) {
        minPosition = position;
        targetDate = entry.key;
      }
    }

    if (targetDate != null && targetDate != _currentlyShowingDate) {
      log('🎯 Target date found: $targetDate (current: $_currentlyShowingDate)');
      debouncer.run(() async => _fetchAndSetSummary(targetDate!));
    } else {
      log('❌ No target date found or same as current');
    }
  }

  double _calculateAppBarHeight() {
    final appBar = context.findAncestorWidgetOfExactType<AppBar>();
    final preferredSize = appBar?.preferredSize.height ?? 60.0;
    final tabBarHeight = 60.0; // Adjust based on your TabBar design
    final additionalPadding = 10.0;
    return preferredSize + tabBarHeight + additionalPadding;
  }

  Future<void> _fetchAndSetSummary(String date) async {
    log('🔔 _fetchAndSetSummary called with date: $date');
    if (_currentlyShowingDate == date) {
      log('⚠️ Already showing this date, skipping');
      return;
    }
    _currentlyShowingDate = date;
    final summary = _groupKeysWithTotal[date]?.$2;
    log('✅ Fetching summary for date: $date, summary: ${summary?.toJson()}');
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
          date,
          clientId: null,
          total: summary,
          type: LedgerType.payments,
        );
  }

  @override
  void dispose() {
    // controller
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    // debouncer
    debouncer.cancel(); // Cancel any pending debounced calls
    super.dispose();
  }

  void _fetchPaymentData() {
    final clientId = context.read<ClientCubit>().getSelectedClient()?.id;
    context.read<WalletPaymentsBloc>().add(
          WalletPaymentsEvent.loadPayments(clientId: clientId),
        );
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
        onRefresh: () async {
          //
          context.read<LedgerSimpleSummaryCubit>().reset();
          _currentlyShowingDate = ''; // Reset current date on refresh
          _groupKeysWithTotal.clear(); // Clear cached keys and totals
          _fetchPaymentData();
        },
        child: BlocBuilder<WalletPaymentsBloc, WalletPaymentsState>(
          builder: (context, state) => state.when(
            loading: () => ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) =>
                  const LedgerPaymentGroupShimmer(),
            ),
            error: (error) =>
                CustomErrorWidget(errorText: error, onRetry: _fetchPaymentData),
            loaded: (paymentList, nextPageUrl, isPaginating, clientId,
                isFirstFetch) {
              log('📊 Payment list loaded: ${paymentList.length} groups');
              for (var group in paymentList) {
                log('  📅 Date: ${group.date}, Payments count: ${group.payments.length}');
                for (var payment in group.payments) {
                  log('    💰 Payment: ${payment.clientName} - ${payment.paymentAmount}');
                }
              }

              if (paymentList.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No payments',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }

              paymentList.forEach((e) {
                _groupKeysWithTotal.putIfAbsent(
                  e.date,
                  () => (
                    GlobalKey(),
                    e.paymentsSummary ?? LedgerPaymentsSummaryModel.empty(),
                  ),
                );
              });

              // Fetch initial summary for the first date if not already set
              if (isFirstFetch && paymentList.isNotEmpty) {
                final firstDate = paymentList.first.date;
                _fetchAndSetSummary(firstDate);
                log('✅✅ Fetched summary for first date: $firstDate ✅✅');
              }

              return RepaintBoundary(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: paymentList.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= paymentList.length) {
                      if (isPaginating) {
                        return const LedgerPaymentGroupShimmer();
                      }
                      return const CustomSizedBoxHeight(0.18); // Add spacing
                    }

                    final group = paymentList[index];
                    final key = _groupKeysWithTotal
                        .putIfAbsent(
                          group.date,
                          () => (
                            GlobalKey(),
                            group.paymentsSummary ??
                                LedgerPaymentsSummaryModel.empty(),
                          ),
                        )
                        .$1;
                    final summaryDay = group.date.getDateHeading();

                    return KeyedSubtree(
                      key: key,
                      child: LedgerPaymentGroupContainer(
                        summaryDay: summaryDay,
                        payments: group.payments,
                        date: group.date,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
}
