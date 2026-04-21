import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_product_row_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';

class BookingSelectedProductsListWidget extends StatelessWidget {
  final BookingFormControllers form;
  final BookingType selectedBookingType;
  final int Function() calculateRentalDays;
  final bool Function(MainServiceType? serviceType) shouldMultiplyByDays;
  final bool Function() hasAnyProductWithVariants;
  final void Function(ProductSelectedEntity product) onDecrement;
  final void Function(ProductSelectedEntity product) onIncrement;
  final void Function(ProductSelectedEntity product, String value)?
  onSaveTypedQuantity;
  final void Function(ProductSelectedEntity product) onStartEditingPrice;
  final void Function(ProductSelectedEntity product) onSaveEditingPrice;
  final void Function(ProductSelectedEntity product) onRemove;
  final TextEditingController Function(ProductSelectedEntity product)?
  getQuantityController;
  final FocusNode Function(int key)? getQuantityFocusNode;
  final int Function(ProductSelectedEntity product)? getQuantityKey;

  const BookingSelectedProductsListWidget({
    super.key,
    required this.form,
    required this.selectedBookingType,
    required this.calculateRentalDays,
    required this.shouldMultiplyByDays,
    required this.hasAnyProductWithVariants,
    required this.onDecrement,
    required this.onIncrement,
    this.onSaveTypedQuantity,
    required this.onStartEditingPrice,
    required this.onSaveEditingPrice,
    required this.onRemove,
    this.getQuantityController,
    this.getQuantityFocusNode,
    this.getQuantityKey,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
      valueListenable: form.selectedProductsNotifier,
      builder: (context, products, _) {
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 48,
                    color: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No items selected',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select a service and click on products to add them',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final isSales = selectedBookingType == BookingType.sales;
            final rentalDays = !isSales ? calculateRentalDays() : 0;
            final effectiveDaysMultiplier =
                (!isSales &&
                        shouldMultiplyByDays(product.variant.mainServiceType))
                ? (rentalDays > 0 ? rentalDays : 1)
                : 1;

            return BookingProductRowWidget(
              product: product,
              isSales: isSales,
              rentalDays: rentalDays,
              effectiveDaysMultiplier: effectiveDaysMultiplier,
              hasVariants: hasAnyProductWithVariants(),
              editingVariantId: form.editingVariantId,
              inlinePriceController: form.inlinePriceController,
              inlinePriceFocusNode: form.inlinePriceFocusNode,
              quantityController: getQuantityController?.call(product),
              quantityFocusNode: getQuantityFocusNode != null && getQuantityKey != null 
                  ? getQuantityFocusNode!(getQuantityKey!(product)) 
                  : null,
              onDecrement: () => onDecrement(product),
              onIncrement: () => onIncrement(product),
              onSaveTypedQuantity: onSaveTypedQuantity != null 
                  ? (value) => onSaveTypedQuantity!(product, value) 
                  : null,
              onStartEditingPrice: () => onStartEditingPrice(product),
              onSaveEditingPrice: () => onSaveEditingPrice(product),
              onRemove: () => onRemove(product),
            );
          },
        );
      },
    );
  }
}
