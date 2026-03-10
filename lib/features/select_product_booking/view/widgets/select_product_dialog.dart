import 'dart:developer';

import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/product/view/widgets/variant_size_type_text_field.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeAmountDialog extends StatefulWidget {
  final MainServiceType mainServiceType;
  final String productImageUrl;
  final List<ProductVariantModel> availableVariants;
  final List<ProductSelectedModel> alreadySelectedVariants;
  final String? initialAmount;
  final int? initialQuantity;
  final bool isSales;
  final Function(int variantId, String? size, String amount, int quantity)?
      onConfirm;

  const SizeAmountDialog({
    required this.mainServiceType,
    required this.productImageUrl,
    required this.availableVariants,
    this.alreadySelectedVariants = const [],
    this.initialAmount,
    this.initialQuantity,
    this.onConfirm,
    super.key,
    this.isSales = false,
  });

  @override
  State<SizeAmountDialog> createState() => _SizeAmountDialogState();
}

class _SizeAmountDialogState extends State<SizeAmountDialog> {
  ProductVariantModel? selectedVariant;
  late final TextEditingController quantityController;
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final quantityErrorNotifier = ValueNotifier<String>('');
  @override
  void initState() {
    super.initState();

    // Initialize quantity controller with either initial quantity or 1
    final initialQty = widget.initialQuantity ?? 1;
    quantityController = TextEditingController(text: initialQty.toString());

    // Do not auto-select first variant as per user request
    selectedVariant = null;

    // Check if there's already a selected variant for this product
    if (widget.alreadySelectedVariants.isNotEmpty) {
      for (final selected in widget.alreadySelectedVariants) {
        final matchingVariant = widget.availableVariants.firstWhere(
          (variant) => variant.id == selected.variant.variantId,
          orElse: () => widget.availableVariants.first,
        );
        if (matchingVariant.id == selected.variant.variantId) {
          selectedVariant = matchingVariant;
          quantityController.text = selected.quantity.toString();
          amountController.text = selected.amount.toString();
          break;
        }
      }
    }
    // Auto-populate amount field if variant has a price (only if not already set)
    if (amountController.text.isEmpty) {
      _updateAmountFromSelectedVariant();
    }

    // Add listener to quantity controller to update amount when quantity changes
    quantityController.addListener(_updateAmountFromSelectedVariant);
  }

  void _updateAmountFromSelectedVariant() {
    // In sales mode prefer salePrice, otherwise use rent price
    final variantPrice = widget.isSales
        ? (selectedVariant?.salePrice ?? selectedVariant?.price)
        : selectedVariant?.price;
    if (variantPrice != null && variantPrice > 0) {
      final quantity = int.tryParse(quantityController.text) ?? 1;
      final totalAmount = variantPrice * quantity;
      amountController.text = totalAmount.toString();
    } else if (widget.initialAmount?.isNotEmpty == true) {
      // Fallback to initial amount if provided
      final quantity = int.tryParse(quantityController.text) ?? 1;
      final baseAmount = widget.initialAmount?.toIntOrNull() ?? 0;
      final totalAmount = baseAmount * quantity;
      amountController.text = totalAmount.toString();
    }
  }

