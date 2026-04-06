import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_entity.freezed.dart';

@freezed
abstract class BookingEntity with _$BookingEntity {
  const factory BookingEntity({
    int? id,
    required String clientName,
    required BookingStatus bookingStatus,
    String? bookedDate,
    String? pickupDate,
    String? returnDate,
    required DeliveryStatus deliveryStatus,
    required PaymentStatus paymentStatus,
    String? shopBookingId,
    String? staffName,
    String? createdAt,
    @Default(const []) List<String> bookedItems,
    String? type,
  }) = _BookingEntity;
}
