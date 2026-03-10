import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/profile/view/widgets/shop_activity_card.dart';
import 'package:bookie_buddy_web/features/profile/view_model/cubit_shop_activity_log/shop_activity_log_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopActivityLogScreen extends StatelessWidget {
  const ShopActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Shop Activities')),
        body: RefreshIndicator.adaptive(
          onRefresh: () => _refresh(context),
          child: Padding(
            padding: 8.paddingHorizontal,
            child: BlocBuilder<ShopActivityLogCubit, ShopActivityLogState>(
              builder: (context, state) => state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (activities, nextPageUrl, isPaginating) {
                  if (activities.isEmpty) {
                    return _buildEmptyState();
                  }

                  return NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                              scrollInfo.metrics.maxScrollExtent - 200 &&
                          nextPageUrl != null &&
                          !isPaginating) {
                        context.read<ShopActivityLogCubit>().loadNextPage();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      key: const PageStorageKey('shop-activity-log-list'),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: activities.length + (isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < activities.length) {
                          final activity = activities[index];
                          return ShopActivityCard(activity: activity);
                        } else {
                          // Show loading indicator for pagination
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
                error: (error) => CustomErrorWidget(
                  errorText: error,
                  onRetry: () => _refresh(context),
                ),
              ),
            ),
          ),
        ),
      );

  /// Build empty state widget
  Widget _buildEmptyState() => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
              height: MediaQuery.of(navigatorKey.currentContext!).size.height *
                  0.3),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history_rounded,
                  size: 64.sp, color: Colors.grey.shade400),
              SizedBox(height: 16.h),
              Text(
                'No activities yet',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Activity summary will appear here once you start using your shop.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      );

  /// Refresh shop activity log data
  Future<void> _refresh(BuildContext context) async {
    await context.read<ShopActivityLogCubit>().loadShopActivities();
  }
}
