import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_entity.freezed.dart';

@freezed
class StaffEntity with _$StaffEntity {
  const factory StaffEntity({
    required int id,
    required String name,
    required String phoneNumber,
  }) = _StaffEntity;
}
