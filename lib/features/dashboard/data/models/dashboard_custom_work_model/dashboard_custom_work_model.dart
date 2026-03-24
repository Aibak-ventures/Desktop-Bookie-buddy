import 'package:bookie_buddy_web/core/constants/enums/customization_work_enums.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/dashboard_custom_work_entity/dashboard_custom_work_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_custom_work_model.freezed.dart';
part 'dashboard_custom_work_model.g.dart';

@freezed
abstract class DashboardCustomWorkModel with _$DashboardCustomWorkModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DashboardCustomWorkModel({
    required int id,
    required String tailorName,
    required String pickupDate,
    @JsonKey(
      fromJson: CustomizationWorkStatus.fromString,
      toJson: CustomizationWorkStatus.toJson,
    )
    required CustomizationWorkStatus status,
    required String products,
    @JsonKey(name: 'staff_color') String? staffColor,
  }) = _DashboardCustomWorkModel;

  factory DashboardCustomWorkModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardCustomWorkModelFromJson(json);
}

extension DashboardCustomWorkModelMapper on DashboardCustomWorkModel {
  DashboardCustomWorkEntity toEntity() => DashboardCustomWorkEntity(
        id: id,
        tailorName: tailorName,
        pickupDate: pickupDate,
        status: status,
        products: products,
        staffColor: staffColor,
      );
}
