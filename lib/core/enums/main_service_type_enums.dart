
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

enum MainServiceType {
  dress('dress'),
  vehicle('vehicle'),
  equipment('equipment'),
  material('material'),
  gadget('gadget'),
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

  /// Get MainServiceType from a list of ServicesModel by serviceId
  ///
  /// Returns `MainServiceType.other` if serviceId is null or not found
  static MainServiceType fromServiceList(
    List<ServicesModel> services,
    int? serviceId,
  ) {
    if (serviceId == null) {
      return MainServiceType.other;
    }
    for (final s in services) {
      if (s.id == serviceId) {
        return fromString(s.mainServiceName);
      }
    }
    return MainServiceType.other;
  }

  /// Try to get MainServiceType from a list of ServicesModel by serviceId
  ///
  /// Returns `null` if serviceId is null or not found
  static MainServiceType? tryFromServiceList(
    List<ServicesModel> services,
    int? serviceId,
  ) {
    if (serviceId == null) {
      return null;
    }
    for (final s in services) {
      if (s.id == serviceId) {
        return fromString(s.mainServiceName);
      }
    }
    return null;
  }
}

/// Extension methods for nullable MainServiceType enum
extension MainServiceTypeX on MainServiceType? {
  bool get isDress => this == MainServiceType.dress;
  bool get isVehicle => this == MainServiceType.vehicle;
  bool get isEquipment => this == MainServiceType.equipment;
  bool get isMaterial => this == MainServiceType.material;
  bool get isGadget => this == MainServiceType.gadget;
  bool get isRoom => this == MainServiceType.room;
  bool get isOthers => this == MainServiceType.other;
}
