import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:flutter/material.dart';

/// Variants management section for [AddEditProductDialog].
///
/// Owns its own form state (controllers, editing flag, editing variant).
/// The [variantsNotifier] is shared with the parent so [_submit] can read it.
class ProductVariantsSection extends StatefulWidget {
  final MainServiceType mainServiceType;
  final ValueNotifier<List<ProductVariantEntity>> variantsNotifier;

  const ProductVariantsSection({
    super.key,
    required this.mainServiceType,
    required this.variantsNotifier,
  });

  @override
  State<ProductVariantsSection> createState() => _ProductVariantsSectionState();
}

class _ProductVariantsSectionState extends State<ProductVariantsSection> {
  final _variantSizeController = TextEditingController();
  final _variantStockController = TextEditingController();
  final _variantBarcodeController = TextEditingController();
  final _variantQrCodeController = TextEditingController();
  final _isAddingVariant = ValueNotifier<bool>(false);
  ProductVariantEntity? _editingVariant;

  @override
  void dispose() {
    _variantSizeController.dispose();
    _variantStockController.dispose();
    _variantBarcodeController.dispose();
    _variantQrCodeController.dispose();
    _isAddingVariant.dispose();
    super.dispose();
  }

  void _startAddingVariant() {
    _variantSizeController.clear();
    _variantStockController.clear();
    _variantBarcodeController.clear();
    _editingVariant = null;
    _isAddingVariant.value = true;
  }

  void _startEditingVariant(ProductVariantEntity variant) {
    _variantSizeController.text = variant.attribute;
    _variantStockController.text = variant.stock.toString();
    _variantBarcodeController.clear();
    _variantQrCodeController.text = variant.externalQrCode ?? '';
    _editingVariant = variant;
    _isAddingVariant.value = true;

    Future.delayed(const Duration(milliseconds: 100), () {
      Scrollable.ensureVisible(
        context,
        alignment: 0.0,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  void _cancelVariantForm() {
    _variantSizeController.clear();
    _variantStockController.clear();
    _variantBarcodeController.clear();
    _variantQrCodeController.clear();
    _editingVariant = null;
    _isAddingVariant.value = false;
  }

  void _saveVariant() {
    final isGadget = widget.mainServiceType.isGadget;

    if (isGadget) {
      if (_variantQrCodeController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a serial number')),
        );
        return;
      }

      final serialNumber = _variantQrCodeController.text.trim();
      final barcode = _variantBarcodeController.text.trim();
      final updatedVariants = List<ProductVariantEntity>.from(
        widget.variantsNotifier.value,
      );

      if (_editingVariant != null) {
        final index = updatedVariants.indexWhere(
          (v) => v.id == _editingVariant!.id,
        );
        if (index != -1) {
          updatedVariants[index] = ProductVariantEntity(
            id: _editingVariant!.id,
            attribute: serialNumber,
            stock: 1,
            remainingStock: _editingVariant!.remainingStock,
            externalQrCode: barcode.isEmpty ? null : barcode,
          );
        }
      } else {
        updatedVariants.add(
          ProductVariantEntity(
            id: DateTime.now().millisecondsSinceEpoch,
            attribute: serialNumber,
            stock: 1,
            remainingStock: 1,
            externalQrCode: barcode.isEmpty ? null : barcode,
          ),
        );
      }

      widget.variantsNotifier.value = updatedVariants;
      _cancelVariantForm();
      return;
    }

    // Default (non-gadget) variant save
    if (_variantSizeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter variant name/size')),
      );
      return;
    }

    if (_variantStockController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter stock quantity')),
      );
      return;
    }

    final stock = int.tryParse(_variantStockController.text.trim());
    if (stock == null || stock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid stock quantity')),
      );
      return;
    }

    final updatedVariants = List<ProductVariantEntity>.from(
      widget.variantsNotifier.value,
    );
    final externalQrCode = _variantQrCodeController.text.trim();

    if (_editingVariant != null) {
      final index = updatedVariants.indexWhere(
        (v) => v.id == _editingVariant!.id,
      );
      if (index != -1) {
        updatedVariants[index] = ProductVariantEntity(
          id: _editingVariant!.id,
          attribute: _variantSizeController.text.trim(),
          stock: stock,
          remainingStock: _editingVariant!.remainingStock,
          externalQrCode: externalQrCode.isEmpty ? null : externalQrCode,
        );
      }
    } else {
      updatedVariants.add(
        ProductVariantEntity(
          id: DateTime.now().millisecondsSinceEpoch,
          attribute: _variantSizeController.text.trim(),
          stock: stock,
          remainingStock: stock,
          externalQrCode: externalQrCode.isEmpty ? null : externalQrCode,
        ),
      );
    }

    widget.variantsNotifier.value = updatedVariants;
    _cancelVariantForm();
  }

