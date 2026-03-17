import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_booking_model.freezed.dart';
part 'ledger_booking_model.g.dart';

@freezed
class LedgerBookingModel with _$LedgerBookingModel {
  const factory LedgerBookingModel({
    @JsonKey(name: 'booking_id') required int bookingId,
    @JsonKey(
      name: 'client_name',
      defaultValue: 'Unknown',
    )
    required String clientName,
    @JsonKey(
      name: 'total_amount',
      defaultValue: 0,
    )
    required int totalAmount,
    @JsonKey(
      name: 'advance_amount',
      defaultValue: 0,
    )
    required int advanceAmount,
    @JsonKey(name: 'booked_date') required String bookedDate,
    @JsonKey(name: 'booked_items') @Default(const []) List<String> bookedItems,
  }) = _LedgerBookingModel;

  factory LedgerBookingModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerBookingModelFromJson(json);
}
