import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import '../../features/product/domain/entities/product_entity/product_entity.dart';
import '../extensions/string_extensions.dart';

/// Helper class for product-related field logic and display formatting.
///
/// Centralizes scattered service type-dependent logic from multiple files.
/// Use this instead of duplicating if-else chains across UI components.
class ProductFieldHelper {
  const ProductFieldHelper._();

  /// Get product specification details based on service type.
  ///
  /// Returns a record with type label and value for display in cards/tiles.
  ///
  /// Examples:
  ///   - Dress: ("Color", "Red")
  ///   - Vehicle: ("Reg. No", "ABC-123")
  ///   - Material: ("Category", "Cotton")
  static ({String type, String title}) getProductSpecification(
    MainServiceType? serviceType,
    ProductEntity product,
  ) {
    // Multi-variant products: Show color
    if (serviceType.isDressType) {
      return (type: serviceType.colorFieldLabel, title: product.color ?? '-');
    }

    // Vehicle
    if (serviceType.isVehicle) {
      return (
        type: 'Reg. No',
        title: product.effectiveRegistrationNumber ?? '',
      );
    }

    // default
    return (
      type: serviceType.categoryFieldLabel,
      title: product.category ?? '-',
    );
  }

  // ==================== Variant Display Formatting ====================

  /// Format variant attribute for display with appropriate label.
  ///
  /// Examples:
  /// - Dress: "Size: M"
  /// - Material: "Variant: Standard"
  static String getVariantDisplayText(
    MainServiceType? serviceType,
    String? variantValue,
  ) {
    if (variantValue == null || variantValue.isEmpty) return '-';
    return '${serviceType.variantAttributeLabel}: $variantValue';
  }

  /// Format secondary attribute (color/model) for display.
  ///
  /// Returns null if the service type doesn't use a secondary attribute.
  ///
  /// Examples:
  /// - Dress: "Color: Red"
  /// - Vehicle: "Model: Civic"
  static String? getSecondaryAttributeDisplayText(
    MainServiceType? serviceType,
    ProductEntity product,
  ) {
    final label = serviceType.secondaryAttributeLabel;
    if (label == null) return null;

    String? value;
    if (label == 'Color') {
      value = product.color;
    } else if (label == 'Model') {
      value = product.model;
    }

    if (value == null || value.isEmpty) return null;
    return '$label: $value';
  }

  /// Get the title text for the product selection dialog based on service type and selection context.
  static String getProductSelectDialogTitleText(
    MainServiceType? serviceType, {
    bool? isCustomWork,
  }) {
    if (serviceType.isRoom) return 'Room Price';
    if (isCustomWork == true) return 'Length & Price';
    if (serviceType.isSingleVariantProductType) return 'Quantity & Price';
    return 'Size & Amount';
  }

  // ==================== Product Details Rows ====================

  /// Build a list of detail strings for PDF/UI display.
  ///
  /// Automatically includes relevant fields based on service type:
  /// - Multi-variant: Color
  /// - Vehicle: Model + Brand
  /// - Material: Fabric Type
  /// - Others: Category
  ///
  /// Returns only non-null, non-empty values.
  ///
  /// Note: For variant-specific details (Size/Serial Number), pass the variant's
  /// attribute value separately using getVariantDisplayText().
  static List<String> buildProductDetailsRows(
    MainServiceType? serviceType,
    ProductEntity product,
  ) {
    final details = <String>[];

    // Secondary attribute (Color/Model)
    final secondary = getSecondaryAttributeDisplayText(serviceType, product);
    if (secondary != null) {
      details.add(secondary);
    }

    // Category (Brand/Fabric Type/Category)
    if ((serviceType.isVehicle ||
            serviceType.isOthers ||
            serviceType.isEquipment ||
            serviceType.isMaterial ||
            serviceType.isJewellery) &&
        product.category?.isNotEmpty == true) {
      details.add('${serviceType.categoryFieldLabel}: ${product.category}');
    }

    return details;
  }

  // ==================== Subtitle Line Selection ====================

