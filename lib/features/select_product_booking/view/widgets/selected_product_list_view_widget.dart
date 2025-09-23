import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/selected_product_card.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view_model/cubit_selected_products/selected_products_cubit.dart';
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
            return selectedProductsWithAmount.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    height: screenHeight * 0.1, // Responsive height
                    margin: (5, 10).padding,
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
                          onRemove: () {
                            print(
                                'Product remove button clicked: ${product.name}');
                            context
                                .read<SelectedProductsCubit>()
                                .removeSelectedProduct(
                                  product.variantId ?? product.id,
                                );
                          },
                        );
                      },
                    ),
                  );
          },
        );
      },
    );
  }
}
