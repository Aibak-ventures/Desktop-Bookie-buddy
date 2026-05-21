import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';

class BookingProductHelpers {
  static int productKey(ProductSelectedEntity product) {
    return product.variant.variantId ?? product.variant.id;
  }

  static int variantKey(ProductVariantEntity variant) {
    return variant.id;
  }

  static bool isSales(BookingType bookingType) {
    return bookingType == BookingType.sales;
  }

  static bool isOldBooking(BookingType bookingType) {
    return bookingType == BookingType.oldBooking;
  }

  static int resolveVariantPrice({
    required ProductEntity product,
    required ProductVariantEntity variant,
    required BookingType bookingType,
  }) {
    if (isSales(bookingType)) {
      final productSalePrice = product.salePrice == null
          ? null
          : double.tryParse(product.salePrice!)?.toInt();
      return variant.salePrice ??
          productSalePrice ??
          variant.price ??
          product.price ??
          0;
    }

    return variant.price ?? product.price ?? 0;
  }

  static String resolveVariantAttribute({
    required ProductEntity product,
    required ProductVariantEntity variant,
  }) {
    return variant.attribute.isEmpty ? (product.model ?? '') : variant.attribute;
  }

  static ProductSelectedEntity buildSelectedProductFromVariant({
    required ProductEntity product,
    required ProductVariantEntity variant,
    required BookingType bookingType,
  }) {
    return ProductSelectedEntity(
      variant: ProductInfoEntity(
        id: variant.id,
        variantId: variant.id,
        productId: product.id,
        name: product.name,
        image: product.image,
        thumbnailImage: product.thumbnailImage,
        mainServiceType: product.mainServiceType,
        variantAttribute: resolveVariantAttribute(product: product, variant: variant),
        measurements: const [],
        quantity: 1,
        amount: resolveVariantPrice(
          product: product,
          variant: variant,
          bookingType: bookingType,
        ),
        stock: variant.stock,
        remainingStock: variant.remainingStock,
        color: product.color,
        category: product.category,
        model: product.model,
      ),
      measurements: const [],
      quantity: 1,
      amount: resolveVariantPrice(
        product: product,
        variant: variant,
        bookingType: bookingType,
      ),
    );
  }

  static ProductSelectedEntity fromBookedItem(ProductInfoEntity item) {
    return ProductSelectedEntity(
      variant: item.copyWith(),
      measurements: item.measurements,
      quantity: item.quantity,
      amount: item.quantity > 0 ? item.amount ~/ item.quantity : item.amount,
    );
  }
}