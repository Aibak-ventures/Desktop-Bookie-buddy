import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_entity.freezed.dart';

@freezed
class ClientEntity with _$ClientEntity {
  const factory ClientEntity({
    int? id,
    required String name,
    required int phone1,
    int? phone2,
  }) = _ClientEntity;
}
