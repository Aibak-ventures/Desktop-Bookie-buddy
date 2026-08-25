import 'package:bookie_buddy_core/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_overlay.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A small info icon shown next to an applied tax's label. Tapping it opens
/// a popover with the tax's calculation type, taxable components, taxable
/// amount, and tax amount — kept out of the way until the user asks for it.
///
/// Used wherever [AppliedTaxEntity] rows are rendered (booking, sale, and
/// custom work payment details) so the breakdown stays consistent everywhere.
class TaxInfoButton extends StatelessWidget {
  const TaxInfoButton({super.key, required this.tax, this.color});

  final AppliedTaxEntity tax;
  final Color? color;

  @override
  Widget build(BuildContext context) => CustomOverlay(
    width: 230,
    builder: (context, toggle) => InkWell(
      borderRadius: 12.radiusBorder,
      onTap: toggle,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Icon(
          Icons.info_outline,
          size: 15,
          color: color ?? AppColors.grey600,
        ),
      ),
    ),
    overlayBuilder: (context, close) => _TaxInfoCard(tax: tax),
  );
}

class TaxAllInfoButton extends StatelessWidget {
  const TaxAllInfoButton({super.key, required this.taxes, this.color});

  final List<AppliedTaxEntity> taxes;
  final Color? color;

  @override
  Widget build(BuildContext context) => CustomOverlay(
    width: 230,
    builder: (context, toggle) => InkWell(
      borderRadius: 12.radiusBorder,
      onTap: toggle,
      child: Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: Icon(
          Icons.info_outline,
          size: 15,
          color: color ?? AppColors.grey600,
        ),
      ),
    ),
    overlayBuilder: (context, close) => _AllTaxInfoCard(taxes: taxes),
  );
}

class _AllTaxInfoCard extends StatelessWidget {
  const _AllTaxInfoCard({required this.taxes});

  final List<AppliedTaxEntity> taxes;

  TextStyle get rowTextStyle => TextStyle(fontSize: 13.sp);

  int get totalTaxAmount => taxes.totalTaxAmount;
  int get totalTaxableAmount => taxes.totalTaxableAmount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        Text(
          'Tax Info',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        const Divider(height: 1),
        for (final tax in taxes)
          Row(
            children: [
              Expanded(child: Text(tax.formattedTaxLabel, style: rowTextStyle)),
              Text(tax.taxAmount.toCurrency(), style: rowTextStyle),
            ],
          ),

        Text(
          'Total tax of ${totalTaxAmount.toCurrency()} calculated on a '
          'taxable amount of ${totalTaxableAmount.toCurrency()}.',
          style: rowTextStyle.copyWith(color: AppColors.grey600),
        ),
      ],
    );
  }
}

class _TaxInfoCard extends StatelessWidget {
  const _TaxInfoCard({required this.tax});

  final AppliedTaxEntity tax;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 6,
    children: [
      Text(
        tax.formattedTaxLabel,
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
      ),
      const Divider(height: 1),
      _TaxInfoDetailRow(
        label: 'Calculation type:',
        value: tax.taxCalculationType.label,
      ),
      _TaxInfoDetailRow(
        label: 'Applied on:',
        value: tax.taxableComponents.map((c) => c.label).join(', ').orNA(),
      ),
      _TaxInfoDetailRow(
        label: 'Taxable amount:',
        value: tax.taxableAmount.round().toCurrency(),
      ),
      _TaxInfoDetailRow(
        label: 'Tax amount:',
        value: tax.taxAmount.round().toCurrency(),
      ),
    ],
  );
}

class _TaxInfoDetailRow extends StatelessWidget {
  const _TaxInfoDetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(fontSize: 11.sp, color: AppColors.grey600),
      ),
      Text(value, style: TextStyle(fontSize: 13.sp)),
    ],
  );
}