  /// Ordered "Label: value" subtitle lines actually relevant for
  /// [serviceType] — the single source of truth for "what's worth showing
  /// for this product type" that [ProductSimpleDetailsTile] (a booking's
  /// product list tile) and the printed booking receipt both need. Kept
  /// here rather than duplicated per call site so the two can't quietly
  /// drift out of sync on which fields matter for which service type.
  ///
  /// Every parameter mirrors a `ProductSimpleDetailsTile` constructor
  /// param 1:1 — see that widget's (now-removed) per-row getters' history
  /// for the rationale behind each service type's specific field set and
  /// order, if it's ever unclear why one type shows different fields than
  /// another. Two additions beyond the tile's own params:
  /// - [includeQuantity]: pass `false` when the caller already shows
  ///   quantity/length in its own dedicated column (e.g. a receipt's item
  ///   table) and would otherwise duplicate it here too.
  /// - [includeLabels]: `true` (default) returns `"Label: value"` as the
  ///   tile needs; `false` returns just the bare value — for a tight
  ///   space like a receipt line where "Size: M · Color: Red" reads as
  ///   noisier than "M · Red" once the values alone are self-explanatory
  ///   in context.
  static List<String> getSubtitleLines({
    required MainServiceType? serviceType,
    String? type,
    String? variantAttribute,
    String? color,
    String? category,
    String? model,
    String? registrationNumber,
    required int quantity,
    double fabricLength = 0,
    bool needColor = true,
    bool showVariantWithType = false,
    bool includeQuantity = true,
    bool includeLabels = true,
    bool needFallbacks = true,
  }) {
    final effectiveType = serviceType ?? MainServiceType.other;

    // `null` means "omit this row entirely" — decided here, on whether
    // there's an actual value, not on whether the *formatted* string
    // happens to be non-empty. Deciding it after formatting was the bug:
    // an empty value with [includeLabels] on still formats to a non-empty
    // string like "Reg. No: " (label + colon + nothing), which would
    // survive a later `.isNotEmpty` check despite having no real value.
    String? line(String label, String? value, {bool fallback = true}) {
      if (value.isNullOrEmpty) {
        if (!needFallbacks || !fallback) return null;
        value = '-';
      }
      return includeLabels ? '$label: $value' : value;
    }

    String? variantRow() {
      if (!effectiveType.isMultiVariantProductType) return null;
      if (type != null) return line('Type', type);
      if (variantAttribute.isNullOrEmpty) {
        if (!needFallbacks) return null;
        // No label at all when there's nothing to label, same as
        // getVariantDisplayText — "Size: -" reads worse than a bare "-".
        return '-';
      }
      return line(effectiveType.variantAttributeLabel, variantAttribute);
    }

    String? colorRow() {
      if (!needColor) return null;
      if (!effectiveType.showsColorField) return null;
      return line(effectiveType.colorFieldLabel, color);
    }

    String? modelRow() {
      if (!effectiveType.isVehicle) return null;
      return line(effectiveType.modelFieldLabel, model);
    }

    String? regNoRow() {
      if (!effectiveType.isVehicle) return null;
      return line('Reg. No', registrationNumber, fallback: false);
    }

    String? categoryRow() {
      if (effectiveType.isVehicle) return null;
      if (!effectiveType.isSingleVariantProductType &&
          !effectiveType.isGadget) {
        return null;
      }
      return line(effectiveType.categoryFieldLabel, category);
    }

    String? sizeRow() {
      if (!showVariantWithType) return null;
      if (variantAttribute == null) return null;
      return line('Size', variantAttribute);
    }

    String? quantityRow() {
      if (!includeQuantity) return null;
      if (!effectiveType.showProductQuantityField) return null;
      return effectiveType.isProductWithLengthMeasurement
          ? line('Length', '$fabricLength', fallback: false)
          : line('Quantity', '$quantity', fallback: false);
    }

    final rows = switch (effectiveType) {
      MainServiceType.vehicle => [modelRow(), regNoRow(), quantityRow()],
      MainServiceType.room => [colorRow(), categoryRow()],
      MainServiceType.gadget => [variantRow(), categoryRow(), quantityRow()],
      MainServiceType.jewellery => [colorRow(), categoryRow(), quantityRow()],
      MainServiceType.material => [categoryRow(), quantityRow()],
      MainServiceType.equipment => [categoryRow(), quantityRow()],
      _ => [variantRow(), sizeRow(), colorRow(), categoryRow(), quantityRow()],
    };

    return rows.nonNulls.toList();
  }

  // ==================== Stock/Measurement Display ====================

  /// Format stock or measurement value for display.
  ///
  /// Examples:
  /// - Material: "5.5m" (fabric length)
  /// - Dress: "10 units" (stock count)
  /// - Vehicle: "2 units"
  static String formatStockDisplay(
    MainServiceType? serviceType,
    int? stock,
    double? fabricLength,
  ) {
    if (serviceType.isMaterial) {
      final length = fabricLength ?? 0;
      return length > 0 ? '${length} m' : '0 m';
    }

    final stockValue = stock ?? 0;
    return '$stockValue ${stockValue == 1 ? 'unit' : 'units'}';
  }

  /// Check if product is out of stock based on service type.
  ///
  /// For material: checks if fabricLength == 0
  /// For others: checks if stock == 0
  static bool isOutOfStock(
    MainServiceType? serviceType,
    int? stock,
    double? fabricLength,
  ) {
    if (serviceType.isMaterial) {
      return (fabricLength ?? 0) <= 0;
    }
    return (stock ?? 0) <= 0;
  }
}
