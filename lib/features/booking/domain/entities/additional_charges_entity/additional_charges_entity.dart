import 'package:freezed_annotation/freezed_annotation.dart';

part 'additional_charges_entity.freezed.dart';

@freezed
abstract class AdditionalChargesEntity with _$AdditionalChargesEntity {
  const factory AdditionalChargesEntity({int? id, String? name, int? amount}) =
      _AdditionalChargesEntity;
}
