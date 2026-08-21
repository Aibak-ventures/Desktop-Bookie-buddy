import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';

enum MainServiceType {
  dress('dress'),
  vehicle('vehicle'),
  equipment('equipment'),
  material('material'),
  gadget('gadget'),
  costume('costume'),
  sale('sale'),
  jewellery('jewellery'),
  shoe('shoe'),
  bridal('bridal'),
  room('room'),
  other('other');

  final String value;
  const MainServiceType(this.value);

  static MainServiceType fromString(String? serviceName) {
    if (serviceName == null) return MainServiceType.other;
    final serviceType = serviceName.toLowerCase();

    for (final type in MainServiceType.values) {
      if (serviceType.contains(type.value)) {
        return type;
      }
    }
    return MainServiceType.other;
  }

  static String toJson(MainServiceType? type) =>
      type?.value ?? MainServiceType.other.value;

  /// Get MainServiceType from a list of ServiceEntity by serviceId.
  /// Returns `MainServiceType.other` if serviceId is null or not found.
  static MainServiceType fromServiceList(
    List<ServiceEntity> services,
    int? serviceId,
  ) {
    if (serviceId == null) return MainServiceType.other;
    for (final s in services) {
      if (s.id == serviceId) return fromString(s.mainServiceName);
    }
    return MainServiceType.other;
  }

  /// Get MainServiceType from a list of ServiceEntity by serviceId.
  /// Returns `null` if serviceId is null or not found.
  static MainServiceType? tryFromServiceList(
    List<ServiceEntity> services,
    int? serviceId,
  ) {
    if (serviceId == null) return null;
    for (final s in services) {
      if (s.id == serviceId) return fromString(s.mainServiceName);
    }
    return null;
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
  bool get isGadget => this == MainServiceType.gadget;
  bool get isRoom => this == MainServiceType.room;
  bool get isCostume => this == MainServiceType.costume;
  bool get isJewellery => this == MainServiceType.jewellery;
  bool get isShoe => this == MainServiceType.shoe;
  bool get isBridal => this == MainServiceType.bridal;
  bool get isOther => this == MainServiceType.other;

  /// Returns true for service types that support multi-variant product setup
  /// (dress sizes, costume sizes, shoe sizes, bridal sizes,)
  bool get needsVariantsSection => isDress || isCostume || isShoe || isBridal;

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
  bool get isMultiVariantProductType => isDressType;

  /// Check if each variant represents a unique unit (stock = 1 per variant)
  ///
  bool get hasUniqueVariantIdentifier => false;

  // For future use
  bool get showQuantityInDynamicFields => true;

  /// Get the label for the variant attribute field
  ///
  /// Examples:
  /// - Dress/Costume → "Size"
  /// - Vehicle → "Model"
  /// - Others → "Variant"
  String get variantAttributeLabel {
    if (isDress || isCostume) return 'Size';
    if (isVehicle) return 'Model';
    return 'Variant';
  }

  /// Get the label for the secondary attribute field (if applicable)
  ///
  /// Examples:
  /// - Dress/Costume → "Color"
  /// - Vehicle → "Model"
  String? get secondaryAttributeLabel {
    if (isDress || isCostume || isOther) return 'Color';
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
    if (isDressType) return 'Size';
    return 'Quantity';
  }

  // ==================== Field Labels ====================

  /// Get the label for the category field
  ///
  /// Examples:
  /// - Vehicle → "Brand"
  /// - Material → "Fabric Type"
  /// - Others → "Category"
  String get categoryFieldLabel {
    if (isVehicle) return 'Brand';
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
  /// Not required for: material (custom work may not need dates)
  bool get requiresDateRange =>
      isVehicle || isEquipment || isGadget || isCostume || isRoom;

  String get pickupLabel => isRoom ? 'Check-in' : 'Pickup';
  String get returnLabel => isRoom ? 'Check-out' : 'Return';
  String get pickupDateLabel => '$pickupLabel Date';
  String get returnDateLabel => '$returnLabel Date';
  String get pickupTimeLabel => '$pickupLabel Time';
  String get returnTimeLabel => '$returnLabel Time';

  String get rentalUnitTypeLabel => isRoom ? 'Duration Type' : 'Rental Type';

  String get clientNameType => isRoom ? 'Guest' : 'Client';

  /// "Shutter Count" / "Color"
  String get colorFieldLabel => switch (this) {
    MainServiceType.gadget => 'Shutter Count',
    MainServiceType.room => 'Bed Type',
    _ => 'Color',
  };

  /// "Year of Manufacture" / "Model"
  String get modelFieldLabel => switch (this) {
    MainServiceType.gadget => 'Year of Manufacture',
    MainServiceType.room => 'Max Occupancy',
    _ => 'Model',
  };

  bool get showCoolingPeriodField => !isRoom;

  /// Show the quantity field when adding/editing a product or booking.
  bool get showProductQuantityField => !isRoom;

  /// Show the color field on the product form.
  bool get showsColorField =>
      isMultiVariantProductType || isOther || isJewellery || isRoom;

  /// Show the model field on the product form.
  bool get showsModelField => isVehicle;
}
