import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';

/// Centralized expense categories by service type.
/// Use [ExpenseCategories.forService] to obtain the list for a given main service type.
class ExpenseCategories {
  ExpenseCategories._();

  static const List<String> common = [
    'Service',
    'Maintenance',
    'Supplies',
    'Utilities',
    'Miscellaneous',
    'Other',
  ];

  /// Categories that apply to all services (general operational costs)
  static const List<String> global = [
    'Food',
    'Travel',
    'Petrol',
    'Tea & Water',
    'Salary',
  ];

  /// Dress specific
  static const List<String> dress = ['Stitching', 'Dry Cleaning', 'Alteration'];

  /// Vehicle specific
  static const List<String> vehicle = [
    'Fuel',
    'Insurance',
    'Tyre Service',
    'Spare Parts',
    'Registration',
  ];

  /// Equipment & Other Assets (Jewels, Electronics, etc.)
  static const List<String> equipment = [
    'Calibration',
    'Spare Parts',
    'Rental',
    'Jewellery Maintenance',
    'Electronics Repair',
    'Asset Insurance',
    'Accessories',
  ];

  /// Other / fallback
  static const List<String> others = [...global];

  /// Resolves the category list by service type plus the terminal 'Other' option for custom entry.
  static List<String> forService(MainServiceType? type) {
    final base = () {
      if (type == MainServiceType.dress) return dress;
      if (type == MainServiceType.vehicle) return vehicle;
      if (type == MainServiceType.equipment) return equipment;
      return others;
    }();
    // Ensure single 'Other' at end.
    return [
      ...{...base}, // removing duplicates using set with spread operator
      ...common,
    ];
  }
}
