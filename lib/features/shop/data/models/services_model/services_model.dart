// ignore_for_file: invalid_annotation_target

import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_model.freezed.dart';
part 'services_model.g.dart';

@freezed
class ServicesModel with _$ServicesModel {
  factory ServicesModel({
    required int id,
    @JsonKey(name: 'service_name') required String name,
    @JsonKey(name: 'description') required String description,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'main_service_name', defaultValue: 'Other')
    required String mainServiceName,
  }) = _ServicesModel;

  factory ServicesModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesModelFromJson(json);
}

extension ServicesModelMapper on ServicesModel {
  ServiceEntity toEntity() => ServiceEntity(
        id: id,
        name: name,
        description: description,
        icon: icon,
        mainServiceName: mainServiceName,
      );
}
