import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum DeliveryStatus {
  booked,
  readyToDeliver,
  delivered,
  returned,
  cancelled;

  /// Converts [DeliveryStatus] enum to a string label to display in the UI.
  String get name {
    switch (this) {
      case DeliveryStatus.booked:
        return 'Booked';
      case DeliveryStatus.readyToDeliver:
        return 'Ready to deliver';
      case DeliveryStatus.delivered:
        return 'Delivered';
      case DeliveryStatus.returned:
        return 'Returned';
      case DeliveryStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case DeliveryStatus.booked:
        return AppColors.orangeVivid;
      case DeliveryStatus.readyToDeliver:
        return AppColors.aquamarineMedium;
      case DeliveryStatus.delivered:
        return const Color.fromARGB(255, 0, 149, 255);
      case DeliveryStatus.returned:
        return AppColors.purple;
      case DeliveryStatus.cancelled:
        return Colors.red;
    }
  }

  /// Converts a string representation of a delivery status to its corresponding enum value.
  ///
  /// Returns [DeliveryStatus.booked] if the given string is not recognized.
  ///
  /// Supported string representations:
  ///
  /// - "booked"
  /// - "ready to deliver"
  /// - "delivered"
  /// - "returned"
  /// - "cancelled"
  static DeliveryStatus fromString(dynamic status) {
    if (status == null) return DeliveryStatus.booked;
    switch (status.toLowerCase()) {
      case 'booked':
        return DeliveryStatus.booked;
      case 'ready to deliver':
        return DeliveryStatus.readyToDeliver;
      case 'delivered':
        return DeliveryStatus.delivered;
      case 'returned':
        return DeliveryStatus.returned;
      case 'cancelled':
        return DeliveryStatus.cancelled;

      default:
        return DeliveryStatus.booked;
    }
  }

  static String? toJson(DeliveryStatus? status) => status?.toValue();

  /// Converts the [DeliveryStatus] enum to its corresponding string value
  /// for use in API requests or data storage.
  ///
  /// Returns:
  ///   The string value associated with the enum.

  String toValue() {
    switch (this) {
      case DeliveryStatus.booked:
        return 'booked';
      case DeliveryStatus.readyToDeliver:
        return 'ready to deliver';
      case DeliveryStatus.delivered:
        return 'delivered';
      case DeliveryStatus.returned:
        return 'returned';
      case DeliveryStatus.cancelled:
        return 'cancelled';
    }
  }
}

enum BookingStatus {
  upcoming,
  completed,
  cancelled;

  /// Converts [BookingStatus] enum to a string label to display in the UI.
  String get name {
    switch (this) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Returns the color associated with each booking status
  Color get color {
    switch (this) {
      case BookingStatus.upcoming:
        return AppColors.orangeVivid;
      case BookingStatus.completed:
        return AppColors.green2;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }

  /// Converts the [BookingStatus] enum to its corresponding string value
  /// for use in API requests or data storage.
  ///
  /// Returns:
  ///   The string value associated with the enum.
  String toValue() {
    switch (this) {
      case BookingStatus.upcoming:
        return 'upcoming';
      case BookingStatus.completed:
        return 'completed';
      case BookingStatus.cancelled:
        return 'cancelled';
    }
  }

  /// Converts a string representation of a booking status to its corresponding enum value.
  ///
  /// Supported string representations:
  ///
  /// - "upcoming"
  /// - "completed"
  ///
  /// Returns [BookingStatus.upcoming] if the given string is not recognized.
  static BookingStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'upcoming':
        return BookingStatus.upcoming;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.upcoming;
    }
  }

  static String? toJson(BookingStatus? status) => status?.toValue();
}

enum LoadBookingType {
  all,
  upcoming,
  completed,
  past,
  future;

  String get value {
    switch (this) {
      case all:
        return 'all';
      case upcoming:
        return 'upcoming';
      case completed:
        return 'completed';
      case past:
        return 'past';
      case future:
        return 'future';
    }
  }
}
