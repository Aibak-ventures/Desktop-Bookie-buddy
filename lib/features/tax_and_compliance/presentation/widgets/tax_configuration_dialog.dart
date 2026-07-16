import 'package:bookie_buddy_web/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/core/constants/enums/tax_calculation_type_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/taxable_component_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shows the tax configuration dialog and returns a filled
/// [TaxConfigurationRequestEntity] on save, or null if dismissed.
class TaxConfigurationDialog extends StatefulWidget {
  const TaxConfigurationDialog({super.key, this.initialData});

  final TaxConfigurationEntity? initialData;

  @override
  State<TaxConfigurationDialog> createState() => _TaxConfigurationDialogState();

  static Future<TaxConfigurationRequestEntity?> show({
    required BuildContext context,
    TaxConfigurationEntity? initialData,
  }) {
    return showDialog<TaxConfigurationRequestEntity>(
      context: context,
      builder: (_) => TaxConfigurationDialog(initialData: initialData),
    );
  }
}

class _TaxConfigurationDialogState extends State<TaxConfigurationDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _rateCtrl;
  late TaxCalculationType _calculationType;
  late Set<TaxableComponent> _selectedComponents;

  bool get _isEditMode => widget.initialData != null;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _nameCtrl = TextEditingController(text: d?.taxName ?? 'GST');
    _rateCtrl = TextEditingController(text: (d?.taxRate ?? 18).toString());
    _calculationType = d?.taxCalculationType ?? TaxCalculationType.exclusive;
    _selectedComponents = {
      ...d?.taxableComponents ??
          const [
            TaxableComponent.productTotal,
            TaxableComponent.additionalCharges,
          ],
    };
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedComponents.isEmpty) {
      context.showSnackBar(
        'Select at least one taxable component',
        isError: true,
      );
      return;
    }

    Navigator.of(context).pop(
      TaxConfigurationRequestEntity(
        taxName: _nameCtrl.text.trim(),
        taxRate: double.parse(_rateCtrl.text.trim()),
        isEnabled: widget.initialData?.isEnabled ?? true,
        taxableComponents: _selectedComponents.toList(),
        taxCalculationType: _calculationType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Dialog(
    shape: RoundedRectangleBorder(borderRadius: 16.radiusBorder),
    insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: SingleChildScrollView(
        padding: 24.padding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.purpleLight,
                      borderRadius: 10.radiusBorder,
                    ),
                    child: Icon(
                      _isEditMode ? Icons.edit_outlined : Icons.percent,
                      size: 20,
                      color: AppColors.purple,
                    ),
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditMode ? 'Edit tax rule' : 'Add tax rule',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black87,
                          ),
                        ),
                        Text(
                          _isEditMode
                              ? 'Update your tax configuration'
                              : 'Set up how tax is applied to bookings',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20),
                    color: AppColors.grey600,
                    visualDensity: VisualDensity.compact,
                    tooltip: 'Close',
                  ),
                ],
              ),
              24.height,
              Divider(height: 1, thickness: 0.5, color: AppColors.grey400),
              20.height,

              const _FieldLabel('Tax name'),
              6.height,
              CustomTextField(
                controller: _nameCtrl,
                textCapitalization: TextCapitalization.characters,
                hintText: 'e.g. GST',
                prefixIcon: const Icon(Icons.label_outline),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Tax name is required';
                  }
                  return null;
                },
              ),
              16.height,

              const _FieldLabel('Tax rate (%)'),
              6.height,
              CustomTextField(
                controller: _rateCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                textInputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                hintText: 'e.g. 18',
                suffixText: '%',
                prefixIcon: const Icon(Icons.percent),
                validator: AppInputValidators.taxRate,
              ),
              20.height,

              const _FieldLabel('Calculation type'),
              6.height,
              SegmentedButton<TaxCalculationType>(
                style: SegmentedButton.styleFrom(
                  selectedForegroundColor: AppColors.purple,
                  selectedBackgroundColor: AppColors.purple.changeOpacity(0.2),
                  foregroundColor: AppColors.grey700,
                  shape: ContinuousRectangleBorder(
                    borderRadius: 10.radiusBorder,
                  ),
                ),
                segments: TaxCalculationType.values
                    .map(
                      (type) =>
                          ButtonSegment(value: type, label: Text(type.label)),
                    )
                    .toList(),
                selected: {_calculationType},
                onSelectionChanged: (selection) =>
                    setState(() => _calculationType = selection.first),
              ),
              20.height,

              const _FieldLabel('Apply tax on'),
              ...TaxableComponent.values.map(
                (component) => CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.purple,
                  title: Text(component.label),
                  value: _selectedComponents.contains(component),
                  onChanged: (checked) => setState(() {
                    if (checked ?? false) {
                      _selectedComponents.add(component);
                    } else {
                      _selectedComponents.remove(component);
                    }
                  }),
                ),
              ),

              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.grey700,
                      side: BorderSide(color: AppColors.grey400),
                    ),
                    child: const Text('Cancel'),
                  ),
                  12.width,
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: AppColors.white,
                    ),
                    child: Text(_isEditMode ? 'Save changes' : 'Add tax rule'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) => Text(
    label,
    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
  );
}
