import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_request_entity.freezed.dart';

@freezed
abstract class ClientRequestEntity with _$ClientRequestEntity {
  const factory ClientRequestEntity({
    required int? id,
    String? name,
    String? phone1E164,
    String? phone2E164,
  }) = _ClientRequestEntity;
}
