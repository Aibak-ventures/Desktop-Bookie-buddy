import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';

class ProductStockValidator {
  static bool canEnforceStock(BookingType bookingType) {
    return bookingType != BookingType.oldBooking;
  }

  static bool canAddVariant({
    required BookingType bookingType,
    required int availableStock,
  }) {
    if (!canEnforceStock(bookingType)) return true;
    return availableStock > 0;
  }

  static bool canIncreaseQuantity({
    required BookingType bookingType,
    required int currentQuantity,
    required int availableStock,
  }) {
    if (!canEnforceStock(bookingType)) return true;
    return currentQuantity < availableStock;
  }

  static bool canSetQuantity({
    required BookingType bookingType,
    required int quantity,
    required int availableStock,
  }) {
    if (!canEnforceStock(bookingType)) return true;
    return quantity <= availableStock;
  }
}
