import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_expense_group_container.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesTab extends StatefulWidget {
  const ExpensesTab({super.key});

  @override
  State<ExpensesTab> createState() => _ExpensesTabState();
}

class _ExpensesTabState extends State<ExpensesTab> {
  final Map<String, GlobalKey> _groupKeys = {};
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
    final clientId = context.read<ClientBloc>().getSelectedClient()?.id;
    context.read<LedgerSimpleSummaryCubit>().getLedgerDaySummary(
          date,
          clientId: clientId,
        );
  }

  void _checkVisibleSection() {
    if (!mounted) return;

    // Cache screen height and AppBar height
    _screenHeight ??= context.screenHeight.toDouble();
    _appBarHeight ??= _calculateAppBarHeight();

    String? targetDate;
    double minPosition = double.infinity;

    for (var entry in _groupKeys.entries) {
      final key = entry.value;
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
      debouncer.run(() async => await _fetchAndSetSummary(targetDate!));
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
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        context.read<WalletExpenseBloc>().add(
              const WalletExpenseEvent.loadExpense(),
            );
        context.read<LedgerSimpleSummaryCubit>().reset();
        _currentlyShowingDate = ''; // Reset current date on refresh
      },
      child: BlocConsumer<WalletExpenseBloc, WalletExpenseState>(
        listener: (context, state) {
          state.maybeMap(
            orElse: () {},
            success: (value) {
              context.showSnackBar(
                value.message,
                title: 'Delete Expense',
              );
              context.read<LedgerSimpleSummaryCubit>().reset();
              context
                  .read<WalletExpenseBloc>()
                  .add(const WalletExpenseEvent.loadExpense());
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
        buildWhen: (previous, current) {
          return current.maybeMap(
            orElse: () => true,
            failure: (value) => false,
            success: (value) => false,
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return const LedgerExpenseGroupShimmer();
              },
            ),
            error: (error) => Center(
              child: CustomErrorWidget(
                errorText: error,
                onRetry: () => context.read<WalletExpenseBloc>().add(
                      const WalletExpenseEvent.loadExpense(),
                    ),
              ),
            ),
            loaded: (expenseGrouped, nextPageUrl, isPaginating, clientId) {
              if (expenseGrouped.isEmpty) {
                return const EmptyDataWidget(
                  message: 'No expenses',
                  isShowIcon: false,
                  isScrollable: true,
                );
              }
              if (expenseGrouped.firstOrNull != null) {
                print('first date: ${expenseGrouped.first.date}');
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
                child: ListView.builder(
                  key: const PageStorageKey('expense-tab-list'),
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: expenseGrouped.length + (isPaginating ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < expenseGrouped.length) {
                      final grouped = expenseGrouped[index];
                      final key =
                          _groupKeys.putIfAbsent(grouped.date, GlobalKey.new);
                      return KeyedSubtree(
                        key: key,
                        child: LedgerExpenseGroupContainer(
                          day: grouped.date.getDateHeading(),
                          expenses: grouped.expenses,
                        ),
                      );
                    } else {
                      return const LedgerExpenseGroupShimmer();
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
