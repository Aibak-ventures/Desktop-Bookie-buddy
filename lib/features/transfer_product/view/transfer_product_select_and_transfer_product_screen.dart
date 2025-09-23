import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/empty_data_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/transfer_product/view/widgets/transfer_product_tile.dart';
import 'package:bookie_buddy_web/features/transfer_product/view_model/bloc_matching_product/matching_product_bloc.dart';
import 'package:bookie_buddy_web/features/transfer_product/view_model/cubit/transfer_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferProductSelectAndTransferProductScreen extends StatelessWidget {
  final int fromVariantId;
  final int toShopId;
  final ProductInfoModel fromProduct;
  TransferProductSelectAndTransferProductScreen({
    super.key,
    required this.fromVariantId,
    required this.toShopId,
    required this.fromProduct,
  });

  final selectedProductNotifier = ValueNotifier<int?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Product'),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          _fetchProducts(context);
        },
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MatchingProductBloc, MatchingProductState>(
                builder: (context, state) {
                  return state.when(
                    error: (error) => CustomErrorWidget(
                      errorText: error,
                      onRetry: () {
                        _fetchProducts(context);
                      },
                    ),
                    loading: () => ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) =>
                          const TransferProductTileShimmer(),
                    ),
                    loaded: (
                      products,
                      fromVariantId,
                      toShopId,
                      nextPageUrl,
                      isPaginating,
                    ) {
                      if (products.isEmpty) {
                        return const EmptyDataWidget(
                          message: 'No similar product found in this shop',
                          isScrollable: true,
                          isShowIcon: false,
                          height: 0.8,
                        );
                      }
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (nextPageUrl != null &&
                              !isPaginating &&
                              scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 100) {
                            context.read<MatchingProductBloc>().add(
                                  const MatchingProductEvent
                                      .loadNextPageMatchingProducts(),
                                );
                          }
                          return false;
                        },
                        child: ValueListenableBuilder(
                          valueListenable: selectedProductNotifier,
                          builder: (context, selectedVariantId, child) {
                            return ListView.builder(
                              itemCount:
                                  products.length + (isPaginating ? 1 : 0),
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (index == products.length) {
                                  return const TransferProductTileShimmer();
                                }
                                final product = products[index];
                                final isSelected =
                                    product.id == selectedVariantId;
                                return TransferProductTile(
                                  product: product,
                                  isSelected: isSelected,
                                  onTap: () async {
                                    selectedProductNotifier.value = product.id;
                                  },
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            BlocListener<TransferProductCubit, TransferProductState>(
              listener: (context, state) {
                state.maybeWhen(
                  success: (message) {
                    log(message);
                    GlobalLoadingOverlay.hide();
                    context.push(SuccessScreen(
                      text: 'Transfer Success',
                      afterSuccess: () {
                        context.pop();
                        context.pop();
                        context.pop(true);
                      },
                    ));
                  },
                  failure: (message) {
                    log(message);
                    GlobalLoadingOverlay.hide();
                    context.showSnackBar(
                      message,
                      title: 'Transfer Failed',
                      isError: true,
                    );
                  },
                  transferring: () {
                    GlobalLoadingOverlay.show(context, text: 'Transferring...');
                  },
                  orElse: () {},
                );
              },
              child: Padding(
                padding: 16.paddingHorizontal,
                child: Column(
                  spacing: 10,
                  children: [
                    // Transfer as new product button
                    SizedBox(
                      height: 40.w,
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Create as New Product'),
                        onPressed: () async {
                          await showQuantitySelectionDialog(
                            context: context,
                            onConfirm: (transferQuantity) {
                              // if (transferQuantity == null) {
                              //   context.showSnackBar(
                              //     'Transfer quantity is required',
                              //     title: 'Quantity Required',
                              //     isError: true,
                              //   );
                              //   return;
                              // }
                              context
                                  .read<TransferProductCubit>()
                                  .transferProduct(
                                    fromVariantId: fromVariantId,
                                    toShopId: toShopId,
                                    transferQuantity: transferQuantity,
                                  );
                            },
                          );
                        },
                      ),
                    ),

                    // Transfer to selected product
                    BlocBuilder<MatchingProductBloc, MatchingProductState>(
                      builder: (context, state) {
                        final isVisible = state.maybeMap(
                          orElse: () => false,
                          loaded: (value) => value.products.isNotEmpty,
                        );
                        return Visibility(
                          visible: isVisible,
                          child: SizedBox(
                            height: 40.w,
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.swap_horiz),
                              label: const Text(
                                'Transfer to Selected Product',
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              onPressed: () async {
                                if (selectedProductNotifier.value == null) {
                                  context.showSnackBar(
                                    'Please select a product',
                                    title: 'Product Required',
                                    isError: true,
                                  );
                                  return;
                                }

                                await showQuantitySelectionDialog(
                                  context: context,
                                  onConfirm: (transferQuantity) {
                                    //  if (transferQuantity == null) {
                                    //   context.showSnackBar(
                                    //     'Transfer quantity is required',
                                    //     title: 'Quantity Required',
                                    //     isError: true,
                                    //   );
                                    //   return;
                                    // }
                                    context
                                        .read<TransferProductCubit>()
                                        .transferProduct(
                                          fromVariantId: fromVariantId,
                                          toShopId: toShopId,
                                          transferQuantity: transferQuantity,
                                          toProductId:
                                              selectedProductNotifier.value,
                                        );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    15.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchProducts(BuildContext context) {
    context.read<MatchingProductBloc>().add(
          MatchingProductEvent.loadMatchingProducts(
            fromVariantId: fromVariantId,
            toShopId: toShopId,
          ),
        );
  }

  Future<int?> showQuantitySelectionDialog({
    required BuildContext context,
    required void Function(int transferQuantity) onConfirm,
  }) async {
    final formKey = GlobalKey<FormState>();
    final quantityController = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text('Transfer Quantity'),
            content: Form(
              key: formKey,
              child: CustomTextField(
                controller: quantityController,
                label: 'Quantity',
                hintText: 'Transfer quantity',
                validator: (value) => AppInputValidators.quantity(
                  value,
                  maxValue: fromProduct.quantity,
                ),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final transferQuantity =
                        quantityController.text.toIntOrNull();
                    if (transferQuantity == null) {
                      return;
                    }
                    context.pop();
                    onConfirm(transferQuantity);
                  }
                },
                child: const Text(
                  'Transfer',
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ]);
      },
    );
  }
}
