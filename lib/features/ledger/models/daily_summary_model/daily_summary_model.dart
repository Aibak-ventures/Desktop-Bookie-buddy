import 'package:bookie_buddy_web/features/ledger/models/ledger_payments_summary_model/ledger_payments_summary_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_summary_model.freezed.dart';
part 'daily_summary_model.g.dart';

dynamic _readSummaryValue(Map json, String key) =>
    (json[key] as Map?)?['total'] ?? 0;

@freezed
class DailySummaryModel with _$DailySummaryModel {
  const factory DailySummaryModel({
    required String date,
    required LedgerPaymentsSummaryModel payments,
    @JsonKey(name: 'expenses', readValue: _readSummaryValue)
    required int expenses,
    @JsonKey(name: 'pendings', readValue: _readSummaryValue)
    required int pendings,
    @JsonKey(name: 'security', readValue: _readSummaryValue)
    required int securityAmount,
    @JsonKey(name: 'bookings', readValue: _readSummaryValue)
    required int bookingAmount,
    @JsonKey(name: 'sales', readValue: _readSummaryValue)
    required int salesAmount,
  }) = _DailySummaryModel;

  factory DailySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DailySummaryModelFromJson(json);

  factory DailySummaryModel.fromEmpty({
    String? date,
    LedgerPaymentsSummaryModel? payments,
    int? expenses,
    int? pendings,
    int? securityAmount,
    int? bookingAmount,
    int? salesAmount,
  }) =>
      DailySummaryModel(
        date: date ?? '',
        payments: payments ?? LedgerPaymentsSummaryModel.empty(),
        expenses: expenses ?? 0,
        pendings: pendings ?? 0,
        securityAmount: securityAmount ?? 0,
        bookingAmount: bookingAmount ?? 0,
        salesAmount: salesAmount ?? 0,
      );
}
