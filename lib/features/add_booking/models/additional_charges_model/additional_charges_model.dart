import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'additional_charges_model.freezed.dart';
part 'additional_charges_model.g.dart';

int _amountFromJson(dynamic value) {
  if (value is num) {
    return value.toInt();
  } else if (value is String) {
    return value.toIntOrDefault();
  } else {
    return 0;
  }
}

@freezed
class AdditionalChargesModel with _$AdditionalChargesModel {
  const factory AdditionalChargesModel({
    @JsonKey(includeIfNull: false) int? id,
    String? name,
    @JsonKey(fromJson: _amountFromJson) int? amount,
  }) = _AdditionalChargesModel;

  factory AdditionalChargesModel.fromJson(Map<String, dynamic> json) =>
      _$AdditionalChargesModelFromJson(json);
}
