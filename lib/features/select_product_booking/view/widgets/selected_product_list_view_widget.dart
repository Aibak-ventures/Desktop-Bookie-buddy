import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/selected_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedProductListViewWidget extends StatelessWidget {
  const SelectedProductListViewWidget({
    required this.screenHeight,
    required this.gridPadding,
    required this.screenWidth,
    super.key,
  });

  final double screenHeight;
  final double gridPadding;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedProductsCubit, SelectedProductsState>(
      builder: (context, state) {
        return state.when(
          selected: (selectedProductsWithAmount) {
            print(
                'SelectedProductListViewWidget: Building with ${selectedProductsWithAmount.length} products');

            if (selectedProductsWithAmount.isEmpty) {
              return Container(
                height: 60,
                margin: (5, 10).padding,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(
                  child: Text(
                    'No products selected. Select products from the list below.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }

            return Container(
              width: double.infinity,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Products (${selectedProductsWithAmount.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedProductsWithAmount.length,
                      itemBuilder: (context, index) {
                        final serviceData = selectedProductsWithAmount[index];
                        final product = serviceData.variant;
                        final amount = serviceData.amount;

                        return SelectedProductCard(
                          imageUrl: product.image!,
                          price: amount.toCurrency(),
                          quantity: product.quantity,
                          size: product.variantAttribute ??
                              product.model ??
                              product.color ??
                              product.category ??
                              '',
                          productModel: serviceData,
                          onRemove: () {
                            print(
                                'Product remove button clicked: ${product.name}');
                            context
                                .read<SelectedProductsCubit>()
                                .removeSelectedProduct(
                                  product.variantId ?? product.id,
                                );
                          },
                          onCustomizationUpdate: () {
                            // Trigger a rebuild by refreshing the state
                            print('Customization updated for ${product.name}');
                            // The customization changes will be reflected automatically
                            // since the measurements are part of the ProductSelectedModel
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
