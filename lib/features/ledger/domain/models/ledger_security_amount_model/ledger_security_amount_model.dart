import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_security_amount_model.freezed.dart';
part 'ledger_security_amount_model.g.dart';

@freezed
class LedgerSecurityAmountModel with _$LedgerSecurityAmountModel {
  const factory LedgerSecurityAmountModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'client_name', defaultValue: 'Unknown')
    required String clientName,
    @JsonKey(name: 'security_amount') required int securityAmount,
    @JsonKey(name: 'date') required String date,
    @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson,
    )
    required LedgerListType type,
  }) = _LedgerSecurityAmountModel;

  factory LedgerSecurityAmountModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSecurityAmountModelFromJson(json);
}
