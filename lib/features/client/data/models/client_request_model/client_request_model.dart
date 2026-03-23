import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
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

  factory ClientRequestModel.fromEntity(ClientRequestEntity entity) =>
      ClientRequestModel(
        id: entity.id,
        name: entity.name,
        phone1: entity.phone1,
        phone2: entity.phone2,
      );
}

extension ClientRequestModelMapper on ClientRequestModel {
  ClientRequestEntity toEntity() => ClientRequestEntity(
        id: id,
        name: name,
        phone1: phone1,
        phone2: phone2,
      );
}

extension ClientRequestModelX on ClientRequestModel {
  Map<String, dynamic> toCustomJson() => {
        'client_name': name,
        'client_phone_1': phone1,
        'client_phone_2': phone2,
        if (phone1 != null) 'phone_1_e164': toPhone1E164(phone1.toString()),
        if (phone2 != null) 'phone_2_e164': toPhone1E164(phone2.toString()),
      };
}
