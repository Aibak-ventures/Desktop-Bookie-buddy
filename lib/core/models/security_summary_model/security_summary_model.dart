import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_summary_model.freezed.dart';
part 'security_summary_model.g.dart';

@freezed
class SecuritySummaryModel with _$SecuritySummaryModel {
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
