import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_client/client_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/wallet/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/wallet/view/expense_tab.dart';
import 'package:bookie_buddy_web/features/wallet/view/payments_tab.dart';
import 'package:bookie_buddy_web/features/wallet/view/pending_tab.dart';
import 'package:bookie_buddy_web/features/wallet/view/security_amount_tab.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/generate_statement_pdf.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_payment_summary_widget.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_summary_simple_widget.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_ledger_security_amounts/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_expense/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_payments/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/bloc_wallet_pending/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/wallet/view_model/ledger_simple_summary_cubit.dart';
import 'package:bookie_buddy_web/utils/app_date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  int currentIndex = 0;

  // notifiers
  bool isSearchBarVisible = false;

  // controller
  final nameController = TextEditingController();
  final nameScrollController = ScrollController();
  late final TabController tabController;

  // final List<bool> _hasDataFetched = [
  //   false,
  //   false,
  //   false,
  //   false,
  // ]; // List to track data fetching to prevent duplicate fetching

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 4, vsync: this);

    tabController.addListener(() {
      if (tabController.previousIndex != tabController.index) {
        setState(() {
          currentIndex = tabController.index;
        });
        _fetchDataForTab(currentIndex);
        log('Tab controller index: ${tabController.index}');
      }
    });
    _fetchDataForTab(0); // Fetch data on screen initialization

    nameScrollController.addListener(_onScrollName);
  }

  void _onScrollName() {
    if (nameScrollController.hasClients &&
        nameScrollController.position.pixels >=
            nameScrollController.position.maxScrollExtent - 50) {
      final bloc = context.read<ClientBloc>();
      final isLoadNext = bloc.state.when(
        initial: (
          suggestions,
          selectedClient,
          searchQuery,
          nextPageUrl,
          isLoading,
        ) =>
            selectedClient == null &&
            searchQuery.isNotEmpty &&
            nextPageUrl != null &&
            !isLoading,
      );
      if (isLoadNext) bloc.add(const ClientEvent.loadNextData());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Fetch data when coming back to the WalletScreen
      _fetchDataForTab(currentIndex);
    }
  }

  void _fetchDataForTab(int tabIndex, {bool forceFetch = false}) {
    // context.read<LedgerSimpleSummaryCubit>().update();
    // Check if data has already been fetched
    // if (_hasDataFetched[tabIndex] && !forceFetch) {
    //   log('Data already fetched for tab index: $tabIndex');
    //   return;
    // }

    final clientId = context.read<ClientBloc>().getSelectedClient()?.id;

    switch (tabIndex) {
      case 0:
        context
            .read<WalletPaymentsBloc>()
            .add(WalletPaymentsEvent.loadPayments(clientId: clientId));

        break;
      case 1:
        context
            .read<WalletExpenseBloc>()
            .add(const WalletExpenseEvent.loadExpense());

        break;
      case 2:
        context
            .read<WalletPendingBloc>()
            .add(WalletPendingEvent.loadPending(clientId: clientId));

      case 3:
        context.read<LedgerSecurityAmountsBloc>().add(
            LedgerSecurityAmountsEvent.loadSecurityAmounts(clientId: clientId));

        break;
      default:
        break;
    }

    // _hasDataFetched[tabIndex] = true; // Mark the data as fetched
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // controller
    tabController.dispose();
    nameController.dispose();
    nameScrollController.dispose();

    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ledger"),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.purpleLightShade,
              borderRadius: 5.radiusBorder,
            ),
            padding: 8.padding,
            child: Icon(
              isSearchBarVisible ? LucideIcons.x : LucideIcons.search,
              size: 18.sp,
            ),
          ).onTap(
            () {
              setState(() {
                // isSearchBarVisible.value = !isSearchBarVisible.value;
                isSearchBarVisible = !isSearchBarVisible;
              });
            },
          ),
          5.width,
          Container(
            decoration: BoxDecoration(
              color: AppColors.purpleLightShade,
              borderRadius: 5.radiusBorder,
            ),
            padding: 8.padding,
            child: Row(
              children: [
                Icon(
                  Icons.print_outlined,
                  size: 18.sp,
                ),
                4.width,
                Text(
                  'Print',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).onTap(() async {
            final isClientSelected =
                context.read<ClientBloc>().getSelectedClient() != null;
            bool includeExpenses = isClientSelected ? false : true;
            bool includePayments = true;
            bool includePendings = false;
            bool includeSecurity = false;
            await showDateFilterBottomSheet(
              context: context,
              buttonText: 'Generate report',
              isGeneratePdf: true,
              initialStartDate: AppDateUtils.last7Days(),
              initialEndDate: AppDateUtils.today(),
              onDateFilterChanged: (startDate, endDate) {},
              showCheckboxOptions: true,
              title: 'Statement Include',
              checkboxOptions: [
                CheckboxOption(
                  id: 'payments',
                  label: 'Payments',
                  isSelected: includePayments,
                ),
                if (!isClientSelected)
                  CheckboxOption(
                    id: 'expenses',
                    label: 'Expenses',
                    isSelected: includeExpenses,
                  ),
                CheckboxOption(
                  id: 'pending',
                  label: 'Pendings only',
                  isSelected: includePendings,
                ),
                CheckboxOption(
                  id: 'security',
                  label: 'Security Amounts only',
                  isSelected: includeSecurity,
                ),
              ],
              onCheckboxChanged: (options) {
                // Handle checkbox changes
                includePayments = options.any(
                    (option) => option.id == 'payments' && option.isSelected);
                if (!isClientSelected)
                  includeExpenses = options.any(
                      (option) => option.id == 'expenses' && option.isSelected);
                includePendings = options.any(
                    (option) => option.id == 'pending' && option.isSelected);
                includeSecurity = options.any(
                    (option) => option.id == 'security' && option.isSelected);
              },
              onApplyButtonPressed: (isExcel, fromDate, toDate) async {
                if (fromDate == null || toDate == null) {
                  context.showSnackBar(
                    'Please select start date and end date',
                    isError: true,
                  );
                  return;
                }
                context.pop();
                log(
                  'fromDate: $fromDate, toDate: $toDate, includeExpenses: $includeExpenses, includePayments: $includePayments, isExcel: $isExcel',
                );
                final user = context.read<UserCubit>().state!;
                await shareLedgerInvoice(
                  context: context,
                  user: user,
                  fromDate: fromDate.format(),
                  toDate: toDate.format(),
                  includeExpense: includeExpenses,
                  includePayments: includePayments,
                  includePendings: includePendings,
                  includeSecurity: includeSecurity,
                  isExcel: isExcel,
                );
              },
            );
          }),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              (currentIndex == 0 ? 170 : 130) + (isSearchBarVisible ? 65 : 0)),
          child: Column(
            children: [
              Padding(
                padding: 10.padding,
                child:
                    BlocBuilder<LedgerSimpleSummaryCubit, DailySummaryModel?>(
                  builder: (context, summaryState) {
                    String title = 'Today summary';

                    if (summaryState?.date.isNotEmpty ?? false) {
                      title = summaryState!.date.getDateHeading() + ' summary';
                    }

                    if (currentIndex == 0) {
                      return LedgerPaymentSummaryWidget(
                        totalSummary: summaryState?.payments,
                        summaryDay: title,
                      );
                    } else if (currentIndex == 1) {
                      return LedgerSummarySimpleWidget(
                        title: title,
                        amount: summaryState?.expenses ?? 0,
                      );
                    } else if (currentIndex == 2) {
                      return LedgerSummarySimpleWidget(
                        title: 'Total pendings',
                        amount: summaryState?.pendings ?? 0,
                      );
                    } else {
                      return LedgerSummarySimpleWidget(
                        title: 'Total Amount',
                        amount: summaryState?.securityAmount ?? 0,
                      );
                    }
                  },
                ),
              ),
              Visibility(
                visible: isSearchBarVisible,
                child: BlocListener<ClientBloc, ClientState>(
                  listener: (context, state) {
                    state.when(
                      initial: (suggestions, selectedClient, searchQuery,
                          nextPageUrl, isLoading) {
                        if (selectedClient != null) {
                          nameController.text = selectedClient.name;
                          _fetchDataForTab(
                            currentIndex,
                            forceFetch: true,
                          );
                          context.hideKeyboard();
                          context.read<LedgerSimpleSummaryCubit>().reset();
                          if (currentIndex != 0)
                            context
                                .read<LedgerSimpleSummaryCubit>()
                                .getLedgerDaySummary(
                                  DateTime.now().format(),
                                  clientId: selectedClient.id,
                                );
                        }
                      },

                      // initial: (
                      //   suggestions,
                      //   searchQuery,
                      //   nextPageUrl,
                      //   isLoading,
                      // ) {
                      //   if (selectedClient != null) {
                      //     nameController.text = selectedClient.name;
                      //     _fetchDataForTab(
                      //       currentIndex,
                      //       forceFetch: true,
                      //     );
                      //     context.hideKeyboard();
                      //     context.read<LedgerSimpleSummaryCubit>().reset();
                      //   }
                      // },
                    );
                  },
                  child: Padding(
                    padding: (10, 5).padding,
                    child: ClientSearchNameField(
                      hitText: 'Filter by customer',
                      nameController: nameController,
                      scrollController: nameScrollController,
                      onClear: () {
                        _fetchDataForTab(
                          currentIndex,
                          forceFetch: true,
                        );
                        context.read<LedgerSimpleSummaryCubit>().reset();
                        if (currentIndex != 0)
                          context
                              .read<LedgerSimpleSummaryCubit>()
                              .getLedgerDaySummary(
                                DateTime.now().format(),
                                clientId: null,
                              );
                      },
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: const Color(0xFF6132E4),
                indicatorWeight: 2.5,
                unselectedLabelStyle: const TextStyle(),
                onTap: (index) {
                  // Fetch data for the selected tab
                  // _fetchDataForTab(index);
                  setState(
                    () {
                      currentIndex = index;
                    },
                  );
                },

                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17.sp,
                ),

                labelColor:
                    const Color(0xFF6132E4), // Text color for selected tab
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(text: "Payments"),
                  Tab(text: "Expenses"),
                  Tab(text: "Pending"),
                  Tab(text: "Security Amount"),
                ],
              ),
              Container(
                width: double.infinity,
                margin: 12.paddingHorizontal,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey300,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        // physics: const NeverScrollableScrollPhysics(),
        children: const [
          const PaymentsTab(),
          const ExpensesTab(),
          const PendingTab(),
          const SecurityAmountTab(),
        ],
      ),
    );
  }
}
