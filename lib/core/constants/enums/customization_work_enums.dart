import 'dart:ui';

import 'package:bookie_buddy_web/core/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';

enum CustomizationWorkType {
  toShop('shop'),
  toRent('rental'),
  toSale('sale');

  final String value;

  const CustomizationWorkType(this.value);

  /// Convert from string to CustomizationWorkType enum
  static CustomizationWorkType? tryFromString(String? status) {
    if (status == null) {
      return null;
    }
    return CustomizationWorkType.values.firstWhereOrNull(
      (e) => e.name == status,
    );
  }

  static CustomizationWorkType fromJson(String? value) {
    if (value == null) {
      return CustomizationWorkType.toShop;
    }
    return CustomizationWorkType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CustomizationWorkType.toShop,
    );
  }

  static String? toJson(CustomizationWorkType? type) => type?.value;
}

/// Extension methods for nullable CustomizationWorkType enum
extension CustomizationWorkTypeX on CustomizationWorkType? {
  bool get isToShop => this == CustomizationWorkType.toShop;
  bool get isToRent => this == CustomizationWorkType.toRent;
  bool get isToSale => this == CustomizationWorkType.toSale;
}

/// Status of the overall customization work order
/// Used to track the progress of the entire order
enum CustomizationWorkStatus {
  initiated('initiated', 'Order Placed', AppColors.orangeVivid),
  inProgress('in_progress', 'Processing', AppColors.aquamarineMedium),
  completed('completed', 'Finished', AppColors.purple);

  const CustomizationWorkStatus(this.value, this.name, this.color);

  final String value;
  final String name;
  final Color color;

  /// Convert from string to CustomizationWorkStatus enum
  static CustomizationWorkStatus fromString(String? status) {
    if (status == null) {
      return initiated;
    }
    return CustomizationWorkStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => initiated,
    );
  }

  /// Convert from CustomizationWorkStatus enum to string
  static String? toJson(CustomizationWorkStatus? status) => status?.value;
}

/// Extension methods for nullable CustomizationWorkStatus enum
extension CustomizationWorkStatusX on CustomizationWorkStatus? {
  bool get isInitiated => this == CustomizationWorkStatus.initiated;
  bool get isInProgress => this == CustomizationWorkStatus.inProgress;
  bool get isCompleted => this == CustomizationWorkStatus.completed;
}

/// Status of each product in customization work.
/// Used to track the progress of individual products
enum CustomizationWorkProductStatus {
  pending('pending', 'Pending'),
  stitching('stitching', 'Stitching'),
  ready('ready', 'Ready'),
  delivered('delivered', 'Delivered');

  const CustomizationWorkProductStatus(this.value, this.name);

  final String value;
  final String name;

  /// Convert from string to CustomizationWorkProductStatus enum
  static CustomizationWorkProductStatus fromString(String? status) {
    if (status == null) {
      return pending;
    }
    return CustomizationWorkProductStatus.values.firstWhere(
      (e) => e.value == status,
      orElse: () => pending,
    );
  }

  static CustomizationWorkProductStatus fromJson(String? value) {
    if (value == null) {
      return CustomizationWorkProductStatus.pending;
    }
    return CustomizationWorkProductStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CustomizationWorkProductStatus.pending,
    );
  }

  static String? toJson(CustomizationWorkProductStatus? status) =>
      status?.value;
}

/// Extension methods for nullable CustomizationWorkProductStatus enum
extension CustomizationWorkProductStatusX on CustomizationWorkProductStatus? {
  bool get isPending => this == CustomizationWorkProductStatus.pending;
  bool get isStitching => this == CustomizationWorkProductStatus.stitching;
  bool get isReady => this == CustomizationWorkProductStatus.ready;
  bool get isDelivered => this == CustomizationWorkProductStatus.delivered;
}
