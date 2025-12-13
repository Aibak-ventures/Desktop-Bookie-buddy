import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_pending_model.freezed.dart';
part 'ledger_pending_model.g.dart';

@freezed
class LedgerPendingModel with _$LedgerPendingModel {
  const factory LedgerPendingModel({
    @JsonKey(name: 'id') required int bookingId,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown')
    required String clientName,
    @JsonKey(name: 'remaining_amount') required int remainingAmount,
    @JsonKey(name: 'return_date') required String returnDate,
  }) = _LedgerPendingModel;

  factory LedgerPendingModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPendingModelFromJson(json);
}
