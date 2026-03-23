import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_request_entity.freezed.dart';

@freezed
class ClientRequestEntity with _$ClientRequestEntity {
  const factory ClientRequestEntity({
    required int? id,
    String? name,
    int? phone1,
    int? phone2,
  }) = _ClientRequestEntity;
}
