import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_request_model.freezed.dart';
part 'staff_request_model.g.dart';

@freezed
class StaffRequestModel with _$StaffRequestModel {
  const factory StaffRequestModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone', includeIfNull: false) String? phoneNumber,
  }) = _StaffRequestModel;

  factory StaffRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StaffRequestModelFromJson(json);
}
