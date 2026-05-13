import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_product_helpers.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';

class ProductMapper {
  static List<ProductSelectedEntity> fromBookedItems(
    List<ProductInfoEntity> bookedItems,
  ) {
    return bookedItems
        .map(BookingProductHelpers.fromBookedItem)
        .toList(growable: false);
  }

  static List<ProductSelectedEntity> syncStockFromAvailability({
    required List<ProductSelectedEntity> currentProducts,
    required List<ProductEntity> freshProducts,
  }) {
    return currentProducts.map((selectedProduct) {
      for (final freshProduct in freshProducts) {
        final matchingVariant = freshProduct.variants.firstWhere(
          (variant) => variant.id == selectedProduct.variant.variantId,
          orElse: () => const ProductVariantEntity(
            id: 0,
            attribute: '',
            stock: 0,
            remainingStock: null,
            price: null,
            salePrice: null,
          ),
        );

        if (matchingVariant.id != 0) {
          return selectedProduct.copyWith(
            variant: selectedProduct.variant.copyWith(
              stock: matchingVariant.stock,
              remainingStock: matchingVariant.remainingStock,
            ),
          );
        }
      }

      return selectedProduct;
    }).toList(growable: false);
  }

  static List<ProductSelectedEntity> updateMeasurements({
    required List<ProductSelectedEntity> currentProducts,
    required ProductSelectedEntity updatedProduct,
    required List<MeasurementValueEntity> measurements,
  }) {
    final index = currentProducts.indexWhere(
      (product) =>
          BookingProductHelpers.productKey(product) ==
          BookingProductHelpers.productKey(updatedProduct),
    );

    if (index == -1) return currentProducts;

    final updatedProducts = List<ProductSelectedEntity>.from(currentProducts);
    updatedProducts[index] = updatedProduct.copyWith(measurements: measurements);
    return updatedProducts;
  }
}