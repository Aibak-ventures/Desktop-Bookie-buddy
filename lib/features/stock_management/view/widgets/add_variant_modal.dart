import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

/// Modal dialog for adding/editing a product variant
class AddVariantModal extends StatefulWidget {
  final ProductVariantModel? variant;

  const AddVariantModal({
    this.variant,
    super.key,
  });

  @override
  State<AddVariantModal> createState() => _AddVariantModalState();
}

class _AddVariantModalState extends State<AddVariantModal> {
  final _formKey = GlobalKey<FormState>();
  final _sizeController = TextEditingController();
  final _stockController = TextEditingController();
  final _barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.variant != null) {
      _sizeController.text = widget.variant!.attribute;
      _stockController.text = widget.variant!.stock.toString();
      _barcodeController.text = '';
    }
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _stockController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final variant = ProductVariantModel(
        id: widget.variant?.id ?? DateTime.now().millisecondsSinceEpoch,
        attribute: _sizeController.text.trim(),
        stock: int.parse(_stockController.text.trim()),
        remainingStock: widget.variant?.remainingStock ??
            int.parse(_stockController.text.trim()),
      );
      Navigator.of(context).pop(variant);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.variant == null ? 'Add New Variant' : 'Edit Variant',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.purple,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Size/Attribute Field
              CustomTextField(
                controller: _sizeController,
                label: 'Size / Variant Name *',
                validator: (value) => AppInputValidators.onEmpty(value, 'Size'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // Stock Field
              CustomTextField(
                controller: _stockController,
                label: 'Stock Quantity *',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    AppInputValidators.quantity(value, allowZero: false),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 16),

              // Barcode Field
              CustomTextField(
                controller: _barcodeController,
                label: 'Barcode / QR Code (Optional)',
                validator: null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomElevatedButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.of(context).pop(),
                    width: 120,
                    height: 45,
                    backgroundColor: Colors.grey.shade300,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(width: 12),
                  CustomElevatedButton(
                    text: widget.variant == null ? 'Add Variant' : 'Update',
                    onPressed: _submit,
                    width: 140,
                    height: 45,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
