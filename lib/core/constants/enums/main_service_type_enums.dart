// import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

// enum MainServiceType {
//   dress('dress'),
//   vehicle('vehicle'),
//   equipment('equipment'),
//   material('material'),
//   gadget('gadget'),
//   room('room'),
//   other('other'),
//   costume('costume');

//   final String value;
//   const MainServiceType(this.value);

//   static MainServiceType fromString(String? serviceName) {
//     if (serviceName == null) return MainServiceType.other;
//     final serviceType = serviceName.toLowerCase();

//     for (final type in MainServiceType.values) {
//       if (serviceType.contains(type.value)) {
//         return type;
//       }
//     }
//     return MainServiceType.other;
//   }

//   static String toJson(MainServiceType? type) =>
//       type?.value ?? MainServiceType.other.value;

//   /// Get MainServiceType from a list of ServicesModel by serviceId
//   ///
//   /// Returns `MainServiceType.other` if serviceId is null or not found
//   static MainServiceType fromServiceList(
//     List<ServicesModel> services,
//     int? serviceId,
//   ) {
//     if (serviceId == null) {
//       return MainServiceType.other;
//     }
//     for (final s in services) {
//       if (s.id == serviceId) {
//         return fromString(s.mainServiceName);
//       }
//     }
//     return MainServiceType.other;
//   }

//   /// Try to get MainServiceType from a list of ServicesModel by serviceId
//   ///
//   /// Returns `null` if serviceId is null or not found
//   static MainServiceType? tryFromServiceList(
//     List<ServicesModel> services,
//     int? serviceId,
//   ) {
//     if (serviceId == null) {
//       return null;
//     }
//     for (final s in services) {
//       if (s.id == serviceId) {
//         return fromString(s.mainServiceName);
//       }
//     }
//     return null;
//   }
// }

// /// Extension methods for nullable MainServiceType enum
// /// Extension methods for nullable MainServiceType enum
// extension MainServiceTypeX on MainServiceType? {
//   // ==================== Type Checkers ====================

//   bool get isDress => this == MainServiceType.dress;
//   bool get isVehicle => this == MainServiceType.vehicle;
//   bool get isEquipment => this == MainServiceType.equipment;
//   bool get isMaterial => this == MainServiceType.material;
//   bool get isGadget => this == MainServiceType.gadget;
//   bool get isRoom => this == MainServiceType.room;
//   bool get isCostume => this == MainServiceType.costume;
//   bool get isOthers => this == MainServiceType.other;

//   // ==================== Variant Management ====================

//   /// Check if the product is of dress or costume type
//   bool get isDressType => isDress || isCostume;

//   /// Check if the product is of customizable type (dress/costume or vehicle)
//   bool get isCustomizableProductType => isDressType || isVehicle;

//   /// Check if the product will only have a single variant in product details
//   bool get isSingleVariantProductType => !isMultiVariantProductType;

//   /// Check if the product can have multiple variants in product details
//   ///
//   /// Multi-variant types:
//   /// - Dress/Costume: Multiple sizes with quantities
//   /// - Gadget: Multiple serial numbers (1 unit each)
//   bool get isMultiVariantProductType =>
//       this == MainServiceType.dress ||
//       this == MainServiceType.costume ||
//       this == MainServiceType.gadget;

//   /// Check if each variant represents a unique unit (stock = 1 per variant)
//   ///
//   /// True for gadgets where each serial number = one unique item.
//   /// False for dress/costume where each size can have multiple units.
//   bool get hasUniqueVariantIdentifier => isGadget;

//   /// Get the label for the variant attribute field
//   ///
//   /// Examples:
//   /// - Dress/Costume → "Size"
//   /// - Gadget → "Serial Number"
//   /// - Others → "Variant"
//   String get variantAttributeLabel {
//     if (isDress || isCostume) return 'Size';
//     if (isGadget) return 'Serial Number';
//     return 'Variant';
//   }

//   /// Get the label for the secondary attribute field (if applicable)
//   ///
//   /// Examples:
//   /// - Dress/Costume → "Color"
//   /// - Vehicle → "Model"
//   /// - Others → null (no secondary attribute)
//   String? get secondaryAttributeLabel {
//     if (isDress || isCostume || isOthers) return 'Color';
//     if (isVehicle) return 'Model';
//     return null;
//   }

//   // ==================== Measurement & Quantity ====================

//   /// Check if product uses quantity-based measurement
//   bool get isProductWithQuantityMeasurement => !isProductWithLengthMeasurement;

//   /// Check if product uses length-based measurement (meters)
//   bool get isProductWithLengthMeasurement => isMaterial;

//   /// Get the label for the quantity/measurement field
//   ///
//   /// Examples:
//   /// - Vehicle → "Unit"
//   /// - Material → "Length (in meters)"
//   /// - Others → "Quantity"
//   String get quantityFieldLabel {
//     if (isVehicle) return 'Unit';
//     if (isMaterial) return 'Length (in meters)';
//     return 'Quantity';
//   }

//   // ==================== Field Labels ====================

//   /// Get the label for the category field
//   ///
//   /// Examples:
//   /// - Vehicle → "Brand"
//   /// - Gadget → "Serial Number"
//   /// - Material → "Fabric Type"
//   /// - Others → "Category"
//   String get categoryFieldLabel {
//     if (isVehicle) return 'Brand';
//     // if (isGadget) return 'Serial Number';
//     if (isMaterial) return 'Fabric Type';
//     return 'Category';
//   }

//   /// Get the label for the product name field
//   ///
//   /// Examples:
//   /// - Vehicle → "Vehicle"
//   /// - Material → "Material"
//   /// - Others → "Product"
//   String get productNameLabel {
//     if (isVehicle) return 'Vehicle';
//     if (isMaterial) return 'Material';
//     return 'Product';
//   }

//   // ==================== UI Display Rules ====================

//   /// Check if this service type requires date range for bookings
//   ///
//   /// Required for: vehicle, equipment, gadget, costume, room
//   /// Not required for: material (custom work
// }
