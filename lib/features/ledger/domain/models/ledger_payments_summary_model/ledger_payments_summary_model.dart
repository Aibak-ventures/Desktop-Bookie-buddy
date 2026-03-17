import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_payments_summary_model.freezed.dart';
part 'ledger_payments_summary_model.g.dart';

@freezed
class LedgerPaymentsSummaryModel with _$LedgerPaymentsSummaryModel {
  const factory LedgerPaymentsSummaryModel({
    required int gpay,
    required int cash,
    required int total,
  }) = _LedgerPaymentsSummaryModel;

  factory LedgerPaymentsSummaryModel.empty() =>
      const LedgerPaymentsSummaryModel(gpay: 0, cash: 0, total: 0);

  factory LedgerPaymentsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerPaymentsSummaryModelFromJson(json);
}
