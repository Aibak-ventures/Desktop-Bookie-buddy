import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_core/features/service/domain/entities/service_entity/service_entity.dart';

class ShopFieldHelper {
  const ShopFieldHelper._();

  static bool isRoomShop(List<ServiceEntity> services) =>
      services.any((s) => s.mainServiceType.isRoom);

  /// Resolves the effective service type for the shop as a whole.
  /// Used to delegate label logic to MainServiceType enum getters.
  static MainServiceType getEffectiveServiceType(
    List<ServiceEntity> services,
  ) => isRoomShop(services) ? MainServiceType.room : MainServiceType.other;

  // ==================== Pickup / Return Labels ====================

  static String pickupLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).pickupLabel;

  static String returnLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).returnLabel;

  static String pickupDateLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).pickupDateLabel;

  static String returnDateLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).returnDateLabel;

  static String pickupTimeLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).pickupTimeLabel;

  static String returnTimeLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).returnTimeLabel;

  // ==================== Rental / Duration Labels ====================

  static String rentalUnitTypeLabel(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).rentalUnitTypeLabel;

  static String rentalUnitTypeSubtitle(List<ServiceEntity> services) =>
      isRoomShop(services)
      ? 'Select duration type to calculate room price accordingly.'
      : 'Select rental type to calculate product price accordingly.';

  static bool showCoolingPeriodField(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).showCoolingPeriodField;

  // ==================== Item Name ====================

  /// Singular noun for the item type in this shop.
  /// Use to build any screen title, empty state, or label.
  /// e.g. 'Select ${ShopFieldHelper.itemName(services)}s'
  ///      'Add ${ShopFieldHelper.itemName(services)}'
  static String itemName(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).productNameLabel;

  static String clientTypeName(List<ServiceEntity> services) =>
      getEffectiveServiceType(services).clientNameType;
  // ==================== Dropdown Visibility ====================

  /// Whether the rental/duration unit dropdown should be shown.
  /// True when there is at least one service that requires a date range.
  static bool showRentalUnitDropdown(List<ServiceEntity> services) =>
      services.any((s) => s.mainServiceType.requiresDateRange);
}
