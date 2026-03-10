import 'dart:developer';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/sales_card.dart';
import 'package:bookie_buddy_web/features/sale_details/view/sale_details_screen.dart';
import 'package:bookie_buddy_web/features/sale_details/view_model/bloc_sale_details/sale_details_bloc.dart';
import 'package:bookie_buddy_web/features/sales/view_model/bloc_sales_list/sales_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SalesListScreen extends StatefulWidget {
  const SalesListScreen({super.key});

  @override
  State<SalesListScreen> createState() => _SalesListScreenState();
}

class _SalesListScreenState extends State<SalesListScreen> {
  // Date filter state
  final dateFilterNotifier = ValueNotifier(const DateFilterModel());

  final searchController = TextEditingController();

  final isSearchingNotifier = ValueNotifier(false);

  final searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Load sales after the frame is built to ensure providers are available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SalesListBloc>().add(const SalesListEvent.getSales());
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    dateFilterNotifier.dispose();
    isSearchingNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Sales'),
        centerTitle: !isDesktop,
        actions: [
          // Search Icon
          ValueListenableBuilder(
            valueListenable: isSearchingNotifier,
            builder: (context, isSearching, child) => IconButton(
              icon: Icon(
                isSearching ? Icons.close : LucideIcons.search,
                size: isDesktop ? 22 : 20.sp,
              ),
              onPressed: () {
                isSearchingNotifier.value = !isSearchingNotifier.value;
                if (isSearchingNotifier.value) {
                  searchFocusNode.requestFocus();
                } else {
                  searchFocusNode.unfocus();
                  if (searchController.text.trim().isNotEmpty ||
                      dateFilterNotifier.value.hasActiveFilter) {
                    searchController.clear();
                    _fetchData(context);
                  }
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          // Date Filter Button
          ValueListenableBuilder(
            valueListenable: dateFilterNotifier,
            builder: (context, value, child) => DateFilterButton(
              showLabel: isDesktop,
              hasActiveFilter: value.hasActiveFilter,
              onTap: () => _showDateFilterBottomSheet(context),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: isDesktop
          ? _buildDesktopLayout(context)
          : _buildMobileLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Search Bar and Actions
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        onChanged: (query) => _fetchData(context),
                        decoration: InputDecoration(
                          hintText: 'Search by sale ID and Product name...',
                          prefixIcon: const Icon(LucideIcons.search),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    searchController.clear();
                                    _fetchData(context);
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color(0xFF667eea), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Active Filter Indicator
            ValueListenableBuilder(
              valueListenable: dateFilterNotifier,
              builder: (context, value, child) => value.hasActiveFilter
                  ? _buildActiveFilterIndicator(context)
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            // Sales List
            Expanded(
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: RefreshIndicator.adaptive(
                  onRefresh: () async => _fetchData(context),
                  child: BlocBuilder<SalesListBloc, SalesListState>(
                    builder: (context, state) => state.when(
                      loading: () => const SalesListShimmer(),
                      error: (error) => CustomErrorWidget(
                        errorText: error.toString(),
                        onRetry: () => _fetchData(context),
                      ),
                      loaded: (sales, nextPageUrl, isPaginating, _, _b, _a) {
                        if (sales.isEmpty) {
                          return _buildEmptyState(context);
                        }
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                    scrollInfo.metrics.maxScrollExtent - 200 &&
                                !isPaginating &&
                                nextPageUrl != null) {
                              context.read<SalesListBloc>().add(
                                    const SalesListEvent.getNextPageSales(),
                                  );
                            }
                            return false;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: sales.length + (isPaginating ? 1 : 0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              if (index >= sales.length) {
                                return const SalesCardShimmer();
                              }
                              final sale = sales[index];
                              return SalesCard(
                                sale: sale,
                                onTap: () =>
                                    onTapCard(context: context, sale: sale),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        // Active Search field
        ValueListenableBuilder(
          valueListenable: isSearchingNotifier,
          builder: (context, isSearching, child) => isSearching
              ? CustomSearchField(
                  searchController: searchController,
                  padding: (16, 8).padding,
                  focusNode: searchFocusNode,
                  onChanged: (query) {
                    _fetchData(context);
                  },
                  hintText: 'Search by name or ID...',
                  suffixFunction: () {
                    searchController.clear();
                    _fetchData(context);
                  },
                )
              : const SizedBox.shrink(),
        ),

        // Active Filter Indicator
        ValueListenableBuilder(
          valueListenable: dateFilterNotifier,
          builder: (context, value, child) => value.hasActiveFilter
              ? _buildActiveFilterIndicator(context)
              : const SizedBox.shrink(),
        ),

        Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: () async => _fetchData(context),
            child: BlocBuilder<SalesListBloc, SalesListState>(
              builder: (context, state) => state.when(
                loading: () => const SalesListShimmer(),
                error: (error) => CustomErrorWidget(
                  errorText: error.toString(),
                  onRetry: () => _fetchData(context),
                ),
                loaded: (sales, nextPageUrl, isPaginating, _, _b, _a) {
                  if (sales.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 200 &&
                          !isPaginating &&
                          nextPageUrl != null) {
                        context.read<SalesListBloc>().add(
                              const SalesListEvent.getNextPageSales(),
                            );
                      }
                      return false;
                    },
                    child: ListView.builder(
                      padding: 12.padding,
                      itemCount: sales.length + (isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (isPaginating) {
                          return const SalesCardShimmer();
                        }
                        final sale = sales[index];
                        return SalesCard(
                          sale: sale,
                          onTap: () => onTapCard(context: context, sale: sale),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void onTapCard({
    required BuildContext context,
    required SaleModel sale,
  }) async {
    try {
      // final result = await context.pushNamed(
      //   AppRoutes.saleDetails.name,
      //   pathParameters: {'id': sale.id.toString()},
      // );
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => SaleDetailsBloc(repository: getIt.get())
              ..add(SaleDetailsEvent.getSaleDetails(saleId: sale.id)),
            child: SaleDetailsScreen(saleId: sale.id),
          ),
        ),
      );

      if (result == true) {
        _fetchData(context); // refresh data
      }
    } catch (e, stack) {
      log(
        'Error occurred while navigating to sale details: $e',
        stackTrace: stack,
      );
    }
  }

  Widget _buildActiveFilterIndicator(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.purple.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.purple),
        ),
        child: Row(
          children: [
            const Icon(Icons.filter_list, size: 16, color: AppColors.purple),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _getFilterDisplayText(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _clearDateFilter(context),
              child: Container(
                padding: 2.padding,
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.close, size: 14, color: AppColors.purple),
              ),
            ),
          ],
        ),
      );

  Widget _buildEmptyState(BuildContext context) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: context.screenHeight * 0.3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.task_alt_outlined,
                  size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                dateFilterNotifier.value.hasActiveFilter
                    ? 'No sales found for selected dates'
                    : 'No Sales',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              if (dateFilterNotifier.value.hasActiveFilter) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _clearDateFilter(context),
                  child: const Text('Clear filter to see all completed works'),
                ),
              ],
            ],
          ),
        ],
      );

  void _showDateFilterBottomSheet(BuildContext context) {
    showDateFilterBottomSheet(
      context: context,
      initialStartDate: dateFilterNotifier.value.startDate,
      initialEndDate: dateFilterNotifier.value.endDate,
      onDateFilterChanged: (startDate, endDate) {
        dateFilterNotifier.value = dateFilterNotifier.value.copyWith(
          startDate: startDate,
          endDate: endDate,
        );

        _fetchData(context);
      },
    );
  }

  void _fetchData(BuildContext context) {
    context.read<SalesListBloc>().add(
          SalesListEvent.getSales(
            fromDate: dateFilterNotifier.value.startDate?.format(reverse: true),
            toDate: dateFilterNotifier.value.endDate?.format(reverse: true),
            search: searchController.text.trim().isEmpty
                ? null
                : searchController.text.trim(),
          ),
        );
    // You'll need to modify your CompletedBookingsEvent to accept date parameters
  }

  void _clearDateFilter(BuildContext context) {
    dateFilterNotifier.value = const DateFilterModel();

    _fetchData(context);
  }

  String _getFilterDisplayText() {
    final startDate = dateFilterNotifier.value.startDate;
    final endDate = dateFilterNotifier.value.endDate;
    if (startDate != null && endDate != null) {
      if (startDate.isAtSameMomentAs(endDate)) {
        return 'Filtered by: ${startDate.format()}';
      } else {
        return 'Filtered by: ${startDate.format()} - ${endDate.format()}';
      }
    } else if (startDate != null) {
      return 'From: ${startDate.format()}';
    } else if (endDate != null) {
      return 'Until: ${endDate.format()}';
    }
    return 'Date filter active';
  }
}
