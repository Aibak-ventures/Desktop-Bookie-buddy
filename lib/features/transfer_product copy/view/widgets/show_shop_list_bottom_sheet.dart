import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/features/main/widgets/shop_switcher_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<ShopModel?> showShopListBottomSheet(
  BuildContext context, {
  int? selectedShopId,
}) => showCustomBottomSheet(
    context,
    isDraggable: false,
    child: BlocBuilder<ShopListBloc, ShopListState>(
      buildWhen: (previous, current) => current.maybeWhen(
          orElse: () => true,
          changeSuccess: (_) => false,
        ),
      builder: (context, state) => Container(
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
          child: state.maybeWhen(
            orElse: () => const SizedBox(),
            loading: () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: 3,
              itemBuilder: (context, index) => const ShopListItemShimmer(),
              separatorBuilder: (context, index) => const Divider(),
            ),
            error: (error) => SizedBox(
              height: 0.3.heightR,
              child: Center(
                child: Text(error),
              ),
            ),
            loaded: (fullShopList, currentShopId) {
              final shops = fullShopList
                  .where((shop) => shop.id != currentShopId)
                  .toList();
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: 8.paddingVertical,
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  final isSelected = selectedShopId == shop.id;

                  return ShopListItem(
                    shop: shop,
                    isSelected: isSelected,
                    onTap: () async {
                      if (currentShopId == shop.id) return;
                      context.pop(shop);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            },
          ),
        ),
    ),
  );
