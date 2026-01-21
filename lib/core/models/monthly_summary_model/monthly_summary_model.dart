// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'monthly_summary_model.freezed.dart';
part 'monthly_summary_model.g.dart';

@freezed
class MonthlySummaryModel with _$MonthlySummaryModel {
  const factory MonthlySummaryModel({
    @JsonKey(name: 'month') required String month,
    @JsonKey(name: 'total_bookings') @Default(0) int totalBookings,
    @JsonKey(name: 'revenue') @Default(0.0) double revenue,
  }) = _MonthlySummaryModel;

  factory MonthlySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$MonthlySummaryModelFromJson(json);
}
