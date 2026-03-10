import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/invoice_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_expense_group_container.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({super.key});

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  final Map<String, (GlobalKey globalKey, int total)> _groupKeys = {};
  final debouncer = Debouncer(delay: const Duration(milliseconds: 300));
  String _currentlyShowingDate = '';
  double? _screenHeight; // Cache screen height
  double? _appBarHeight; // Store AppBar + TabBar height

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibleSection();
    });
    super.initState();
  }

  Future<void> _fetchAndSetSummary(String date) async {
    if (_currentlyShowingDate == date) return;
    _currentlyShowingDate = date;
    final total = _groupKeys[date]?.$2 ?? 0;
    await context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
          date,
          clientId: null,
          type: LedgerType.expense,
          total: total,
        );
  }

  void _checkVisibleSection() {
    if (!mounted) return;

    // Cache screen height and AppBar height
    _screenHeight ??= context.screenHeight.toDouble();
    _appBarHeight ??= _calculateAppBarHeight();

    String? targetDate;
    double minPosition = double.infinity;

    for (final entry in _groupKeys.entries) {
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

  double _calculateAppBarHeight() {
    final appBar = context.findAncestorWidgetOfExactType<AppBar>();
    final preferredSize = appBar?.preferredSize.height ?? 50.0;
    final tabBarHeight = 50.0; // Adjust based on your TabBar design
    final additionalPadding = 10.0;
    return preferredSize + tabBarHeight + additionalPadding;
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
            _fetchData(context);
          },
          child: BlocConsumer<WalletExpenseBloc, WalletExpenseState>(
            listener: (context, state) {
              state.maybeMap(
                orElse: () {},
                success: (value) {
                  context.showSnackBar(value.message, title: 'Delete Expense');
                  context.read<LedgerSimpleSummaryCubit>().reset();
                  _fetchData(context);
                },
                failure: (value) {
                  context.showSnackBar(
                    value.message,
                    title: 'Delete Expense',
                    isError: true,
                  );
                },
              );
            },
            buildWhen: (previous, current) => current.maybeMap(
              orElse: () => true,
              failure: (value) => false,
              success: (value) => false,
            ),
            builder: (context, state) => state.maybeWhen(
              orElse: () => const SizedBox(),
              loading: () => ListView.builder(
                itemCount: 6,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: const LedgerExpenseGroupShimmer(),
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
              loaded: (
                expenseGrouped,
                nextPageUrl,
                isPaginating,
                clientId,
                isFirstFetch,
              ) {
                if (expenseGrouped.isEmpty) {
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
                      message: 'No expenses',
                      isShowIcon: false,
                      isScrollable: false,
                    ),
                  );
                }

                expenseGrouped.forEach(
                  (e) => _groupKeys.putIfAbsent(
                    e.date,
                    () => (GlobalKey(), e.total),
                  ),
                );

                if (isFirstFetch && expenseGrouped.firstOrNull != null) {
                  log(
                    '✅✅ Fetched summary for first date: ${expenseGrouped.first.date} ✅✅',
                  );
                  _fetchAndSetSummary(expenseGrouped.first.date);
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent - 200 &&
                        nextPageUrl != null &&
                        !isPaginating) {
                      context.read<WalletExpenseBloc>().add(
                            const WalletExpenseEvent.loadNextPageExpense(),
                          );
                    }

                    _checkVisibleSection();
                    return false;
                  },
                  child: RepaintBoundary(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                      itemCount: expenseGrouped.length + (isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < expenseGrouped.length) {
                          final grouped = expenseGrouped[index];
                          final key = _groupKeys
                              .putIfAbsent(
                                grouped.date,
                                () => (GlobalKey(), grouped.total),
                              )
                              .$1;
                          final date = grouped.date.getDateHeading();
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
                              child: LedgerExpenseGroupContainer(
                                day: date,
                                expenses: grouped.expenses,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: const LedgerExpenseGroupShimmer(),
                          );
                        }
                      },
                    ),
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
          _fetchData(context);
        },
        child: BlocConsumer<WalletExpenseBloc, WalletExpenseState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              success: (value) {
                context.showSnackBar(value.message, title: 'Delete Expense');
                context.read<LedgerSimpleSummaryCubit>().reset();
                _fetchData(context);
              },
              failure: (value) {
                context.showSnackBar(
                  value.message,
                  title: 'Delete Expense',
                  isError: true,
                );
              },
            );
          },
          buildWhen: (previous, current) => current.maybeMap(
            orElse: () => true,
            failure: (value) => false,
            success: (value) => false,
          ),
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) =>
                  const LedgerExpenseGroupShimmer(),
            ),
            error: (error) => Center(
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () => _fetchData(context),
              ),
            ),
            loaded: (
              expenseGrouped,
              nextPageUrl,
              isPaginating,
              clientId,
              isFirstFetch,
            ) {
              if (expenseGrouped.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No expenses',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }

              expenseGrouped.forEach(
                (e) => _groupKeys.putIfAbsent(
                  e.date,
                  () => (GlobalKey(), e.total),
                ),
              );

              if (isFirstFetch && expenseGrouped.firstOrNull != null) {
                log(
                  '✅✅ Fetched summary for first date: ${expenseGrouped.first.date} ✅✅',
                );
                _fetchAndSetSummary(expenseGrouped.first.date);
              }
              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent - 200 &&
                      nextPageUrl != null &&
                      !isPaginating) {
                    context.read<WalletExpenseBloc>().add(
                          const WalletExpenseEvent.loadNextPageExpense(),
                        );
                  }

                  _checkVisibleSection();
                  return false;
                },
                child: RepaintBoundary(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: expenseGrouped.length + (isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < expenseGrouped.length) {
                        final grouped = expenseGrouped[index];
                        final key = _groupKeys
                            .putIfAbsent(
                              grouped.date,
                              () => (GlobalKey(), grouped.total),
                            )
                            .$1;
                        final date = grouped.date.getDateHeading();
                        return KeyedSubtree(
                          key: key,
                          child: LedgerExpenseGroupContainer(
                            day: date,
                            expenses: grouped.expenses,
                          ),
                        );
                      } else {
                        return const LedgerExpenseGroupShimmer();
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );

  void _fetchData(BuildContext context) {
    context.read<WalletExpenseBloc>().add(
          const WalletExpenseEvent.loadExpense(),
        );
  }
}
