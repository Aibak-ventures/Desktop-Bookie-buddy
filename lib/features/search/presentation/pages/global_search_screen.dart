import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/features/search/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/sales_card.dart';
import 'package:bookie_buddy_web/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/utils/responsive_widget.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/sales/presentation/pages/sale_details_screen.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/sale_details_bloc/sale_details_bloc.dart';
import 'package:bookie_buddy_web/features/search/domain/models/global_search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final searchController = TextEditingController();

  // Date filter state
  final dateFilterNotifier = ValueNotifier(const DateFilterModel());

  @override
  void initState() {
    super.initState();
    // Call clearSearchResults after the first frame when context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        clearSearchResults();
      }
    });
  }

  @override
  void dispose() {
    searchController.clear();
    dateFilterNotifier.dispose();
    super.dispose();
  }

  void clearSearchResults() {
    // Explicitly clear search results and text
    searchController.clear();
    context.read<SearchBloc>().add(const SearchEvent.reset());
  }

  void _performSearch() {
    final query = searchController.text.trim();
    final bloc = context.read<SearchBloc>();

    if (query.isNotEmpty || dateFilterNotifier.value.hasActiveFilter) {
      bloc.add(
        SearchEvent.search(
          query,
          startDate: dateFilterNotifier.value.startDate?.format(),
          endDate: dateFilterNotifier.value.endDate?.format(),
        ),
      );
    } else {
      clearSearchResults();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ResponsiveHelper.getValue(
          context,
          mobile: Colors.grey.shade50,
          tablet: Colors.grey.shade50,
          desktop: Colors.grey.shade50,
          largeDesktop: Colors.grey.shade50,
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            'Global Search',
            style: TextStyle(
              fontSize: ResponsiveHelper.getFontSize(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
                largeDesktop: 24,
              ),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1F2937),
            ),
          ),
          actions: [
            // Date Filter Button
            ValueListenableBuilder(
              valueListenable: dateFilterNotifier,
              builder: (context, value, child) => Container(
                decoration: BoxDecoration(
                  color: value.hasActiveFilter
                      ? AppColors.purple.withValues(alpha: 0.1)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: value.hasActiveFilter
                      ? Border.all(color: AppColors.purple)
                      : null,
                ),
                child: DateFilterButton(
                  hasActiveFilter: value.hasActiveFilter,
                  onTap: () => _showDateFilterBottomSheet(context),
                ),
              ),
            ),
            SizedBox(
              width: ResponsiveHelper.getSpacing(
                context,
                mobile: 16,
                tablet: 20,
                desktop: 24,
                largeDesktop: 24,
              ),
            ),
          ],
        ),
        body: ResponsiveWidget(
          mobile: _buildMobileLayout(context),
          tablet: _buildTabletLayout(context),
          desktop: _buildDesktopLayout(context),
          largeDesktop: _buildLargeDesktopLayout(context),
        ),
      );

  Widget _buildMobileLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: _buildSearchContent(context, maxSearchWidth: double.infinity),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: _buildSearchContent(context, maxSearchWidth: 650),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: _buildSearchContent(context, maxSearchWidth: 600),
        ),
      ),
    );
  }

  Widget _buildLargeDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: _buildSearchContent(context, maxSearchWidth: 700),
        ),
      ),
    );
  }

  Widget _buildSearchContent(BuildContext context,
      {required double maxSearchWidth}) {
    return Column(
      children: [
        // Hero Search Section
        Container(
          width: double.infinity,
          padding: ResponsiveHelper.getPadding(
            context,
            mobile: const EdgeInsets.all(20),
            tablet: const EdgeInsets.all(24),
            desktop: const EdgeInsets.all(28),
            largeDesktop: const EdgeInsets.all(32),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                AppColors.purple.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(
              ResponsiveHelper.getValue(
                context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
                largeDesktop: 22.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: ResponsiveHelper.getValue(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                  largeDesktop: 15.0,
                ),
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Search Icon & Title
              Icon(
                Icons.search,
                size: ResponsiveHelper.getValue(
                  context,
                  mobile: 28.0,
                  tablet: 32.0,
                  desktop: 36.0,
                  largeDesktop: 40.0,
                ),
                color: AppColors.purple,
              ),
              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                  largeDesktop: 14,
                ),
              ),

              Text(
                'Find Your Data',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 20,
                    tablet: 24,
                    desktop: 26,
                    largeDesktop: 28,
                  ),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 6,
                  tablet: 8,
                  desktop: 10,
                  largeDesktop: 12,
                ),
              ),

              Text(
                'Search by client name, staff name, or ID',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 15,
                    largeDesktop: 16,
                  ),
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 16,
                  tablet: 18,
                  desktop: 20,
                  largeDesktop: 22,
                ),
              ),

              // Enhanced Search Field
              Container(
                constraints: BoxConstraints(maxWidth: maxSearchWidth),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.getValue(
                      context,
                      mobile: 12.0,
                      tablet: 14.0,
                      desktop: 16.0,
                      largeDesktop: 18.0,
                    ),
                  ),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: ResponsiveHelper.getValue(
                        context,
                        mobile: 6.0,
                        tablet: 8.0,
                        desktop: 10.0,
                        largeDesktop: 12.0,
                      ),
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomSearchField(
                  searchController: searchController,
                  onChanged: (query) {
                    _performSearch();
                  },
                  padding: EdgeInsets.all(
                    ResponsiveHelper.getValue(
                      context,
                      mobile: 14.0,
                      tablet: 16.0,
                      desktop: 18.0,
                      largeDesktop: 20.0,
                    ),
                  ),
                  hintText: 'Enter client name, staff name, or ID...',
                  suffixFunction: () {
                    clearSearchResults();
                    _clearDateFilter();
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: ResponsiveHelper.getSpacing(
            context,
            mobile: 12,
            tablet: 14,
            desktop: 16,
            largeDesktop: 18,
          ),
        ),

        // Active Filter Indicator
        ValueListenableBuilder(
          valueListenable: dateFilterNotifier,
          builder: (context, value, child) => value.hasActiveFilter
              ? _buildActiveFilterIndicator(context, maxSearchWidth)
              : const SizedBox.shrink(),
        ),

        // Search Results Section
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              top: ResponsiveHelper.getSpacing(
                context,
                mobile: 8,
                tablet: 10,
                desktop: 12,
                largeDesktop: 14,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.getValue(
                  context,
                  mobile: 16.0,
                  tablet: 18.0,
                  desktop: 20.0,
                  largeDesktop: 22.0,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: ResponsiveHelper.getValue(
                    context,
                    mobile: 8.0,
                    tablet: 10.0,
                    desktop: 12.0,
                    largeDesktop: 15.0,
                  ),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                ResponsiveHelper.getValue(
                  context,
                  mobile: 16.0,
                  tablet: 18.0,
                  desktop: 20.0,
                  largeDesktop: 22.0,
                ),
              ),
              child: Padding(
                padding: ResponsiveHelper.getPadding(
                  context,
                  mobile: const EdgeInsets.all(16),
                  tablet: const EdgeInsets.all(18),
                  desktop: const EdgeInsets.all(20),
                  largeDesktop: const EdgeInsets.all(22),
                ),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) => state.when(
                    initial: () => _buildInitialState(context),
                    loading: () => const BookingListShimmer(itemCount: 6),
                    error: (error) => _buildErrorState(context, error),
                    loaded: (searchData, nextPageUrl, isPaginating) {
                      if (searchData.isEmpty) {
                        return _buildEmptyState(context);
                      }
                      return _buildSearchResults(
                        context,
                        searchData,
                        nextPageUrl,
                        isPaginating,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 40,
              tablet: 50,
              desktop: 60,
              largeDesktop: 70,
            ),
          ),
          Container(
            padding: ResponsiveHelper.getPadding(
              context,
              mobile: const EdgeInsets.all(20),
              tablet: const EdgeInsets.all(24),
              desktop: const EdgeInsets.all(28),
              largeDesktop: const EdgeInsets.all(32),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_outlined,
                  size: ResponsiveHelper.getValue(
                    context,
                    mobile: 40.0,
                    tablet: 48.0,
                    desktop: 56.0,
                    largeDesktop: 64.0,
                  ),
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 12,
                    tablet: 14,
                    desktop: 16,
                    largeDesktop: 18,
                  ),
                ),
                Text(
                  'Start typing to search',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 18,
                      largeDesktop: 20,
                    ),
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 6,
                    tablet: 8,
                    desktop: 10,
                    largeDesktop: 12,
                  ),
                ),
                Text(
                  'Use the search field above to find bookings, sales, or custom work by client name, staff name, or ID',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 11,
                      tablet: 12,
                      desktop: 13,
                      largeDesktop: 14,
                    ),
                    color: Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 40,
              tablet: 50,
              desktop: 60,
              largeDesktop: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 40,
              tablet: 50,
              desktop: 60,
              largeDesktop: 70,
            ),
          ),
          Icon(
            Icons.error_outline,
            size: ResponsiveHelper.getValue(
              context,
              mobile: 40.0,
              tablet: 48.0,
              desktop: 56.0,
              largeDesktop: 64.0,
            ),
            color: Colors.red.shade400,
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 12,
              tablet: 14,
              desktop: 16,
              largeDesktop: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              error,
              style: TextStyle(
                fontSize: ResponsiveHelper.getFontSize(
                  context,
                  mobile: 13,
                  tablet: 14,
                  desktop: 15,
                  largeDesktop: 16,
                ),
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
              largeDesktop: 22,
            ),
          ),
          ElevatedButton(
            onPressed: _performSearch,
            style: ElevatedButton.styleFrom(
              padding: ResponsiveHelper.getPadding(
                context,
                mobile:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                tablet:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                desktop:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                largeDesktop:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            child: const Text('Retry'),
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 40,
              tablet: 50,
              desktop: 60,
              largeDesktop: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final hasTextQuery = searchController.text.trim().isNotEmpty;
    final hasDateFilter = dateFilterNotifier.value.hasActiveFilter;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 30,
              tablet: 40,
              desktop: 50,
              largeDesktop: 60,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: ResponsiveHelper.getPadding(
              context,
              mobile: const EdgeInsets.all(24),
              tablet: const EdgeInsets.all(28),
              desktop: const EdgeInsets.all(32),
              largeDesktop: const EdgeInsets.all(36),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: ResponsiveHelper.getPadding(
                    context,
                    mobile: const EdgeInsets.all(12),
                    tablet: const EdgeInsets.all(14),
                    desktop: const EdgeInsets.all(16),
                    largeDesktop: const EdgeInsets.all(18),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    hasTextQuery || hasDateFilter
                        ? Icons.search_off
                        : Icons.inbox_outlined,
                    size: ResponsiveHelper.getValue(
                      context,
                      mobile: 36.0,
                      tablet: 42.0,
                      desktop: 48.0,
                      largeDesktop: 54.0,
                    ),
                    color: Colors.orange.shade400,
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 16,
                    tablet: 18,
                    desktop: 20,
                    largeDesktop: 22,
                  ),
                ),
                Text(
                  hasTextQuery || hasDateFilter
                      ? 'No Results Found'
                      : 'No Data',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                      largeDesktop: 22,
                    ),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                SizedBox(
                  height: ResponsiveHelper.getSpacing(
                    context,
                    mobile: 6,
                    tablet: 8,
                    desktop: 10,
                    largeDesktop: 12,
                  ),
                ),
                Text(
                  _getEmptyStateMessage(hasTextQuery, hasDateFilter),
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getFontSize(
                      context,
                      mobile: 12,
                      tablet: 13,
                      desktop: 14,
                      largeDesktop: 15,
                    ),
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (hasTextQuery || hasDateFilter) ...[
                  SizedBox(
                    height: ResponsiveHelper.getSpacing(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 20,
                      largeDesktop: 22,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      searchController.clear();
                      _clearDateFilter();
                    },
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text('Clear All Filters'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                      padding: ResponsiveHelper.getPadding(
                        context,
                        mobile: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        tablet: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        desktop: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        largeDesktop: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(
            height: ResponsiveHelper.getSpacing(
              context,
              mobile: 30,
              tablet: 40,
              desktop: 50,
              largeDesktop: 60,
            ),
          ),
        ],
      ),
    );
  }

  String _getEmptyStateMessage(bool hasTextQuery, bool hasDateFilter) {
    if (hasTextQuery && hasDateFilter) {
      return 'No results found for "${searchController.text}" in selected date range';
    } else if (hasTextQuery) {
      return 'No results found for "${searchController.text}"';
    } else if (hasDateFilter) {
      return 'No results found for selected dates';
    } else {
      return 'No results found';
    }
  }

  Widget _buildSearchResults(
    BuildContext context,
    List<GlobalSearchModel> searchData,
    String? nextPageUrl,
    bool isPaginating,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results Header
        Padding(
          padding: ResponsiveHelper.getPadding(
            context,
            mobile: const EdgeInsets.only(bottom: 16),
            tablet: const EdgeInsets.only(bottom: 18),
            desktop: const EdgeInsets.only(bottom: 20),
            largeDesktop: const EdgeInsets.only(bottom: 24),
          ),
          child: Row(
            children: [
              Icon(
                Icons.list_alt,
                size: ResponsiveHelper.getValue(
                  context,
                  mobile: 20.0,
                  tablet: 22.0,
                  desktop: 24.0,
                  largeDesktop: 26.0,
                ),
                color: AppColors.purple,
              ),
              SizedBox(
                width: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                  largeDesktop: 14,
                ),
              ),
              Text(
                'Search Results (${searchData.length} found)',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 16,
                    tablet: 17,
                    desktop: 18,
                    largeDesktop: 20,
                  ),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ],
          ),
        ),

        // Results List
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200 &&
                  !isPaginating &&
                  nextPageUrl != null) {
                context.read<SearchBloc>().add(
                      SearchEvent.loadNextSearchResults(
                        searchController.text.trim(),
                        startDate: dateFilterNotifier.value.startDate?.format(),
                        endDate: dateFilterNotifier.value.endDate?.format(),
                      ),
                    );
              }
              return false;
            },
            child: ListView.separated(
              key: const PageStorageKey('global-search-storage-key'),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: searchData.length + (nextPageUrl != null ? 1 : 0),
              separatorBuilder: (context, index) => SizedBox(
                height: ResponsiveHelper.getSpacing(
                  context,
                  mobile: 8,
                  tablet: 10,
                  desktop: 12,
                  largeDesktop: 14,
                ),
              ),
              itemBuilder: (context, index) {
                if (index < searchData.length) {
                  final data = searchData[index];
                  if (data.booking == null && data.sale == null) {
                    log('No booking, sale or custom work found');
                    return const SizedBox.shrink();
                  }

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        ResponsiveHelper.getValue(
                          context,
                          mobile: 12.0,
                          tablet: 14.0,
                          desktop: 16.0,
                          largeDesktop: 18.0,
                        ),
                      ),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: _buildSearchResultCard(context, data),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: BookingCardShimmer(),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResultCard(BuildContext context, GlobalSearchModel data) {
    switch (data.type) {
      case GlobalSearchType.booking:
        if (data.booking == null) return const SizedBox.shrink();
        return BookingCard(
          booking: data.booking!,
          onTap: () => _navigateToDetailsScreen(
            context,
            data.booking!.id!,
            data.type,
          ),
        );
      case GlobalSearchType.sale:
        if (data.sale == null) return const SizedBox.shrink();
        return SalesCard(
          sale: data.sale!,
          onTap: () => _navigateToDetailsScreen(
            context,
            data.sale!.id,
            data.type,
          ),
        );
    }
  }

  Widget _buildActiveFilterIndicator(
      BuildContext context, double maxSearchWidth) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: maxSearchWidth),
        margin: ResponsiveHelper.getPadding(
          context,
          mobile: const EdgeInsets.symmetric(vertical: 8),
          tablet: const EdgeInsets.symmetric(vertical: 10),
          desktop: const EdgeInsets.symmetric(vertical: 12),
          largeDesktop: const EdgeInsets.symmetric(vertical: 14),
        ),
        padding: ResponsiveHelper.getPadding(
          context,
          mobile: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          tablet: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          desktop: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          largeDesktop:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
        decoration: BoxDecoration(
          color: AppColors.purple.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(
            ResponsiveHelper.getValue(
              context,
              mobile: 8.0,
              tablet: 10.0,
              desktop: 12.0,
              largeDesktop: 14.0,
            ),
          ),
          border: Border.all(color: AppColors.purple),
        ),
        child: Row(
          children: [
            Icon(
              Icons.filter_list,
              size: ResponsiveHelper.getValue(
                context,
                mobile: 16.0,
                tablet: 18.0,
                desktop: 20.0,
                largeDesktop: 22.0,
              ),
              color: AppColors.purple,
            ),
            SizedBox(
              width: ResponsiveHelper.getSpacing(
                context,
                mobile: 8,
                tablet: 10,
                desktop: 12,
                largeDesktop: 14,
              ),
            ),
            Expanded(
              child: Text(
                _getFilterDisplayText(),
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(
                    context,
                    mobile: 12,
                    tablet: 13,
                    desktop: 14,
                    largeDesktop: 15,
                  ),
                  color: AppColors.purple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: _clearDateFilter,
              child: Container(
                padding: ResponsiveHelper.getPadding(
                  context,
                  mobile: const EdgeInsets.all(2),
                  tablet: const EdgeInsets.all(3),
                  desktop: const EdgeInsets.all(4),
                  largeDesktop: const EdgeInsets.all(5),
                ),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: ResponsiveHelper.getValue(
                    context,
                    mobile: 14.0,
                    tablet: 15.0,
                    desktop: 16.0,
                    largeDesktop: 17.0,
                  ),
                  color: AppColors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
        _performSearch();
      },
    );
  }

  void _clearDateFilter() {
    dateFilterNotifier.value = const DateFilterModel();
    _performSearch();
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

  void _navigateToDetailsScreen(
    BuildContext context,
    int id,
    GlobalSearchType type,
  ) {
    if (type.isSale) {
      context.read<SaleDetailsBloc>().add(
            SaleDetailsEvent.getSaleDetails(saleId: id),
          );
    }
    if (type.isBooking) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookingDetailsScreen(bookingId: id),
        ),
      );
    }
    if (type.isSale) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SaleDetailsScreen(saleId: id),
        ),
      );
    }
  }
}

class SearchScreenInitialAnimation extends StatelessWidget {
  const SearchScreenInitialAnimation({super.key});

  @override
  Widget build(BuildContext context) => RepaintBoundary(
        child: Lottie.asset(
          AppAssets.searchAnimation,
          height: context.mediaQueryHeight(0.2),
          width: context.mediaQueryWidth(0.45),
        ),
      );
}
