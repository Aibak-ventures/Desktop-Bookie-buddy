import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

enum MainServiceType {
  dress,
  vehicle,
  equipment,
  gadgets,
  others;

  static MainServiceType fromString(String? serviceName) {
    if (serviceName == null) return MainServiceType.others;
    final serviceType = serviceName.toLowerCase();
    if (serviceType.contains('dress')) {
      return MainServiceType.dress;
    } else if (serviceType.contains('vehicle')) {
      return MainServiceType.vehicle;
    } else if (serviceType.contains('equipment')) {
      return MainServiceType.equipment;
    } else if (serviceType.contains('gadget')) {
      return MainServiceType.gadgets;
    } else {
      return MainServiceType.others;
    }
  }

  static MainServiceType fromServiceList(
    List<ServicesModel> services,
    int? serviceId,
  ) {
    if (serviceId == null) {
      return MainServiceType.others;
    }
    for (final s in services) {
      if (s.id == serviceId) {
        return fromString(s.mainServiceName);
      }
    }
    return MainServiceType.others;
  }
}

extension MainServiceTypeX on MainServiceType? {
  bool get isDress => this == MainServiceType.dress;
  bool get isVehicle => this == MainServiceType.vehicle;
  bool get isEquipment => this == MainServiceType.equipment;
  bool get isGadgets => this == MainServiceType.gadgets;
  bool get isOthers => this == MainServiceType.others;
}
