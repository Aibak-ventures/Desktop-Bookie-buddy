import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_request_model.freezed.dart';
part 'client_request_model.g.dart';

@freezed
class ClientRequestModel with _$ClientRequestModel {
  const factory ClientRequestModel({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
    required int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone_1', includeIfNull: false) int? phone1,
    @JsonKey(name: 'phone_2', includeIfNull: false) int? phone2,
  }) = _ClientRequestModel;

  factory ClientRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ClientRequestModelFromJson(json);
}

extension ClientRequestModelX on ClientRequestModel {
  Map<String, dynamic> toCustomJson() => {
        'client_name': name,
        'client_phone_1': phone1,
        'client_phone_2': phone2,
      };
}
