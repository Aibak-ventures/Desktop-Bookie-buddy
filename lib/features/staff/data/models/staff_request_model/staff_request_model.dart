import 'package:bookie_buddy_web/features/staff/domain/entities/staff_request_entity/staff_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_request_model.freezed.dart';
part 'staff_request_model.g.dart';

@freezed
abstract class StaffRequestModel with _$StaffRequestModel {
  const factory StaffRequestModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber,
  }) = _StaffRequestModel;

  factory StaffRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StaffRequestModelFromJson(json);

  factory StaffRequestModel.fromEntity(StaffRequestEntity entity) =>
      StaffRequestModel(
        id: entity.id,
        name: entity.name,
        phoneNumber: entity.phoneNumber,
      );
}
