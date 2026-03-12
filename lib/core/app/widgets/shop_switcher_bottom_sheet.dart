import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
// import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/home/view_model/bloc_dashboard/dashboard_bloc.dart';
import 'package:bookie_buddy_web/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Future showAccountSwitcherBottomSheet(
  BuildContext context,
) {
  return showCustomBottomSheet(
    context,
    child: Padding(
      padding: 10.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ShopModel list
          Flexible(
            child: BlocConsumer<ShopListBloc, ShopListState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (error) => context.showSnackBar(
                    error,
                    isError: true,
                  ),
                  changeSuccess: (shop) async {
                    // Reload all essential data in order
                    context.read<UserCubit>().loadUserData();
                    context
                        .read<DashboardBloc>()
                        .add(const DashboardEvent.loadDashboardData());
                    context
                        .read<ServiceBloc>()
                        .add(const ServiceEvent.loadServices());

                    // Show a snackbar before screen resets
                    // if (context.mounted) {
                    Future.delayed(
                      const Duration(seconds: 4),
                      () {
                        context.showSnackBar(
                          'Shop switched to ${shop.name}',
                          isTitleVisible: false,
                        );
                      },
                    );
                    // }

                    // Navigate to splash screen
                    context.pushAndRemoveUntil(const SplashScreen());
                  },
                );
              },
              buildWhen: (previous, current) {
                return current.maybeWhen(
                  orElse: () => true,
                  changeSuccess: (_) => false,
                );
              },
              builder: (context, state) {
                return Container(
                  margin: 5.padding,
                  decoration: BoxDecoration(
                    borderRadius: 10.radiusBorder,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey200,
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: state.when(
                    changeSuccess: (_) => const SizedBox(),
                    loading: () => ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return const ShopListItemShimmer();
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                    error: (error) => SizedBox(
                      height: 0.3.heightR,
                      child: Center(
                        child: Text(error),
                      ),
                    ),
                    loaded: (shops, currentShopId) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: shops.length,
                        itemBuilder: (context, index) {
                          final shop = shops[index];
                          final isSelected = currentShopId == shop.id;

                          return ShopListItem(
                            shop: shop,
                            isSelected: isSelected,
                            onTap: () async {
                              if (currentShopId == shop.id) return;

                              // Change shop in state
                              context
                                  .read<ShopListBloc>()
                                  .add(ShopListEvent.changeAccount(shop));
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Safe area bottom padding
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    ),
  );
}

// Individual shop list item widget
class ShopListItem extends StatelessWidget {
  final ShopModel shop;
  final bool isSelected;
  final VoidCallback? onTap;

  const ShopListItem({
    Key? key,
    required this.shop,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: (10, 12).padding,
        child: Row(
          children: [
            // ShopModel image
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.purple : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ClipOval(
                child: shop.image != null
                    ? CustomNetworkImage(
                        imageUrl: shop.image!,
                        errorWidget: (context, url, error) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.store,
                              color: Colors.grey[400],
                              size: 24.sp,
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.store,
                          color: Colors.grey[400],
                          size: 24.sp,
                        ),
                      ),
              ),
            ),

            16.width,

            // ShopModel details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  2.height,
                  Text(
                    shop.address,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (shop.phone.isNotEmpty) ...[
                    2.height,
                    Text(
                      shop.phone,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Selected indicator
            if (isSelected)
              Container(
                padding: 4.padding,
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ShopListItemShimmer extends StatelessWidget {
  const ShopListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          children: [
            // Circular shimmer for image
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 16),

            // Text shimmers
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Shop name
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  // Address
                  Container(
                    width: 180,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 6),
                  // Phone
                  Container(
                    width: 100,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
