import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_helpers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/product_mapper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/product_stock_validator.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_shared/core/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';

class SelectedProductsMutationResult {
  final List<ProductSelectedEntity> products;
  final String? errorMessage;

  const SelectedProductsMutationResult._(this.products, this.errorMessage);

  const SelectedProductsMutationResult.success(
    List<ProductSelectedEntity> products,
  ) : this._(products, null);

  const SelectedProductsMutationResult.failure(
    List<ProductSelectedEntity> products,
    String errorMessage,
  ) : this._(products, errorMessage);

  bool get hasError => errorMessage != null;
}

class SelectedProductsManager {
  static SelectedProductsMutationResult addOrIncrementFromVariant({
    required List<ProductSelectedEntity> currentProducts,
    required ProductEntity product,
    required ProductVariantEntity variant,
    required BookingType bookingType,
  }) {
    final updatedProducts = List<ProductSelectedEntity>.from(currentProducts);
    final key = BookingProductHelpers.variantKey(variant);
    final index = updatedProducts.indexWhere(
      (item) => BookingProductHelpers.productKey(item) == key,
    );
    final availableStock = variant.remainingStock ?? variant.stock;

    if (index != -1) {
      final currentQuantity = updatedProducts[index].quantity;
      final newQuantity = currentQuantity + 1;

      if (!ProductStockValidator.canIncreaseQuantity(
        bookingType: bookingType,
        currentQuantity: currentQuantity,
        availableStock: availableStock,
      )) {
        return SelectedProductsMutationResult.failure(
          currentProducts,
          'Cannot add more. Available stock: $availableStock',
        );
      }

      updatedProducts[index] = updatedProducts[index].copyWith(
        quantity: newQuantity,
      );
      return SelectedProductsMutationResult.success(updatedProducts);
    }

    if (!ProductStockValidator.canAddVariant(
      bookingType: bookingType,
      availableStock: availableStock,
    )) {
      return SelectedProductsMutationResult.failure(
        currentProducts,
        'This item is out of stock',
      );
    }

    updatedProducts.add(
      BookingProductHelpers.buildSelectedProductFromVariant(
        product: product,
        variant: variant,
        bookingType: bookingType,
      ),
    );
    return SelectedProductsMutationResult.success(updatedProducts);
  }

  static List<ProductSelectedEntity> incrementQuantity({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity product,
    required BookingType bookingType,
  }) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index == -1) return currentProducts;

    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    if (!ProductStockValidator.canIncreaseQuantity(
      bookingType: bookingType,
      currentQuantity: products[index].quantity,
      availableStock: availableStock,
    )) {
      return currentProducts;
    }

    products[index] = products[index].copyWith(
      quantity: products[index].quantity + 1,
    );
    return products;
  }

  static List<ProductSelectedEntity> decrementQuantity({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity product,
  }) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index == -1) return currentProducts;

    if (products[index].quantity > 1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity - 1,
      );
    } else {
      products.removeAt(index);
    }
    return products;
  }

  static SelectedProductsMutationResult setQuantity({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity product,
    required int quantity,
    required BookingType bookingType,
  }) {
    if (quantity <= 0) {
      return SelectedProductsMutationResult.failure(
        currentProducts,
        'Quantity must be greater than 0',
      );
    }

    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    if (!ProductStockValidator.canSetQuantity(
      bookingType: bookingType,
      quantity: quantity,
      availableStock: availableStock,
    )) {
      return SelectedProductsMutationResult.failure(
        currentProducts,
        'Quantity cannot be greater than available stock ($availableStock)',
      );
    }

    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index == -1)
      return SelectedProductsMutationResult.success(currentProducts);

    products[index] = products[index].copyWith(quantity: quantity);
    return SelectedProductsMutationResult.success(products);
  }

  static List<ProductSelectedEntity> removeProduct({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity product,
  }) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    products.removeWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    return products;
  }

  static List<ProductSelectedEntity> updateProductPrice({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity product,
    required int newPrice,
  }) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index == -1) return currentProducts;

    products[index] = products[index].copyWith(amount: newPrice);
    return products;
  }

  static List<ProductSelectedEntity> updateMeasurements({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity updatedProduct,
    required List<MeasurementValueEntity> measurements,
  }) {
    return ProductMapper.updateMeasurements(
      currentProducts: currentProducts,
      updatedProduct: updatedProduct,
      measurements: measurements,
    );
  }

  static List<ProductSelectedEntity> syncStockFromAvailability({
    required List<ProductSelectedEntity> currentProducts,
    required List<ProductEntity> freshProducts,
  }) {
    return ProductMapper.syncStockFromAvailability(
      currentProducts: currentProducts,
      freshProducts: freshProducts,
    );
  }

  static List<ProductSelectedEntity> fromBookedItems(
    List<ProductInfoEntity> bookedItems,
  ) {
    return bookedItems
        .map(BookingProductHelpers.fromBookedItem)
        .toList(growable: false);
  }
}
