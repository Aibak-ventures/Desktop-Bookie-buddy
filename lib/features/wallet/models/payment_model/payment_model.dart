import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enums/enums.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    @JsonKey(name: 'booking_id') required int bookingId,
    @JsonKey(name: 'payment_amount') required int paymentAmount,
    @JsonKey(
      name: 'payment_method',
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
    )
    required PaymentMethod paymentMethod,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown')
    required String clientName,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
