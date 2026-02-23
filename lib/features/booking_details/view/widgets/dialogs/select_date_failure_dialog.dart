import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
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
) =>
    selectedProductsNotifier.value
        .where(
          (selectedProduct) => unavailableProducts.any(
            (id) => id == selectedProduct.variant.variantId,
          ),
        )
        .toList();

// Show unavailable products dialog
Future<void> showUnavailableProductsDialog({
  required BuildContext context,
  required String? unavailableDateFrom,
  required String? unavailableDateTo,
  required List<int> unavailableProducts,
  required ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier,
}) async {
  final unavailableSelectedProducts = _getUnavailableProducts(
    unavailableProducts,
    selectedProductsNotifier,
  );

  if (unavailableSelectedProducts.isEmpty) {
    log(
      'No unavailable products, showing snackbar, ${unavailableSelectedProducts.length}',
    );
    // Show a simple message if no products are unavailable
    // context.showSnackBar('All selected products are available!');

    return;
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext dialogContext) => Dialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 700,     // 👈 web-friendly width
      maxHeight: 520,    // 👈 prevents full screen takeover
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= Header =================
          Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Unavailable Products',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () => dialogContext.pop(),
              //   icon: const Icon(Icons.close),
              // ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            'The product is already booked on '
            '${unavailableDateFrom != null && unavailableDateTo != null
                ? '${unavailableDateFrom.formatToUiDate()} - ${unavailableDateTo.formatToUiDate()}'
                : unavailableDateFrom?.formatToUiDate() ?? ''}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16.sp,
            ),
          ),

          const SizedBox(height: 16),
          const Divider(),

          // ================= Product List =================
          Expanded(
            child: ListView.separated(
              itemCount: unavailableSelectedProducts.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final selectedProduct = unavailableSelectedProducts[index];
                final product = selectedProduct.variant;
                final mainServiceType = product.mainServiceType;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomNetworkImage(
                          imageUrl: product.image ?? '',
                          height: 64,
                          width: 64,
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
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
                              mainServiceType == null || !mainServiceType.isDress
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

                      const SizedBox(width: 12),

                      Text(
                        selectedProduct.amount.toCurrency(),
                        style: TextStyle(
                          fontSize: 14.sp,
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

          const Divider(),

          // ================= Actions =================
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  selectedProductsNotifier.value =
                      selectedProductsNotifier.value
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
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => dialogContext.pop(),
                child: const Text('Keep Selected',style: TextStyle(color: Colors.white) ,),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
)
  );
}
