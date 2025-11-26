import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

String _readName(Map json, String key) =>
    json[key] ?? json['client_name'] ?? 'Unknown';

int _readPhone1(Map json, String key) =>
    json[key] ?? json['client_phone_1'] ?? 0000000000;

int? _readPhone2(Map json, String key) => json[key] ?? json['client_phone_2'];

@freezed
class ClientModel with _$ClientModel {
  const factory ClientModel({
    @JsonKey(
      name: 'id',
      includeToJson: false,
    )
    int? id,
    @JsonKey(
      name: 'name',
      readValue: _readName,
    )
    required String name,
    @JsonKey(
      name: 'phone_1',
      readValue: _readPhone1,
    )
    required int phone1,
    @JsonKey(
      name: 'phone_2',
      readValue: _readPhone2,
    )
    int? phone2,
    // @JsonKey(name: 'client_address') required String address,
  }) = _ClientModel;

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);
}
