import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_summary_model.freezed.dart';
part 'security_summary_model.g.dart';

@freezed
abstract class SecuritySummaryModel with _$SecuritySummaryModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SecuritySummaryModel({
    @Default(0.0) double securityAmount,
    @Default(0.0) double totalRefunded,
    @Default(0.0) double totalDeducted,
    @Default(0.0) double remainingBalance,
  }) = _SecuritySummaryModel;

  factory SecuritySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SecuritySummaryModelFromJson(json);

  static const empty = SecuritySummaryModel();
}

extension SecuritySummaryModelMapper on SecuritySummaryModel {
  // BookingSecuritySummaryEntity models money as int (matching every other
  // amount field on BookingDetailsEntity, and mobile's own convention) —
  // this model's fields are double, inconsistent with the rest of web's
  // own amount handling elsewhere; rounding here, not truncating.
  BookingSecuritySummaryEntity toEntity() => BookingSecuritySummaryEntity(
    totalSecurityAmount: securityAmount.round(),
    totalRefunded: totalRefunded.round(),
    totalDeducted: totalDeducted.round(),
    pendingDeposit: remainingBalance.round(),
  );
}
