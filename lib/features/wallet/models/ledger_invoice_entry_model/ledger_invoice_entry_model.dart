import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_invoice_entry_model.freezed.dart';
part 'ledger_invoice_entry_model.g.dart';

@freezed
class LedgerInvoiceEntryModel with _$LedgerInvoiceEntryModel {
  const factory LedgerInvoiceEntryModel({
    @JsonKey(
      name: 'type',
      fromJson: InvoiceIncludeType.fromString,
    )
    required InvoiceIncludeType type,
    required String date,
    @JsonKey(
      name: 'user',
      defaultValue: 'Unknown',
    )
    required String user,
    required String description,
    required int amount,
  }) = _LedgerInvoiceEntryModel;

  factory LedgerInvoiceEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerInvoiceEntryModelFromJson(json);
}
