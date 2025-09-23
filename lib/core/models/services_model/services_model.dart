// ignore_for_file: invalid_annotation_target

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

// class ServicesModel {
//   final int id;
//   final String name;
//   final String description;

//   ServicesModel({
//     required this.id,
//     required this.name,
//     required this.description,
//   });

//   factory ServicesModel.fromJson(Map<String, dynamic> json) {
//     return ServicesModel(
//       id: json['id'],
//       name: json['service_name'], // Make sure these match the API response
//       description: json['description'],
//     );
//   }
// }
