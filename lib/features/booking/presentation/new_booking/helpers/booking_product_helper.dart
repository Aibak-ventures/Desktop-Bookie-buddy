import 'package:bookie_buddy_web/features/select_product_booking/domain/models/product_selected_model/product_selected_model.dart';

/// Helper class for managing product operations in booking screen
class BookingProductHelper {
  /// Increment product quantity
  static void incrementQuantity(
    ProductSelectedModel product,
    List<ProductSelectedModel> currentProducts,
    Function(List<ProductSelectedModel>) updateProducts,
  ) {
    final products = List<ProductSelectedModel>.from(currentProducts);
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
    ProductSelectedModel product,
    List<ProductSelectedModel> currentProducts,
    Function(List<ProductSelectedModel>) updateProducts,
  ) {
    final products = List<ProductSelectedModel>.from(currentProducts);
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
    ProductSelectedModel product,
    int newPrice,
    List<ProductSelectedModel> currentProducts,
    Function(List<ProductSelectedModel>) updateProducts,
  ) {
    final products = List<ProductSelectedModel>.from(currentProducts);
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
    ProductSelectedModel product,
    List<ProductSelectedModel> currentProducts,
    Function(List<ProductSelectedModel>) updateProducts,
  ) {
    final products = List<ProductSelectedModel>.from(currentProducts);
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    updateProducts(products);
  }

  /// Calculate total from products
  static int calculateProductTotal(List<ProductSelectedModel> products) {
    return products.fold<int>(
      0,
      (sum, item) => sum + (item.amount * item.quantity),
    );
  }

  /// Check if product already exists
  static bool isProductAlreadySelected(
    List<ProductSelectedModel> products,
    int? variantId,
  ) {
    if (variantId == null) return false;
    return products.any((p) => p.variant.variantId == variantId);
  }
}
