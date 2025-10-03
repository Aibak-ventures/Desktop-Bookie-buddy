import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/transfer_product_select_and_transfer_product_screen.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/widgets/transfer_product_select_shop_section.dart';
import 'package:bookie_buddy_web/features/transfer_product/view_model/bloc_matching_product/matching_product_bloc.dart';
import 'package:bookie_buddy_web/features/transfer_product/view_model/cubit_transfer_product/transfer_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TransferProductScreen extends StatefulWidget {
  final int serviceId;
  final ProductModel product;
  final int variantId;
  final MainServiceType mainServiceType;

  const TransferProductScreen({
    super.key,
    required this.serviceId,
    required this.product,
    required this.variantId,
    required this.mainServiceType,
  });

  @override
  State<TransferProductScreen> createState() => _TransferProductScreenState();
}

class _TransferProductScreenState extends State<TransferProductScreen> {
  // controllers
  final quantityController = TextEditingController();

  // notifiers
  final selectedShopNotifier = ValueNotifier<ShopModel?>(null);

  @override
  void dispose() {
    super.dispose();

    // controllers
    quantityController.dispose();

    // notifiers
    selectedShopNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserCubit>().state!;
    final productVariant = widget.product.variants.firstWhere(
      (element) => element.id == widget.variantId,
    );
    final currentVariant = ProductInfoModel(
      id: widget.product.id,
      productId: widget.product.id,
      variantId: widget.variantId,
      name: widget.product.name,
      image: widget.product.image,
      quantity: productVariant.stock,
      amount: widget.product.price ?? 0,
      category: widget.product.category,
      color: widget.product.color,
      variantAttribute: productVariant.attribute,
      model: widget.product.model,
      mainServiceType: widget.mainServiceType,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Transfer Product')),
      body: Padding(
        padding: 16.padding,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    TransferProductSelectShopSection(
                      user: user,
                      selectedShopNotifier: selectedShopNotifier,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TransferProductTextTitle(text: 'Current Product'),
                        6.height,
                        ProductSimpleDetailsTile(
                          mainServiceType: currentVariant.mainServiceType,
                          name: currentVariant.name,
                          quantity: currentVariant.quantity,
                          category: currentVariant.category,
                          color: currentVariant.color,
                          image: currentVariant.image,
                          model: currentVariant.model,
                          variantAttribute: currentVariant.variantAttribute,
                          amount: currentVariant.amount == 0
                              ? null
                              : currentVariant.amount,
                          trailing: Text(
                            'No Price',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45.h,
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(LucideIcons.search),
                onPressed: () {
                  if (selectedShopNotifier.value == null) {
                    context.showSnackBar(
                      'Please select a shop',
                      title: 'Shop error',
                      isError: true,
                    );
                    return;
                  }

                  context.push(
                    MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              MatchingProductBloc(repository: getIt.get())..add(
                                MatchingProductEvent.loadMatchingProducts(
                                  fromVariantId: widget.variantId,
                                  toShopId: selectedShopNotifier.value!.id,
                                ),
                              ),
                        ),
                        BlocProvider(
                          create: (context) =>
                              TransferProductCubit(repository: getIt.get()),
                        ),
                      ],
                      child: TransferProductSelectAndTransferProductScreen(
                        fromVariantId: widget.variantId,
                        toShopId: selectedShopNotifier.value!.id,
                        fromProduct: currentVariant,
                      ),
                    ),
                  );
                },
                label: const Text(
                  'Find Matching Product',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransferProductTextTitle extends StatelessWidget {
  final String text;
  const TransferProductTextTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
  );
}
