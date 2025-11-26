import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_details_model.freezed.dart';
part 'staff_details_model.g.dart';

@freezed
class StaffDetailsModel with _$StaffDetailsModel {
  const factory StaffDetailsModel({
    required int id,
    required String name,
    @JsonKey(name: 'phone') required String phoneNumber,
    @JsonKey(name: 'created_at', defaultValue: '') required String createdAt,
  }) = _StaffDetailsModel;

  factory StaffDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$StaffDetailsModelFromJson(json);
}
