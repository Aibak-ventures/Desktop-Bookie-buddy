import 'package:bookie_buddy_web/features/booking/domain/entities/security_summary_entity/security_summary_entity.dart';
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
  SecuritySummaryEntity toEntity() => SecuritySummaryEntity(
    securityAmount: securityAmount,
    totalRefunded: totalRefunded,
    totalDeducted: totalDeducted,
    remainingBalance: remainingBalance,
  );
}
