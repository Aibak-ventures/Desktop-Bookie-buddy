import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_other_details_model/booking_other_details_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_model.freezed.dart';
part 'booking_details_model.g.dart';

@freezed
class BookingDetailsModel with _$BookingDetailsModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BookingDetailsModel({
    required int id,
    @JsonKey(name: 'shop_booking_id') required String invoiceId,
    required String? pickupDate,
    required String returnDate,
    @JsonKey(name: 'cooling_period_end') String? coolingPeriodDate,
    required int totalAmount,
    int? discountAmount,
    @JsonKey(name: 'advance_amount') required int paidAmount,
    int? securityAmount,
    @JsonKey(
      fromJson: PurchaseMode.fromString,
      defaultValue: PurchaseMode.normal,
    )
    required PurchaseMode purchaseMode,
    @JsonKey(
      fromJson: BookingStatus.fromString,
      toJson: BookingStatus.toJson,
      defaultValue: BookingStatus.upcoming,
    )
    required BookingStatus bookingStatus,
    @JsonKey(
      fromJson: PaymentStatus.fromBool,
      toJson: PaymentStatus.toJson,
      defaultValue: PaymentStatus.pending,
    )
    required PaymentStatus paymentStatus,
    @JsonKey(
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
      defaultValue: DeliveryStatus.booked,
    )
    required DeliveryStatus deliveryStatus,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'details', defaultValue: BookingOtherDetailsModel.empty)
    required BookingOtherDetailsModel otherDetails,
    @JsonKey(name: 'created_at') required String bookedDate,
    @JsonKey(name: 'completed_at') String? bookingCompletedDate,
    @JsonKey(name: 'client_address') String? address,
    required ClientModel client,
    String? description,
    required List<ProductInfoModel> bookedItems,
    @JsonKey(name: 'additional_charges')
    @Default([])
    List<AdditionalChargesModel> additionalCharges,
  }) = _BookingDetailsModel;

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$BookingDetailsModelFromJson(json);

  // factory BookingDetailsModel.fromCustomJson(Map<String, dynamic> json) {
  //   final booking = json as Map<String, dynamic>? ?? {};
  //   final bookedItemsJson = json['booked_items'] as List? ?? [];

  //   return BookingDetailsModel(
  //     id: booking['id'] ?? 0,
  //     invoiceId: booking['shop_booking_id'] ?? '',
  //     client: ClientModel.fromJson(booking['client'] ?? {}),
  //     totalAmount: _getIntFromJson(booking['total_amount']),
  //     paidAmount: _getIntFromJson(booking['advance_amount']),
  //     securityAmount: _getIntFromJson(booking['security_amount']),
  //     discountAmount: _getIntFromJson(booking['discount_amount']),
  //     pickupDate: booking['pickup_date'],
  //     returnDate: booking['return_date'] ?? '',
  //     coolingPeriodDate: booking['cooling_period_end'],
  //     purchaseMode: PurchaseMode.fromString(booking['purchase_mode']),
  //     bookingStatus: BookingStatus.fromString(
  //       booking['booking_status'] ?? 'upcoming',
  //     ),
  //     description: booking['description'] ?? '',
  //     paymentStatus: PaymentStatus.fromBool(booking['payment_status']),
  //     staffName: booking['staff_name'] ?? 'Not Added',
  //     bookedDate: booking['created_at'] ?? '',
  //     bookingCompletedDate: booking['completed_at'],
  //     bookedItems: bookedItemsJson
  //         .map((item) => ProductInfoModel.fromJson(item))
  //         .toList(),
  //     address: booking['client_address'],
  //     deliveryStatus: DeliveryStatus.fromString(
  //       booking['delivery_status'] ?? 'booked',
  //     ),
  //     otherDetails: booking['details'] ?? {},
  //     additionalCharges:
  //         (json['additional_charges'] as List?)
  //             ?.map((e) => AdditionalChargesModel.fromJson(e))
  //             .toList() ??
  //         [],
  //   );
  // }

  // static int _getIntFromJson(dynamic value) {
  //   if (value is int) return value;
  //   if (value is double) return value.toInt();
  //   return 0;
  // }
}
