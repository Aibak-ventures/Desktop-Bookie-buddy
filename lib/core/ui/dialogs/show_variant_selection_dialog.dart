import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<int?> showVariantSelectionDialog({
  required BuildContext context,
  required int productId,
  required List<ProductVariantModel> variants,
  required MainServiceType? mainServiceType,
}) async {
  ProductVariantModel? selectedVariant = variants.first;
  final isMultiVariant = variants.length > 1;
  return showDialog<int>(
    context: context,
    builder: (ctx) => Dialog(
      child: SizedBox(
        width: context.isMobile ? null : 0.6.widthR,
        child: Padding(
          padding: 16.padding,
          child: Column(
            crossAxisAlignment: !mainServiceType.isDress || variants.length == 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 15,
            children: [
              if (!mainServiceType.isDress || variants.length == 1)
                Text(
                  'Select Product',
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (mainServiceType.isDress && variants.length > 1)
                StatefulBuilder(
                    builder: (context, setState) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Variant',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 55,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: variants.length,
                                itemBuilder: (context, index) {
                                  final variant = variants[index];
                                  final isSelected = selectedVariant == variant;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedVariant = variant;
                                        log('current selected variant: $selectedVariant');
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      margin: const EdgeInsets.only(right: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.purpleLight
                                            : const Color(0xFFE8E4FF),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
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
                                            color: isSelected
                                                ? const Color(0xFF6C5CE7)
                                                : Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
              Text(
                'Are you sure you want to select this ${isMultiVariant ? 'variant' : 'product'}?',
                textAlign: !isMultiVariant ? TextAlign.start : TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  TextButton(
                    onPressed: () => ctx.pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      log('selected variant: $selectedVariant, onPop: ${selectedVariant?.id ?? productId}');
                      ctx.pop(selectedVariant?.id ?? productId);
                    },
                    child: const Text(
                      'Select',
                      style: TextStyle(
                        color: Colors.white,
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
