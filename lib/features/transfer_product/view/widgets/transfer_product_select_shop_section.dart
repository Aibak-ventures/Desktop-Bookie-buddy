import 'dart:developer';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
// import 'package:bookie_buddy_web/core/view_model/bloc_shop_list/shop_list_bloc.dart';
import 'package:bookie_buddy_web/features/main/widgets/shop_switcher_bottom_sheet.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/transfer_product_screen.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/widgets/show_shop_list_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferProductSelectShopSection extends StatelessWidget {
  final UserModel user;
  final ValueNotifier<ShopModel?> selectedShopNotifier;
  const TransferProductSelectShopSection({
    super.key,
    required this.user,
    required this.selectedShopNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final shop = user.shopDetails;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TransferProductTextTitle(text: 'From:'),
        6.height,
        ShopListItem(
          shop: ShopModel(
            id: shop.id,
            name: shop.name,
            phone: shop.phone,
            address: shop.address,
            image: shop.image,
          ),
          isSelected: false,
          onTap: null,
        ),
        16.height,
        const TransferProductTextTitle(text: 'To:'),
        6.height,
        Container(
          padding: 12.padding,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Shop'),
              Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ).onTap(
          () async {
            context.read<ShopListBloc>().add(const ShopListEvent.loadShops());
            final selectedShop = await showShopListBottomSheet(
              context,
              selectedShopId: selectedShopNotifier.value?.id,
            );

            log('selectedShop: $selectedShop');
            if (selectedShop != null) {
              selectedShopNotifier.value = selectedShop;
            }
          },
        ),
        6.height,
        ValueListenableBuilder(
            valueListenable: selectedShopNotifier,
            builder: (context, selectedShop, _) {
              return selectedShop == null
                  ? SizedBox(
                      height: 100.w,
                      child: Center(
                        child: Text(
                          'Shop not selected',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.redTomato,
                          ),
                        ),
                      ),
                    )
                  : ShopListItem(
                      shop: selectedShop,
                      isSelected: false,
                      onTap: null,
                    );
            }),
      ],
    );
  }
}
