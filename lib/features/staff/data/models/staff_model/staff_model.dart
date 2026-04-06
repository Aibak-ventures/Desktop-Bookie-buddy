import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_model.freezed.dart';
part 'staff_model.g.dart';

@freezed
abstract class StaffModel with _$StaffModel {
  const factory StaffModel({
    required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'phone') required String phoneNumber,
  }) = _StaffModel;

  factory StaffModel.fromJson(Map<String, dynamic> json) =>
      _$StaffModelFromJson(json);
}

extension StaffModelMapper on StaffModel {
  StaffEntity toEntity() => StaffEntity(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
      );
}
