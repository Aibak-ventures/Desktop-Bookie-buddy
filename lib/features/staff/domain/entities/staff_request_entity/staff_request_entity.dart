import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_request_entity.freezed.dart';

@freezed
class StaffRequestEntity with _$StaffRequestEntity {
  const factory StaffRequestEntity({
    int? id,
    String? name,
    String? phoneNumber,
  }) = _StaffRequestEntity;
}
