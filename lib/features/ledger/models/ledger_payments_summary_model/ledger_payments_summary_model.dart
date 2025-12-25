import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_payments_summary_model.freezed.dart';
part 'ledger_payments_summary_model.g.dart';

// Custom converter to handle 'upi' from API mapped to 'gpay' field
int _upiFromJson(Map<String, dynamic> json) {
  // API sends 'upi' but we use 'gpay' internally
  final upiValue = json['upi'] ?? json['gpay'] ?? 0;
  if (upiValue is int) return upiValue;
  if (upiValue is double) return upiValue.toInt();
  return 0;
}

int _cashFromJson(Map<String, dynamic> json) {
  final cashValue = json['cash'] ?? 0;
  if (cashValue is int) return cashValue;
  if (cashValue is double) return cashValue.toInt();
  return 0;
}

int _totalFromJson(Map<String, dynamic> json) {
  final totalValue = json['total'] ?? 0;
  if (totalValue is int) return totalValue;
  if (totalValue is double) return totalValue.toInt();
  return 0;
}

@freezed
class LedgerPaymentsSummaryModel with _$LedgerPaymentsSummaryModel {
  const factory LedgerPaymentsSummaryModel({
    required int gpay,
    required int cash,
    required int total,
  }) = _LedgerPaymentsSummaryModel;

  factory LedgerPaymentsSummaryModel.empty() =>
      const LedgerPaymentsSummaryModel(gpay: 0, cash: 0, total: 0);

  // Custom fromJson to handle 'upi' field from API
  factory LedgerPaymentsSummaryModel.fromJson(Map<String, dynamic> json) =>
      LedgerPaymentsSummaryModel(
        gpay: _upiFromJson(json),
        cash: _cashFromJson(json),
        total: _totalFromJson(json),
      );
}
