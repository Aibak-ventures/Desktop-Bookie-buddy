import 'package:bookie_buddy_shared/core/core/constants/enums/main_service_type_enums.dart';

/// Pure rules for product search type resolution.
/// Shared by both the New Booking and Edit Booking search flows.
class BookingSearchRules {
  /// Maps a filter-tab index to the API search type string.
  ///
  /// [serviceType] enables service-type-aware resolution for index 3 (the
  /// "variant" slot whose label changes per service). When null the fallback
  /// 'color' value is returned for index 3, which is correct for the Edit
  /// Booking flow where service-type is not tracked at the search level.
  static String? resolveSearchType(int index, {MainServiceType? serviceType}) {
    switch (index) {
      case 0:
        return 'name';
      case 1:
        return 'category';
      case 2:
        return 'model';
      case 3:
        if (serviceType != null && serviceType.isMultiVariantProductType) {
          if (serviceType == MainServiceType.dress ||
              serviceType == MainServiceType.costume) {
            return 'size';
          } else {
            return 'variant';
          }
        }
        return 'color';
      default:
        return null;
    }
  }
}
