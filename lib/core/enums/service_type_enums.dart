import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

enum MainServiceType {
  dress,
  vehicle,
  equipment,
  gadgets,
  material,
  room,
  costume,
  jewellery,
  shoes,
  bridal,
  others;

  static MainServiceType fromString(String? serviceName) {
    if (serviceName == null) return MainServiceType.others;

    final name = serviceName.toLowerCase();

    if (name.contains('dress')) return MainServiceType.dress;
    if (name.contains('vehicle')) return MainServiceType.vehicle;
    if (name.contains('equipment')) return MainServiceType.equipment;
    if (name.contains('gadget')) return MainServiceType.gadgets;
    if (name.contains('material')) return MainServiceType.material;
    if (name.contains('room')) return MainServiceType.room;
    if (name.contains('costume')) return MainServiceType.costume;
    if (name.contains('jewellery') || name.contains('jewelry'))
      return MainServiceType.jewellery;
    if (name.contains('shoe')) return MainServiceType.shoes;
    if (name.contains('bride') || name.contains('bridal'))
      return MainServiceType.bridal;

    return MainServiceType.others;
  }

  static MainServiceType fromServiceList(
    List<ServicesModel> services,
    int? serviceId,
  ) {
    if (serviceId == null) return MainServiceType.others;

    for (final service in services) {
      if (service.id == serviceId) {
        return fromString(service.mainServiceName);
      }
    }

    return MainServiceType.others;
  }
}

/// Extension methods for nullable MainServiceType enum
/// Extension methods for nullable MainServiceType enum
extension MainServiceTypeX on MainServiceType? {
  // ==================== Type Checkers ====================

  bool get isDress => this == MainServiceType.dress;
  bool get isVehicle => this == MainServiceType.vehicle;
  bool get isEquipment => this == MainServiceType.equipment;
  bool get isMaterial => this == MainServiceType.material;
  bool get isGadget => this == MainServiceType.gadgets;
  bool get isRoom => this == MainServiceType.room;
  bool get isCostume => this == MainServiceType.costume;
  bool get isJewellery => this == MainServiceType.jewellery;
  bool get isShoes => this == MainServiceType.shoes;
  bool get isBridal => this == MainServiceType.bridal;
  bool get isOthers => this == MainServiceType.others;

  /// Returns true for service types that support multi-variant product setup
  /// (dress sizes, costume sizes, shoe sizes, bridal sizes)
  bool get needsVariantsSection =>
      isDress || isCostume || isShoes || isBridal;

  // ==================== Variant Management ====================

  /// Check if the product is of dress or costume type
  bool get isDressType => isDress || isCostume;

  /// Check if the product is of customizable type (dress/costume or vehicle)
  bool get isCustomizableProductType => isDressType || isVehicle;

  /// Check if the product will only have a single variant in product details
  bool get isSingleVariantProductType => !isMultiVariantProductType;

  /// Check if the product can have multiple variants in product details
  ///
  /// Multi-variant types:
  /// - Dress/Costume: Multiple sizes with quantities
  /// - Gadget: Multiple serial numbers (1 unit each)
  bool get isMultiVariantProductType =>
      this == MainServiceType.dress ||
      this == MainServiceType.costume ||
      this == MainServiceType.gadgets;

  /// Check if each variant represents a unique unit (stock = 1 per variant)
  ///
  /// True for gadgets where each serial number = one unique item.
  /// False for dress/costume where each size can have multiple units.
  bool get hasUniqueVariantIdentifier => isGadget;

  /// Get the label for the variant attribute field
  ///
  /// Examples:
  /// - Dress/Costume → "Size"
  /// - Gadget → "Serial Number"
  /// - Vehicle → "Model"
  /// - Others → "Variant"
  String get variantAttributeLabel {
    if (isDress || isCostume) return 'Size';
    if (isGadget) return 'Serial Number';
    if (isVehicle) return 'Model';
    return 'Variant';
  }

  /// Get the label for the secondary attribute field (if applicable)
  ///
  /// Examples:
  /// - Dress/Costume → "Color"
  /// - Vehicle → "Model"
  /// - Others → null (no secondary attribute)
  String? get secondaryAttributeLabel {
    if (isDress || isCostume || isOthers) return 'Color';
    if (isVehicle) return 'Model';
    return null;
  }

  // ==================== Measurement & Quantity ====================

  /// Check if product uses quantity-based measurement
  bool get isProductWithQuantityMeasurement => !isProductWithLengthMeasurement;

  /// Check if product uses length-based measurement (meters)
  bool get isProductWithLengthMeasurement => isMaterial;

  /// Get the label for the quantity/measurement field
  ///
  /// Examples:
  /// - Vehicle → "Unit"
  /// - Material → "Length (in meters)"
  /// - Others → "Quantity"
  String get quantityFieldLabel {
    if (isVehicle) return 'Unit';
    if (isMaterial) return 'Length (in meters)';
    if (isDress || isCostume) return 'Size';
    return 'Quantity';
  }

  // ==================== Field Labels ====================

  /// Get the label for the category field
  ///
  /// Examples:
  /// - Vehicle → "Brand"
  /// - Gadget → "Serial Number"
  /// - Material → "Fabric Type"
  /// - Others → "Category"
  String get categoryFieldLabel {
    if (isVehicle) return 'Brand';
    // if (isGadget) return 'Serial Number';
    if (isMaterial) return 'Fabric Type';
    return 'Category';
  }

  /// Get the label for the product name field
  ///
  /// Examples:
  /// - Vehicle → "Vehicle"
  /// - Material → "Material"
  /// - Others → "Product"
  String get productNameLabel {
    if (isVehicle) return 'Vehicle';
    if (isMaterial) return 'Material';
    return 'Product';
  }

  // ==================== UI Display Rules ====================

  /// Check if this service type requires date range for bookings
  ///
  /// Required for: vehicle, equipment, gadget, costume, room
  /// Not required for: material (custom work
}
