// ignore_for_file: invalid_annotation_target

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

dynamic _idCustomRead(Map json, String key) => json['id'] ?? json['booking_id'];

dynamic _clientCustomRead(Map json, String key) =>
    json[key] ?? json['client_name'];

@freezed
class BookingsModel with _$BookingsModel {
  const factory BookingsModel({
    @JsonKey(
      name: 'id',
      readValue: _idCustomRead,
    )
    int? id,
    @JsonKey(
      name: 'client',
      defaultValue: 'Unknown',
      readValue: _clientCustomRead,
    )
    required String clientName,
    @JsonKey(
      name: 'booking_status',
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
    )
    required BookingStatus bookingStatus,
    @JsonKey(name: 'booking_date') String? bookedDate,
    @JsonKey(name: 'pickup_date') String? pickupDate,
    @JsonKey(name: 'return_date') String? returnDate,
    @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked,
    )
    required DeliveryStatus deliveryStatus,
    @JsonKey(
      name: 'payment_status',
      defaultValue: PaymentStatus.pending,
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
    )
    required PaymentStatus paymentStatus,
    @JsonKey(
      name: 'booked_items',
    )
    @Default(const [])
    List<String> bookedItems,
  }) = _BookingsModel;

  factory BookingsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingsModelFromJson(json);
}
