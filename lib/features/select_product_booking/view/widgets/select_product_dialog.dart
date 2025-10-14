import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
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
  final bool isSales;
  final Function(int variantId, String? size, String amount, int quantity)?
  onConfirm;

  const SizeAmountDialog({
    required this.mainServiceType,
    required this.productImageUrl,
    required this.availableVariants,
    this.alreadySelectedVariants = const [],
    this.initialAmount,
    this.onConfirm,
    super.key,
    this.isSales = false,
  });

  @override
  State<SizeAmountDialog> createState() => _SizeAmountDialogState();
}

class _SizeAmountDialogState extends State<SizeAmountDialog> {
  ProductVariantModel? selectedVariant;
  final quantityController = TextEditingController(text: '1');
  final amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final quantityErrorNotifier = ValueNotifier<String>('');
  @override
  void initState() {
    super.initState();
    log(widget.availableVariants.first.toString());
    // if (VariantSizeType.isFreeSize(widget.availableVariants.first.attribute)) {
    //   selectedVariant = widget.availableVariants.first;
    // }
    // if (widget.alreadySelectedVariants.isNotEmpty) {
    //   //!TODO: Note here
    //   // selectedVariant = widget.selectedVariant;
    //   selectedVariant = widget.availableVariants.first;
    // } else {}
    selectedVariant = widget.availableVariants.first;
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Container(
          width: context.isMobile ? null : 0.6.widthR,
          padding: 24.padding,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: 20.radiusBorder,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  'Size & Amount',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                20.height,

                // Product Image
                SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: 10.radiusBorder,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomNetworkImage(
                        imageUrl: widget.productImageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: 16.radiusBorder,
                            ),
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Size Selection
                if (widget.availableVariants.isNotEmpty &&
                    widget.mainServiceType.isDress &&
                    !VariantSizeType.isFreeSize(
                        widget.availableVariants.first.attribute))
                  SizedBox(
                    height: 55,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.availableVariants.length,
                      itemBuilder: (context, index) {
                        final variant = widget.availableVariants[index];
                        final isSelected = selectedVariant == variant;

                        final isDisabled = widget.alreadySelectedVariants.any(
                          (e) => e.variant.variantId == variant.id,
                        );

                        return Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? Colors.grey.shade300
                                : isSelected
                                    ? AppColors.purpleLight
                                    : const Color(0xFFE8E4FF),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDisabled
                                  ? Colors.grey
                                  : isSelected
                                      ? const Color(0xFF6C5CE7)
                                      : Colors.transparent,
                              width: isSelected ? 2 : 0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              variant.attribute,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: isDisabled
                                    ? Colors.grey.shade600
                                    : isSelected
                                        ? const Color(0xFF6C5CE7)
                                        : Colors.black87,
                              ),
                            ),
                          ),
                        ).onTap(
                          () {
                            if (!isDisabled)
                              setState(() {
                                selectedVariant = variant;
                              });
                          },
                        );
                      },
                    ),
                  ),

                if (widget.initialAmount != null &&
                    widget.initialAmount!.isNotEmpty &&
                    widget.initialAmount?.toIntOrNull() != null &&
                    widget.initialAmount?.toIntOrNull() != 0) ...[
                  if (widget.mainServiceType.isDress)
                    const SizedBox(height: 20),
                  Text(
                      'Standard price: Rs. ${widget.initialAmount?.toInt().toCurrency()}'),
                ],

                22.height,

                // Quantity
                Row(
                  spacing: 10,
                  children: [
                    IconButton.filled(
                      constraints:
                          const BoxConstraints(minHeight: 55, minWidth: 55),
                      onPressed: () {
                        quantityErrorNotifier.value = '';
                        final qty = quantityController.text.toIntOrNull();
                        if (qty == null) {
                          return;
                        }

                        if (qty <= 1) {
                          quantityController.text = '1';
                        } else {
                          quantityController.text = (qty - 1).toString();
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: AppColors.black,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.purpleLight,
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        hintText: 'Enter the amount',
                        controller: quantityController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        errorText: null,
                        onChanged: (value) => quantityErrorNotifier.value = '',
                        onTapOutside:
                            () {}, // To avoid keyboard dismiss when scrolling
                        validator: null,
                        // validator: (value) => AppInputValidators.amount(
                        //   value,
                        //   fieldName: 'Quantity',
                        //   maxValue: selectedVariant?.remainingStock ?? 1,
                        // ),

                        fillColor: AppColors.purpleLight,
                      ),
                    ),
                    IconButton.filled(
                      constraints:
                          const BoxConstraints(minHeight: 55, minWidth: 55),
                      onPressed: () {
                        quantityErrorNotifier.value = '';
                        final qty = quantityController.text.toIntOrNull();
                        if (qty == null) {
                          return;
                        }

                        quantityController.text = (qty + 1).toString();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.black,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.purpleLight,
                      ),
                    ),
                  ],
                ),

                // Quantity Error
                ValueListenableBuilder(
                  valueListenable: quantityErrorNotifier,
                  builder: (context, error, child) {
                    return error.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: 2.paddingOnly(top: true),
                            child: Text(
                              error,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12.sp,
                              ),
                            ),
                          );
                  },
                ),

                8.height,
                // Amount Input
                CustomTextField(
                  hintText: 'Enter the amount',
                  controller: amountController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onTapOutside:
                      () {}, // To avoid keyboard dismiss when scrolling
                  validator: (value) => AppInputValidators.amount(
                    value,
                    allowZero: true,
                    fieldName: 'Amount',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  fillColor: AppColors.purpleLight,
                  prefixIcon: const Icon(
                    Icons.currency_rupee,
                    color: AppColors.grey,
                  ),
                ),

                15.height,

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    10.width,
                    SizedBox(
                      height: context.mediaQueryHeight(0.045),
                      width: context.mediaQueryWidth(0.28),
                      child: ElevatedButton(
                        onPressed: widget.alreadySelectedVariants.any(
                          (e) => e.variant.variantId == selectedVariant?.id,
                        )
                            ? null
                            : () async {
                                print(selectedVariant);

                                // Quantity error handling
                                final qtyText = quantityController.text.trim();
                                final qty = qtyText.toIntOrNull();

                                final maxStock =
                                    selectedVariant?.remainingStock;

                                if (qty == null ||
                                    qty <= 0 ||
                                    (maxStock != null && qty > maxStock)) {
                                  quantityErrorNotifier.value =
                                      'Quantity must be less than remaining stock ${maxStock}';
                                  return;
                                } else {
                                  quantityErrorNotifier.value = '';
                                }

                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                if (quantityController.text
                                        .trim()
                                        .toIntOrNull() ==
                                    null) {
                                  return;
                                }
                                if (amountController.text.isNotEmpty) {
                                  await widget.onConfirm?.call(
                                    selectedVariant?.id ??
                                        widget.availableVariants.first.id,
                                    selectedVariant?.attribute,
                                    amountController.text,
                                    quantityController.text.trim().toInt(),
                                  );
                                  context.pop();
                                }
                              },
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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
}

// Helper function to show the dialog
void showSizeAmountDialog({
  required BuildContext context,
  required MainServiceType mainServiceType,
  required String productImageUrl,
  List<ProductVariantModel> availableVariants = const [],
  List<ProductSelectedModel> alreadySelectedVariants = const [],
  String? initialAmount,
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
      onConfirm: onConfirm,
      isSales: isSales,
    ),
  );
}
