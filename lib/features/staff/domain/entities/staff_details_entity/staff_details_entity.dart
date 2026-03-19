import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_details_entity.freezed.dart';

@freezed
class StaffDetailsEntity with _$StaffDetailsEntity {
  const factory StaffDetailsEntity({
    required int id,
    required String name,
    required String phoneNumber,
    required String createdAt,
  }) = _StaffDetailsEntity;
}
