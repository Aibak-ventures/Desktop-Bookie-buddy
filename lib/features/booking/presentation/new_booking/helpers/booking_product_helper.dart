import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';

/// Helper class for managing product operations in booking screen
class BookingProductHelper {
  /// Increment product quantity
  static void incrementQuantity(
    ProductSelectedEntity product,
    List<ProductSelectedEntity> currentProducts,
    Function(List<ProductSelectedEntity>) updateProducts,
  ) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );
      updateProducts(products);
    }
  }

  /// Decrement product quantity (removes if quantity becomes 0)
  static void decrementQuantity(
    ProductSelectedEntity product,
    List<ProductSelectedEntity> currentProducts,
    Function(List<ProductSelectedEntity>) updateProducts,
  ) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index] = products[index].copyWith(
          quantity: products[index].quantity - 1,
        );
      } else {
        products.removeAt(index);
      }
      updateProducts(products);
    }
  }

  /// Update product price
  static void updateProductPrice(
    ProductSelectedEntity product,
    int newPrice,
    List<ProductSelectedEntity> currentProducts,
    Function(List<ProductSelectedEntity>) updateProducts,
  ) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      updateProducts(products);
    }
  }

  /// Remove product from list
  static void removeProduct(
    ProductSelectedEntity product,
    List<ProductSelectedEntity> currentProducts,
    Function(List<ProductSelectedEntity>) updateProducts,
  ) {
    final products = List<ProductSelectedEntity>.from(currentProducts);
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    updateProducts(products);
  }

  /// Calculate total from products
  static int calculateProductTotal(List<ProductSelectedEntity> products) {
    return products.fold<int>(
      0,
      (sum, item) => sum + (item.amount * item.quantity),
    );
  }

  /// Check if product already exists
  static bool isProductAlreadySelected(
    List<ProductSelectedEntity> products,
    int? variantId,
  ) {
    if (variantId == null) return false;
    return products.any((p) => p.variant.variantId == variantId);
  }
}
