import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/bookings_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/expense_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/payments_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/pending_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/sales_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/pages/security_amount_tab.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/generate_statement_pdf.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/ledger_payment_summary_widget.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/ledger_summary_simple_widget.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/ledger_bookings_bloc/ledger_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/ledger_sales_bloc/ledger_sales_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/ledger_security_amounts_bloc/ledger_security_amounts_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/wallet_expense_bloc/wallet_expense_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/wallet_payments_bloc/wallet_payments_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/wallet_pending_bloc/wallet_pending_bloc.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/bloc/ledger_simple_summary_cubit.dart';
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
  late final TabController tabController;
  late final VoidCallback onTabListener;

  //Node
  final FocusNode nameSearchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 6, vsync: this);
    onTabListener = () {
      if (tabController.previousIndex != tabController.index) {
        setState(() {
          currentIndex = tabController.index;
        });
        _fetchDataForTab(currentIndex);
        log('Tab controller index: ${tabController.index}');
      }
    };
    tabController.addListener(onTabListener);
    _fetchDataForTab(0); // Fetch data on screen initialization
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Fetch data when coming back to the WalletScreen
      _fetchDataForTab(currentIndex);
    }
  }

  void _fetchDataForTab(
    int tabIndex, {
    bool forceFetch = false,
    bool clearClient = false,
  }) {
    // context.read<LedgerSimpleSummaryCubit>().update();
    // Check if data has already been fetched
    // if (_hasDataFetched[tabIndex] && !forceFetch) {
    //   log('Data already fetched for tab index: $tabIndex');
    //   return;
    // }

    final clientId = clearClient
        ? null
        : context.read<ClientCubit>().getSelectedClient()?.id;
    if (clearClient) {
      context.read<ClientCubit>().clearSelected();
    }

    switch (tabIndex) {
      case 0:
        context.read<LedgerBookingsBloc>().add(
              LedgerBookingsEvent.loadBookings(clientId: clientId),
            );
        break;
      case 1:
        context.read<WalletPaymentsBloc>().add(
              WalletPaymentsEvent.loadPayments(clientId: clientId),
            );
        break;
      case 2:
        context.read<WalletPendingBloc>().add(
              WalletPendingEvent.loadPending(clientId: clientId),
            );
        break;
      case 3:
        context.read<WalletExpenseBloc>().add(
              const WalletExpenseEvent.loadExpense(),
            );
        break;
      case 4:
        context.read<LedgerSalesBloc>().add(
              LedgerSalesEvent.loadSales(clientId: clientId),
            );
        break;
      case 5:
        context.read<LedgerSecurityAmountsBloc>().add(
              LedgerSecurityAmountsEvent.loadSecurityAmounts(
                  clientId: clientId),
            );
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    tabController
      ..removeListener(onTabListener)
      ..dispose();
    nameController.dispose();

    //
    nameSearchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handlePrintAction(BuildContext builderContext) async {
    final isClientSelected =
        builderContext.read<ClientCubit>().getSelectedClient() != null;

    bool includeSales = false;
    bool includeBookings = false;
    bool includeExpenses = false;
    bool includePayments = false;
    bool includePendings = false;
    bool includeSecurity = false;

    switch (currentIndex) {
      case 0:
        includeBookings = true;
      case 1:
        includePayments = true;
      case 2:
        includePendings = true;
      case 3:
        includeExpenses = !isClientSelected;
      case 4:
        includeSales = true;
      case 5:
        includeSecurity = true;
      default:
    }
    await showDateFilterBottomSheet(
      context: builderContext,
      initialChildSize: 0.95,
      buttonText: 'Generate report',
      isGeneratePdf: true,
      initialStartDate: AppDateUtils.last7Days(),
      initialEndDate: AppDateUtils.today(),
      onDateFilterChanged: (startDate, endDate) {},
      showCheckboxOptions: true,
      title: 'Statement Include',
      checkboxOptions: [
        CheckboxOption(
          id: LedgerType.bookings.value,
          label: LedgerType.bookings.name,
          isSelected: includeBookings,
        ),
        CheckboxOption(
          id: LedgerType.payments.value,
          label: LedgerType.payments.name,
          isSelected: includePayments,
        ),
        CheckboxOption(
          id: LedgerType.pendings.value,
          label: LedgerType.pendings.name,
          isSelected: includePendings,
        ),
        if (!isClientSelected)
          CheckboxOption(
            id: LedgerType.expense.value,
            label: LedgerType.expense.name,
            isSelected: includeExpenses,
          ),
        CheckboxOption(
          id: LedgerType.sales.value,
          label: LedgerType.sales.name,
          isSelected: includeSales,
        ),
        CheckboxOption(
          id: LedgerType.security.value,
          label: LedgerType.security.name,
          isSelected: includeSecurity,
        ),
      ],
      onCheckboxChanged: (options) {
        // Handle checkbox changes
        includeSales = options.any(
          (option) => option.id == LedgerType.sales.value && option.isSelected,
        );

        includeBookings = options.any(
          (option) =>
              option.id == LedgerType.bookings.value && option.isSelected,
        );
        includePayments = options.any(
          (option) =>
              option.id == LedgerType.payments.value && option.isSelected,
        );
        if (!isClientSelected)
          includeExpenses = options.any(
            (option) =>
                option.id == LedgerType.expense.value && option.isSelected,
          );
        includePendings = options.any(
          (option) =>
              option.id == LedgerType.pendings.value && option.isSelected,
        );
        includeSecurity = options.any(
          (option) =>
              option.id == LedgerType.security.value && option.isSelected,
        );
      },
      onApplyButtonPressed: (isExcel, fromDate, toDate) async {
        if (fromDate == null || toDate == null) {
          builderContext.showSnackBar(
            'Please select start date and end date',
            isError: true,
          );
          return;
        }
        builderContext.pop();
        log(
          'fromDate: $fromDate, toDate: $toDate, includeExpenses: $includeExpenses, includePayments: $includePayments, isExcel: $isExcel',
        );
        final user = builderContext.read<UserCubit>().state!;
        await LedgerPDFService.shareLedgerInvoice(
          context: builderContext,
          user: user,
          fromDate: fromDate.format(),
          toDate: toDate.format(),
          includeSales: includeSales,
          includeBookings: includeBookings,
          includeExpense: includeExpenses,
          includePayments: includePayments,
          includePendings: includePendings,
          includeSecurity: includeSecurity,
          isExcel: isExcel,
        );
      },
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

  Widget _buildWebLayout(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ledger'),
          centerTitle: false,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8.w),
              decoration: BoxDecoration(
                color: AppColors.purpleLightShade,
                borderRadius: 8.radiusBorder,
              ),
              padding: 12.padding,
              child: Icon(
                isSearchBarVisible ? LucideIcons.x : LucideIcons.search,
                size: 20.sp,
              ),
            ).onTap(() {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;

                if (isSearchBarVisible) {
                  nameSearchFocusNode.requestFocus();
                } else {
                  nameSearchFocusNode.unfocus();
                  if (nameController.text.trim().isNotEmpty ||
                      context
                          .read<ClientCubit>()
                          .state
                          .searchQuery
                          .isNotEmpty) {
                    nameController.clear();
                    _fetchDataForTab(
                      currentIndex,
                      forceFetch: true,
                      clearClient: true,
                    );
                  }
                }
              });
            }),
            Builder(
              builder: (builderContext) => Container(
                margin: EdgeInsets.only(right: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: 8.radiusBorder,
                ),
                padding: 12.padding,
                child: Row(
                  children: [
                    Icon(Icons.download_outlined,
                        size: 20.sp, color: AppColors.white),
                    8.width,
                    Text(
                      'Download Report',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ).onTap(() => _handlePrintAction(builderContext)),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              (currentIndex == 1 ? 200 : 160) + (isSearchBarVisible ? 80 : 0),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: 1400.w),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  // Summary Section
                  Container(
                    padding: 20.padding,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: 12.radiusBorder,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey400.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BlocBuilder<LedgerSimpleSummaryCubit,
                        DailySummaryModel?>(
                      builder: (context, summaryState) {
                        String title = 'Today summary';

                        if (summaryState?.date.isNotEmpty ?? false) {
                          title =
                              summaryState!.date.getDateHeading() + ' summary';
                        }

                        switch (currentIndex) {
                          case 0:
                            return LedgerSummarySimpleWidget(
                              title: title,
                              amount: summaryState?.bookingAmount ?? 0,
                            );
                          case 1:
                            return LedgerPaymentSummaryWidget(
                              summaryDay: title,
                              totalSummary: summaryState?.payments,
                            );
                          case 2:
                            return LedgerSummarySimpleWidget(
                              title: 'Total pendings',
                              amount: summaryState?.pendings ?? 0,
                            );
                          case 3:
                            return LedgerSummarySimpleWidget(
                              title: title,
                              amount: summaryState?.expenses ?? 0,
                            );
                          case 4:
                            return LedgerSummarySimpleWidget(
                              title: title,
                              amount: summaryState?.salesAmount ?? 0,
                            );
                          case 5:
                            return LedgerSummarySimpleWidget(
                              title: 'Total Amount',
                              amount: summaryState?.securityAmount ?? 0,
                            );

                          default:
                            throw Exception(
                              'Ledger summary not found for index $currentIndex',
                            );
                        }
                      },
                    ),
                  ),
                  // Search Field
                  Visibility(
                    visible: isSearchBarVisible,
                    child: BlocListener<ClientCubit, ClientState>(
                      listener: (context, state) {
                        final selectedClient = state.selectedClient;
                        if (selectedClient != null) {
                          nameController.text = selectedClient.name;
                          context.read<LedgerSimpleSummaryCubit>().reset();
                          _fetchDataForTab(currentIndex, forceFetch: true);

                          context.hideKeyboard();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: ClientSearchNameField(
                          hitText: 'Filter by customer',
                          nameController: nameController,
                          focusNode: nameSearchFocusNode,
                          onClear: () {
                            context.read<LedgerSimpleSummaryCubit>().reset();
                            _fetchDataForTab(currentIndex);
                          },
                        ),
                      ),
                    ),
                  ),
                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: 12.radiusBorder,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey400.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: tabController,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      indicatorColor: const Color(0xFF6132E4),
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                      ),
                      labelColor: const Color(0xFF6132E4),
                      unselectedLabelColor: AppColors.grey600,
                      tabs: const [
                        Tab(text: 'Bookings'),
                        Tab(text: 'Payments'),
                        Tab(text: 'Pending'),
                        Tab(text: 'Expenses'),
                        Tab(text: 'Sales'),
                        Tab(text: 'Security Amount'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1400.w),
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: TabBarView(
              controller: tabController,
              children: const [
                BookingsTab(),
                PaymentsTab(),
                PendingTab(),
                ExpensesTab(),
                SalesTab(),
                SecurityAmountTab(),
              ],
            ),
          ),
        ),
      );

  Widget _buildMobileLayout(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Ledger'),
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
            ).onTap(() {
              setState(() {
                isSearchBarVisible = !isSearchBarVisible;

                if (isSearchBarVisible) {
                  nameSearchFocusNode.requestFocus();
                } else {
                  nameSearchFocusNode.unfocus();
                  if (nameController.text.trim().isNotEmpty ||
                      context
                          .read<ClientCubit>()
                          .state
                          .searchQuery
                          .isNotEmpty) {
                    nameController.clear();
                    _fetchDataForTab(
                      currentIndex,
                      forceFetch: true,
                      clearClient: true,
                    );
                  }
                }
              });
            }),
            5.width,
            Builder(
              builder: (builderContext) => Container(
                decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: 5.radiusBorder,
                ),
                padding: 8.padding,
                child: Row(
                  children: [
                    Icon(Icons.download_outlined,
                        size: 18.sp, color: AppColors.white),
                    4.width,
                    Text(
                      'Download',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ).onTap(() => _handlePrintAction(builderContext)),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
              (currentIndex == 1 ? 170 : 130) + (isSearchBarVisible ? 65 : 0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: 10.padding,
                  child:
                      BlocBuilder<LedgerSimpleSummaryCubit, DailySummaryModel?>(
                    builder: (context, summaryState) {
                      String title = 'Today summary';

                      if (summaryState?.date.isNotEmpty ?? false) {
                        title =
                            summaryState!.date.getDateHeading() + ' summary';
                      }

                      switch (currentIndex) {
                        case 0:
                          return LedgerSummarySimpleWidget(
                            title: title,
                            amount: summaryState?.bookingAmount ?? 0,
                          );
                        case 1:
                          return LedgerPaymentSummaryWidget(
                            summaryDay: title,
                            totalSummary: summaryState?.payments,
                          );
                        case 2:
                          return LedgerSummarySimpleWidget(
                            title: 'Total pendings',
                            amount: summaryState?.pendings ?? 0,
                          );
                        case 3:
                          return LedgerSummarySimpleWidget(
                            title: title,
                            amount: summaryState?.expenses ?? 0,
                          );
                        case 4:
                          return LedgerSummarySimpleWidget(
                            title: title,
                            amount: summaryState?.salesAmount ?? 0,
                          );
                        case 5:
                          return LedgerSummarySimpleWidget(
                            title: 'Total Amount',
                            amount: summaryState?.securityAmount ?? 0,
                          );

                        default:
                          throw Exception(
                            'Ledger summary not found for index $currentIndex',
                          );
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: isSearchBarVisible,
                  child: BlocListener<ClientCubit, ClientState>(
                    listener: (context, state) {
                      final selectedClient = state.selectedClient;
                      if (selectedClient != null) {
                        nameController.text = selectedClient.name;
                        context.read<LedgerSimpleSummaryCubit>().reset();
                        _fetchDataForTab(currentIndex, forceFetch: true);

                        context.hideKeyboard();
                      }
                    },
                    child: Padding(
                      padding: (10, 5).padding,
                      child: ClientSearchNameField(
                        hitText: 'Filter by customer',
                        nameController: nameController,
                        // scrollController: nameScrollController,
                        focusNode: nameSearchFocusNode,
                        onClear: () {
                          context.read<LedgerSimpleSummaryCubit>().reset();
                          _fetchDataForTab(currentIndex);
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
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: AppColors.white,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp,
                  ),

                  labelColor: const Color(
                    0xFF6132E4,
                  ), // Text color for selected tab
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(text: 'Bookings'),
                    Tab(text: 'Payments'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Expenses'),
                    Tab(text: 'Sales'),
                    Tab(text: 'Security Amount'),
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: 12.paddingHorizontal,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey300),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          // physics: const NeverScrollableScrollPhysics(),
          children: const [
            BookingsTab(),
            PaymentsTab(),
            PendingTab(),
            ExpensesTab(),
            SalesTab(),
            SecurityAmountTab(),
          ],
        ),
      );
}
