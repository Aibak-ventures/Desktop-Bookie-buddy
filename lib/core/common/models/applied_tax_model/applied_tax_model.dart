import 'package:bookie_buddy_web/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'applied_tax_model.freezed.dart';
part 'applied_tax_model.g.dart';

@freezed
abstract class AppliedTaxModel with _$AppliedTaxModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AppliedTaxModel({
    @JsonKey(name: 'is_tax_applied', defaultValue: false)
    required bool isTaxApplied,
    @JsonKey(name: 'tax_name', defaultValue: '') required String taxName,
    @JsonKey(name: 'tax_rate', defaultValue: 0.0) required double taxRate,
    @JsonKey(
      name: 'tax_calculation_type',
      fromJson: TaxCalculationType.fromJson,
      toJson: TaxCalculationType.toJson,
      defaultValue: TaxCalculationType.exclusive,
    )
    required TaxCalculationType taxCalculationType,
    @JsonKey(
      name: 'taxable_components',
      fromJson: TaxableComponent.fromJsonList,
      toJson: TaxableComponent.toJsonList,
      defaultValue: <TaxableComponent>[],
    )
    required List<TaxableComponent> taxableComponents,
    @JsonKey(name: 'subtotal', defaultValue: 0.0) required double subtotal,
    @JsonKey(name: 'taxable_amount', defaultValue: 0.0)
    required double taxableAmount,
    @JsonKey(name: 'tax_amount', defaultValue: 0.0) required double taxAmount,
  }) = _AppliedTaxModel;

  factory AppliedTaxModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedTaxModelFromJson(json);

  /// Accepts a single `tax` JSON object (today's API shape for bookings,
  /// sales, and custom work), a future JSON array of tax objects under the
  /// same key, or a missing/null value — always returns a list. Shared by
  /// every details model with a `tax` key so none of them duplicate this
  /// parsing, and so a future move to a real array only needs to be handled
  /// once, here.
  static List<AppliedTaxModel> listFromJson(dynamic json) {
    if (json == null) return [];
    if (json is List) {
      return json
          .map((e) => AppliedTaxModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [AppliedTaxModel.fromJson(json as Map<String, dynamic>)];
  }
}

extension AppliedTaxModelMapper on AppliedTaxModel {
  AppliedTaxEntity toEntity() => AppliedTaxEntity(
    isTaxApplied: isTaxApplied,
    taxName: taxName,
    taxRate: taxRate,
    taxCalculationType: taxCalculationType,
    taxableComponents: taxableComponents,
    subtotal: subtotal,
    taxableAmount: taxableAmount,
    taxAmount: taxAmount,
  );
}
