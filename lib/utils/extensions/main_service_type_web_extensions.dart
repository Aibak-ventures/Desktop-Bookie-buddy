import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';

// MainServiceType now comes from bookie_buddy_core (see
// docs/shared-packages-plan.md in the mobile repo). These two getters were
// on web's own local copy of the enum and have no mobile equivalent, so
// they stay here as extensions rather than moving into the shared package.
extension MainServiceTypeWebX on MainServiceType? {
  /// Service types that support multi-variant product setup (dress/costume
  /// sizes). Originally also covered `shoe`/`bridal` — those enum values
  /// existed on web's local copy but were never actually used anywhere, so
  /// they were dropped rather than ported to the shared enum; this is now
  /// exactly core's own `isDressType`.
  bool get needsVariantsSection => isDressType;

  // For future use
  bool get showQuantityInDynamicFields => true;
}