  @override
  void dispose() {
    // controllers
    quantityController.dispose();
    amountController.dispose();

    // notifiers
    quantityErrorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 420, // Standard web dialog width
          maxHeight: 600, // Reasonable max height
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Text(
                  'Size & Amount',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: 150, // smaller for web
                    width: double.infinity,
                    child: CustomNetworkImage(
                      imageUrl: widget.productImageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, error, stackTrace) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 48),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Size selector (only if multiple variants)
                if (widget.availableVariants.isNotEmpty &&
                    widget.mainServiceType.isDress &&
                    !VariantSizeType.isFreeSize(
                        widget.availableVariants.first.attribute))
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: widget.availableVariants.map((variant) {
                      final isSelected = selectedVariant == variant;
                      final isDisabled = widget.alreadySelectedVariants.any(
                        (e) => e.variant.variantId == variant.id,
                      );
                      return GestureDetector(
                        onTap: isDisabled
                            ? null
                            : () {
                                setState(() {
                                  selectedVariant = variant;
                                  _updateAmountFromSelectedVariant();
                                });
                              },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? Colors.grey.shade300
                                : isSelected
                                    ? AppColors.purpleLight
                                    : const Color(0xFFF8F7FF),
                            // Conditional border radius based on text length
                            borderRadius: BorderRadius.circular(
                              variant.attribute.length > 3 ? 8 : 25,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF6132E4)
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Text(
                            variant.attribute,
                            style: TextStyle(
                              color: isDisabled ? Colors.grey : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                if (widget.initialAmount?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Standard price: Rs. ${widget.initialAmount?.toIntOrNull()?.toCurrency() ?? ''}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _qtyButton(Icons.remove, () {
                      quantityErrorNotifier.value = '';
                      final qty = quantityController.text.toIntOrNull() ?? 1;
                      if (qty > 1) {
                        quantityController.text = (qty - 1).toString();
                        _updateAmountFromSelectedVariant();
                      }
                    }),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: quantityController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Clear error when user types
                          quantityErrorNotifier.value = '';
                          _updateAmountFromSelectedVariant();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.purpleLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    _qtyButton(Icons.add, () {
                      quantityErrorNotifier.value = '';
                      final qty = quantityController.text.toIntOrNull() ?? 1;
                      quantityController.text = (qty + 1).toString();
                      _updateAmountFromSelectedVariant();
                    }),
                  ],
                ),

                ValueListenableBuilder(
                  valueListenable: quantityErrorNotifier,
                  builder: (context, error, _) => error.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(error,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 12.sp)),
                        ),
                ),

                const SizedBox(height: 14),

                // Amount
                CustomTextField(
                  hintText: 'Enter amount',
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  validator: (v) => AppInputValidators.amount(v,
                      allowZero: true, fieldName: 'Amount'),
                  prefixIcon: const Icon(Icons.currency_rupee,
                      color: AppColors.grey, size: 20),
                  fillColor: AppColors.purpleLight,
                ),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: _onConfirmPressed,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
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

  void _onConfirmPressed() async {
    debugPrint(selectedVariant.toString());

    // Get quantity as number (int for normal, double for custom work)
    final qtyText = quantityController.text.trim();
    final qty = qtyText.toIntOrNull();

    // Determine max stock based on product type
    final maxStock = widget.isSales
        ? (selectedVariant?.remainingStock ?? selectedVariant?.stock)
        : selectedVariant?.remainingStock;

    // Validate quantity
    if (qty == null || qty <= 0) {
      quantityErrorNotifier.value = 'Quantity must be greater than 0';
      return;
    }

    // Validate variant selection
    if (widget.availableVariants.isNotEmpty && selectedVariant == null) {
      quantityErrorNotifier.value = 'Please select a variant';
      return;
    }

    // Check stock limits (skip if maxStock is null or 0)
    if (maxStock != null && maxStock > 0 && qty > maxStock) {
      log('Max Stock: $maxStock, Entered Qty: $qty');
      quantityErrorNotifier.value =
          'Quantity must be less than or equal to remaining stock ($maxStock)';
      return;
    }

    // Clear error if validation passes
    quantityErrorNotifier.value = '';

    // Validate form
    if (!_formKey.currentState!.validate()) return;
    if (amountController.text.trim().isEmpty) return;

    // Confirm action callback
    await widget.onConfirm?.call(
      selectedVariant?.id ?? widget.availableVariants.first.id,
      selectedVariant?.attribute,
      amountController.text.trim(),
      qty,
    );

    // Close modal after confirmation
    if (context.mounted) Navigator.pop(context);
  }

  Widget _qtyButton(IconData icon, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.purpleLight,
            minimumSize: const Size(45, 45),
          ),
          icon: Icon(icon, color: AppColors.black),
        ),
      );
}

// Helper function to show the dialog
void showSizeAmountDialog({
  required BuildContext context,
  required MainServiceType mainServiceType,
  required String productImageUrl,
  List<ProductVariantModel> availableVariants = const [],
  List<ProductSelectedModel> alreadySelectedVariants = const [],
  String? initialAmount,
  int? initialQuantity,
  bool isSales = false,
  void Function(int variantId, String? size, String amount, int quantity)?
      onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => SizeAmountDialog(
      mainServiceType: mainServiceType,
      productImageUrl: productImageUrl,
      availableVariants: availableVariants,
      alreadySelectedVariants: alreadySelectedVariants,
      initialAmount: initialAmount,
      initialQuantity: initialQuantity,
      onConfirm: onConfirm,
      isSales: isSales,
    ),
  );
}