  void _deleteVariant(int variantId) {
    widget.variantsNotifier.value = widget.variantsNotifier.value
        .where((v) => v.id != variantId)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.mainServiceType.needsVariantsSection) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Product Variants',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _isAddingVariant,
                builder: (context, isAdding, child) {
                  return ElevatedButton.icon(
                    onPressed: isAdding ? null : _startAddingVariant,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Variant'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Inline variant form
          ValueListenableBuilder<bool>(
            valueListenable: _isAddingVariant,
            builder: (context, isAdding, child) {
              if (!isAdding) return const SizedBox.shrink();
              return _buildVariantForm();
            },
          ),

          // Variants list
          ValueListenableBuilder<List<ProductVariantEntity>>(
            valueListenable: widget.variantsNotifier,
            builder: (context, variants, child) {
              if (variants.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.mainServiceType.isDress
                              ? 'No variants added yet. Add sizes for this dress.'
                              : 'No variants added. Product will use default quantity.',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    // Header row
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Size/Variant',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Stock',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(width: 80),
                        ],
                      ),
                    ),

                    // Variant rows
                    ...variants.asMap().entries.map((entry) {
                      final index = entry.key;
                      final variant = entry.value;
                      final isLast = index == variants.length - 1;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: isLast
                                ? BorderSide.none
                                : BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                variant.attribute,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                variant.stock.toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _startEditingVariant(variant),
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 18,
                                  ),
                                  tooltip: 'Edit',
                                  color: AppColors.purple,
                                ),
                                IconButton(
                                  onPressed: () => _deleteVariant(variant.id),
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    size: 18,
                                  ),
                                  tooltip: 'Delete',
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVariantForm() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _editingVariant != null
                    ? Icons.edit
                    : Icons.add_circle_outline,
                color: AppColors.purple,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                _editingVariant != null ? 'Edit Variant' : 'Add New Variant',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (widget.mainServiceType.isGadget) ...[
            // Gadgets: Serial Number + Barcode
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: _variantQrCodeController,
                    label: 'Serial Number *',
                    validator: null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: _variantBarcodeController,
                    label: 'Barcode (Optional)',
                    validator: null,
                  ),
                ),
              ],
            ),
          ] else ...[
            // Default: Size/Variant Name + Stock + External QR Code
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: _variantSizeController,
                    label: 'Size / Variant Name *',
                    validator: (value) =>
                        AppInputValidators.onEmpty(value, 'Size'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomTextField(
                    controller: _variantStockController,
                    label: 'Stock Quantity *',
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        AppInputValidators.quantity(value, allowZero: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: CustomTextField(
                    controller: _variantQrCodeController,
                    label: 'External QR Code (Optional)',
                    validator: null,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _cancelVariantForm,
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _saveVariant,
                icon: Icon(
                  _editingVariant != null ? Icons.check : Icons.add,
                  size: 18,
                ),
                label: Text(_editingVariant != null ? 'Update' : 'Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
