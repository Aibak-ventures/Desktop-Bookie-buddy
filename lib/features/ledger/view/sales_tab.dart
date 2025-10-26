import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_sales_group_container.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_ledger_sales/ledger_sales_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SalesTab extends StatefulWidget {
  const SalesTab({super.key});

  @override
  State<SalesTab> createState() => _SalesTabState();
}

class _SalesTabState extends State<SalesTab> {
  // controllers
  final _scrollController = ScrollController();
  //
  final Map<String, (GlobalKey globalKey, int total)> _groupKeysWithTotal = {};
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

  void _onScroll() {
    // Handle pagination
    final bloc = context.read<LedgerSalesBloc>();
    if (bloc.state.isLoaded) {
      final state = bloc.getLoadedState;
      if (!state.isPaginating &&
          state.nextPageUrl != null &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100) {
        bloc.add(const LedgerSalesEvent.loadNextPageSales());
      }
    }

    _checkVisibleSection();
  }

  double _calculateAppBarHeight() {
    final appBar = context.findAncestorWidgetOfExactType<AppBar>();
    final preferredSize = appBar?.preferredSize.height ?? 60.0;
    final tabBarHeight = 60.0; // Adjust based on your TabBar design
    final additionalPadding = 10.0;
    return preferredSize + tabBarHeight + additionalPadding;
  }

  void _checkVisibleSection() {
    if (!mounted) return;

    // Cache screen height and AppBar height
    _screenHeight ??= context.screenHeight.toDouble();
    _appBarHeight ??= _calculateAppBarHeight();

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
      debouncer.run(() async => _fetchAndSetSummary(targetDate!));
    }
  }

  Future<void> _fetchAndSetSummary(String date) async {
    if (_currentlyShowingDate == date) {
      log('Summary for $date is already being shown, skipping fetch.');
      return;
    }
    _currentlyShowingDate = date;

    // final clientId = context.read<ClientBloc>().getSelectedClient()?.id;
    final total = _groupKeysWithTotal[date]!.$2;
    log('Fetching summary for date: $date with total: $total');
    // ignore: unawaited_futures
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
      date,
      clientId: null,
      total: total,
      type: LedgerType.sales,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return _buildWebLayout(context);
    } else {
      return _buildMobileLayout(context);
    }
  }

  Widget _buildWebLayout(BuildContext context) => Container(
    margin: EdgeInsets.only(top: 16.h),
    child: RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<LedgerSimpleSummaryCubit>().reset();
        _currentlyShowingDate = ''; // Reset current date on refresh
        _groupKeysWithTotal.clear();
        _fetchData(context);
      },
      child: BlocBuilder<LedgerSalesBloc, LedgerSalesState>(
        builder: (context, state) => state.when(
          loading: () => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 8,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: const LedgerSalesListTileShimmer(),
            ),
          ),
          error: (error) => Center(
            child: Container(
              margin: EdgeInsets.all(24.w),
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () => _fetchData(context),
              ),
            ),
          ),
          loaded:
              (ledgerSales, nextPageUrl, isPaginating, clientId, isFirstFetch) {
                if (ledgerSales.isEmpty) {
                  return Container(
                    margin: EdgeInsets.all(24.w),
                    padding: EdgeInsets.all(32.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const EmptyDataWidget(
                      message: 'No sales found',
                      isShowIcon: false,
                      isScrollable: false,
                    ),
                  );
                }
                ledgerSales.forEach((element) {
                  _groupKeysWithTotal.putIfAbsent(
                    element.date,
                    () => (GlobalKey(), element.total),
                  );
                });

                final firstDate = ledgerSales.firstOrNull?.date;
                if (firstDate != null && isFirstFetch) {
                  _fetchAndSetSummary(firstDate);
                  log('✅✅ Fetched summary for first date: $firstDate ✅✅');
                }

                return RepaintBoundary(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                    itemCount: ledgerSales.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == ledgerSales.length) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: const LedgerSalesListTileShimmer(),
                        );
                      }
                      final groupedData = ledgerSales[index];
                      final key = _groupKeysWithTotal
                          .putIfAbsent(
                            groupedData.date,
                            () => (GlobalKey(), groupedData.total),
                          )
                          .$1;

                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: KeyedSubtree(
                          key: key,
                          child: LedgerSalesGroupContainer(
                            groupedDate: groupedData.date,
                            sales: groupedData.sales,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
        ),
      ),
    ),
  );

  Widget _buildMobileLayout(BuildContext context) => RefreshIndicator.adaptive(
    onRefresh: () async {
      context.read<LedgerSimpleSummaryCubit>().reset();
      _currentlyShowingDate = ''; // Reset current date on refresh
      _groupKeysWithTotal.clear();
      _fetchData(context);
    },
    child: BlocBuilder<LedgerSalesBloc, LedgerSalesState>(
      builder: (context, state) => state.when(
        loading: () => ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 15,
          // Use shimmer for loading
          itemBuilder: (context, index) => const LedgerSalesListTileShimmer(),
        ),
        error: (error) => Center(
          child: CustomErrorWidget(
            errorText: error,
            onRetry: () => _fetchData(context),
          ),
        ),
        loaded:
            (ledgerSales, nextPageUrl, isPaginating, clientId, isFirstFetch) {
              if (ledgerSales.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No sales found',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }
              ledgerSales.forEach((element) {
                _groupKeysWithTotal.putIfAbsent(
                  element.date,
                  () => (GlobalKey(), element.total),
                );
              });

              final firstDate = ledgerSales.firstOrNull?.date;
              if (firstDate != null && isFirstFetch) {
                _fetchAndSetSummary(firstDate);
                log('✅✅ Fetched summary for first date: $firstDate ✅✅');
              }

              return RepaintBoundary(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: ledgerSales.length + (isPaginating ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == ledgerSales.length) {
                      return const LedgerSalesListTileShimmer();
                    }
                    final groupedData = ledgerSales[index];
                    final key = _groupKeysWithTotal
                        .putIfAbsent(
                          groupedData.date,
                          () => (GlobalKey(), groupedData.total),
                        )
                        .$1;

                    return KeyedSubtree(
                      key: key,
                      child: LedgerSalesGroupContainer(
                        groupedDate: groupedData.date,
                        sales: groupedData.sales,
                      ),
                    );
                  },
                ),
              );
            },
      ),
    ),
  );

  void _fetchData(BuildContext context) {
    final clientId = context.read<ClientCubit>().getSelectedClient()?.id;
    context.read<LedgerSalesBloc>().add(
      LedgerSalesEvent.loadSales(clientId: clientId),
    );
  }
}
