import 'package:bookie_buddy_web/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/tax_summary_entity/tax_summary_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_shop_entity.freezed.dart';

@freezed
abstract class UserShopEntity with _$UserShopEntity {
  const factory UserShopEntity({
    required int id,
    required String name,
    required String phone,
    String? phone2,
    required String address,
    String? gstNumber,
    String? image,
    String? place,
    String? email,
    String? city,
    String? state,
    String? pincode,
    @Default(ShopRole.staff) ShopRole shopRole,
    required List<String> termsAndConditions,
    required List<TaxConfigurationEntity> taxConfigurations,
  }) = _UserShopEntity;
}

extension UserShopEntityX on UserShopEntity {
  String get fullAddress {
    final parts = <String>[
      address,
      if (place != null && place!.trim().isNotEmpty) place!.trim(),
      if (city != null && city!.trim().isNotEmpty) city!.trim(),
      if (state != null && state!.trim().isNotEmpty) state!.trim(),
      if (pincode != null && pincode!.trim().isNotEmpty) pincode!.trim(),
    ];
    return parts.join(', ');
  }

  /// All tax rules currently enabled for this shop. A shop may have more
  /// than one enabled rule (e.g. GST plus a future local tax) — every helper
  /// below sums across whatever is in this list, so adding a new rule to
  /// [taxConfigurations] just adds another term to the sum, no code changes
  /// needed here or at call sites.
  List<TaxConfigurationEntity> get enabledTaxConfigurations =>
      taxConfigurations.where((tax) => tax.isEnabled).toList();

  /// Tax that must be added on top of [componentAmounts], summed across every
  /// enabled exclusive-type rule.
  double calculateAdditionalTaxAmount(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) => enabledTaxConfigurations
      .where((tax) => tax.taxCalculationType == TaxCalculationType.exclusive)
      .fold(
        0,
        (sum, tax) =>
            sum +
            tax.calculateTaxAmount(
              componentAmounts,
              discountAmount: discountAmount,
            ),
      );

  /// Tax already baked into [componentAmounts], summed across every enabled
  /// inclusive-type rule. Informational only — do not add this to a total.
  double calculateIncludedTaxAmount(
    Map<TaxableComponent, double> componentAmounts, {
    double discountAmount = 0,
  }) => enabledTaxConfigurations
      .where((tax) => tax.taxCalculationType == TaxCalculationType.inclusive)
      .fold(
        0,
        (sum, tax) =>
            sum +
            tax.calculateTaxAmount(
              componentAmounts,
              discountAmount: discountAmount,
            ),
      );

  /// Single entry point for applying this shop's tax rules to a booking/sale.
  ///
  /// Every screen that needs a tax breakdown (add booking, edit booking,
  /// sales, custom work, ...) should call this instead of building its own
  /// [TaxableComponent] map — if a new taxable component is ever introduced,
  /// this is the only place that needs a new named parameter + map entry.
  TaxSummaryEntity calculateTaxSummary({
    double productTotal = 0,
    double additionalCharges = 0,
    double securityAmount = 0,
    double discountAmount = 0,
  }) {
    final componentAmounts = <TaxableComponent, double>{
      TaxableComponent.productTotal: productTotal,
      TaxableComponent.additionalCharges: additionalCharges,
      // TaxableComponent.securityAmount: securityAmount,
    };
    final appliedTaxes = enabledTaxConfigurations
        .map(
          (tax) => TaxSummaryLineEntity(
            taxName: tax.taxName,
            taxRate: tax.taxRate,
            taxCalculationType: tax.taxCalculationType,
            amount: tax.calculateTaxAmount(
              componentAmounts,
              discountAmount: discountAmount,
            ),
          ),
        )
        .where((line) => line.amount > 0)
        .toList();

    return TaxSummaryEntity(
      appliedTaxes: appliedTaxes,
      additionalTaxAmount: calculateAdditionalTaxAmount(
        componentAmounts,
        discountAmount: discountAmount,
      ),
      includedTaxAmount: calculateIncludedTaxAmount(
        componentAmounts,
        discountAmount: discountAmount,
      ),
    );
  }
}
