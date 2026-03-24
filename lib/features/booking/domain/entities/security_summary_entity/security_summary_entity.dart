import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_summary_entity.freezed.dart';

@freezed
abstract class SecuritySummaryEntity with _$SecuritySummaryEntity {
  const factory SecuritySummaryEntity({
    @Default(0.0) double securityAmount,
    @Default(0.0) double totalRefunded,
    @Default(0.0) double totalDeducted,
    @Default(0.0) double remainingBalance,
  }) = _SecuritySummaryEntity;

  static const empty = SecuritySummaryEntity();
}
