import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_request_model.freezed.dart';
part 'client_request_model.g.dart';

@freezed
abstract class ClientRequestModel with _$ClientRequestModel {
  const factory ClientRequestModel({
    @JsonKey(name: 'id', includeToJson: false, includeIfNull: false)
    required int? id,
    @JsonKey(name: 'name', includeIfNull: false) String? name,
    @JsonKey(name: 'phone_1_e164', includeIfNull: false) String? phone1E164,
    @JsonKey(name: 'phone_2_e164', includeIfNull: false) String? phone2E164,
  }) = _ClientRequestModel;

  factory ClientRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ClientRequestModelFromJson(json);

  factory ClientRequestModel.fromEntity(ClientRequestEntity entity) =>
      ClientRequestModel(
        id: entity.id,
        name: entity.name,
        phone1E164: entity.phone1E164,
        phone2E164: entity.phone2E164,
      );
}

extension ClientRequestModelMapper on ClientRequestModel {
  ClientRequestEntity toEntity() => ClientRequestEntity(
    id: id,
    name: name,
    phone1E164: phone1E164,
    phone2E164: phone2E164,
  );
}

extension ClientRequestModelX on ClientRequestModel {
  /// Used by the booking API (client embedded in booking payload).
  ///
  /// Sends the E.164 fields as the source of truth plus the legacy
  /// `client_phone_1` / `client_phone_2` integer fields (national number only)
  /// that the booking endpoint still requires for its own phone validation.
  Map<String, dynamic> toCustomJson() => {
    if (name != null) 'client_name': name,
    if (phone1E164 != null) 'phone_1_e164': phone1E164,
    if (phone2E164 != null) 'phone_2_e164': phone2E164,
  };

  /// Used when PATCHing the dedicated client endpoint directly.
  Map<String, dynamic> toUpdateJson() {
    final json = <String, dynamic>{};
    if (name != null) json['name'] = name;
    if (phone1E164 != null) json['phone_1_e164'] = phone1E164;
    if (phone2E164 != null) json['phone_2_e164'] = phone2E164;
    return json;
  }
}
