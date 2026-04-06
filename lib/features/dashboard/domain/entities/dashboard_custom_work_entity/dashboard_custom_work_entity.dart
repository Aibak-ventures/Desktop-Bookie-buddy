import 'package:bookie_buddy_web/core/constants/enums/customization_work_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_custom_work_entity.freezed.dart';

@freezed
abstract class DashboardCustomWorkEntity with _$DashboardCustomWorkEntity {
  const factory DashboardCustomWorkEntity({
    required int id,
    required String tailorName,
    required String pickupDate,
    required CustomizationWorkStatus status,
    required String products,
    String? staffColor,
  }) = _DashboardCustomWorkEntity;
}
