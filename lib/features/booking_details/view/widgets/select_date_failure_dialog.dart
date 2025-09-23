import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<ProductSelectedModel> _getUnavailableProducts(
  List<int> unavailableProducts,
  ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier,
) {
  return selectedProductsNotifier.value
      .where(
        (selectedProduct) => unavailableProducts.any(
          (id) => id == selectedProduct.variant.variantId,
        ),
      )
      .toList();
}

// Show unavailable products dialog
Future<void> showUnavailableProductsDialog({
  required BuildContext context,
  required List<int> unavailableProducts,
  required ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier,
  required String? unavailableDate,
}) async {
  final unavailableSelectedProducts =
      _getUnavailableProducts(unavailableProducts, selectedProductsNotifier);

  if (unavailableSelectedProducts.isEmpty) {
    log('No unavailable products, showing snackbar, ${unavailableSelectedProducts.length}');
    // Show a simple message if no products are unavailable
    // context.showSnackBar('All selected products are available!');

    return;
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
          size: 30,
        ),
        title: Text(
          'Unavailable Products',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The product is booked for another customer on that date ${unavailableDate?.formatToUiDate() ?? ''}:',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: unavailableSelectedProducts.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final selectedProduct = unavailableSelectedProducts[index];
                    final product = selectedProduct.variant;
                    final mainServiceType = product.mainServiceType;
                    print('product: $product');
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomNetworkImage(
                              imageUrl: product.image ?? '',
                              height: 60,
                              width: 60,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Category: ${product.category?.isNotEmpty == true ? product.category : '-'}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  mainServiceType == null ||
                                          !mainServiceType.isDress
                                      ? 'Model: ${product.model ?? '-'}'
                                      : 'Size: ${product.variantAttribute ?? '-'}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Amount
                          Text(
                            selectedProduct.amount.toCurrency(decimalDigits: 0),
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.purple,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              selectedProductsNotifier.value = selectedProductsNotifier.value
                  .where(
                    (e) => unavailableSelectedProducts
                        .any((un) => e.variant.id != un.variant.id),
                  )
                  .toList();
              dialogContext.pop();
            },
            child: Text(
              'Remove ${unavailableSelectedProducts.length > 1 ? 'All' : 'Product'}',
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => dialogContext.pop(),
            child: const Text(
              'Keep Selected',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
