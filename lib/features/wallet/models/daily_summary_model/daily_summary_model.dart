import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_summary_model.freezed.dart';
part 'daily_summary_model.g.dart';

dynamic _readValue(Map json, String key) {
  return json[key]['total'];
}

// dynamic _securityAmountReadValue(Map json, String key) {
//   return json[key]?['total'] ?? 0;
// }

@freezed
class DailySummaryModel with _$DailySummaryModel {
  const factory DailySummaryModel({
    required String date,
    required PaymentsSummary payments,
    @JsonKey(
      name: 'expenses',
      readValue: _readValue,
    )
    required int expenses,
    @JsonKey(
      name: 'pendings',
      readValue: _readValue,
    )
    required int pendings,
    @JsonKey(
      name: 'security',
      readValue: _readValue,
    )
    required int securityAmount,
  }) = _DailySummaryModel;

  factory DailySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$DailySummaryModelFromJson(json);
}

@freezed
class PaymentsSummary with _$PaymentsSummary {
  const factory PaymentsSummary({
    required int gpay,
    required int cash,
    required int total,
  }) = _PaymentsSummary;

  factory PaymentsSummary.empty() =>
      const PaymentsSummary(gpay: 0, cash: 0, total: 0);

  factory PaymentsSummary.fromJson(Map<String, dynamic> json) =>
      _$PaymentsSummaryFromJson(json);
}
