import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

enum MainServiceType {
  dress,
  vehicle,
  equipment,
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
    final serviceName = services
        .firstWhere((service) => service.id == serviceId)
        .mainServiceName;

    return fromString(serviceName);
  }
}

extension MainServiceTypeX on MainServiceType? {
  bool get isDress => this == MainServiceType.dress;
  bool get isVehicle => this == MainServiceType.vehicle;
  bool get isEquipment => this == MainServiceType.equipment;
  bool get isOthers => this == MainServiceType.others;
}
