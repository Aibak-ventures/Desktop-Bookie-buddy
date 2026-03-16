import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/widgets/variant_size_type_text_field.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/widgets/variant_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VariantsWidget extends StatelessWidget {
  VariantsWidget({
    required this.variantsNotifier,
    super.key,
  });

  final ValueNotifier<List<ProductVariantModel>> variantsNotifier;

  final variantAttributeController = TextEditingController();

  final variantQuantityController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        Form(
          key: _formKey,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: VariantSizeTypeTextField(
                  variantAttributeController: variantAttributeController,
                  variantsNotifier: variantsNotifier,
                ),
              ),
              Padding(
                padding: 5.paddingHorizontal,
                child: const Icon(Icons.remove),
              ),
              Expanded(
                child: TextFormField(
                  controller: variantQuantityController,
                  validator: AppInputValidators.quantity,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.grey400,
                      ),
                    ),
                    hintText: 'quantity',
                    hintStyle: const TextStyle(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: variantAttributeController,
                  builder: (context, variantAttribute, child) {
                    return Container(
                      margin: 5.paddingOnly(left: true),
                      padding: 5.padding,
                      decoration: BoxDecoration(
                        color: variantAttribute.text.trim().isEmpty
                            ? AppColors.grey400
                            : AppColors.purple,
                        borderRadius: 4.radiusBorder,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.white,
                      ),
                    ).onTap(
                      variantAttribute.text.trim().isEmpty
                          ? null
                          : () {
                              if (!_formKey.currentState!.validate()) {
                                context.showSnackBar(
                                  'Please fill variant all fields',
                                  isError: true,
                                );
                                return;
                              }
                              final attribute = variantAttribute.text.trim();

                              final quantity =
                                  variantQuantityController.text.trim();

                              final isFreeSize =
                                  VariantSizeType.isFreeSize(attribute);

                              // if free size remove other variants and only add this
                              if (isFreeSize) {
                                variantsNotifier.value = [
                                  ProductVariantModel(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    attribute: attribute,
                                    stock: quantity.toInt(),
                                    remainingStock: quantity.toInt(),
                                  )
                                ];
                                variantQuantityController.clear();
                                return;
                              }

                              // check if variant already exists
                              if (variantsNotifier.value.any(
                                (element) => element.attribute == attribute,
                              )) {
                                variantsNotifier.value =
                                    variantsNotifier.value.map(
                                  (e) {
                                    if (e.attribute == attribute) {
                                      return ProductVariantModel(
                                        id: e.id,
                                        attribute: e.attribute,
                                        stock: quantity.toInt(),
                                        remainingStock: quantity.toInt(),
                                      );
                                    }
                                    return e;
                                  },
                                ).toList();

                                variantAttributeController.clear();
                                variantQuantityController.clear();
                                return;
                              }

                              // add variant
                              variantsNotifier.value = [
                                ProductVariantModel(
                                  id: DateTime.now().millisecondsSinceEpoch,
                                  attribute: attribute,
                                  stock: quantity.toInt(),
                                  remainingStock: quantity.toInt(),
                                ),
                                ...variantsNotifier.value,
                              ];
                              variantAttributeController.clear();
                              variantQuantityController.clear();
                            },
                    );
                  })
            ],
          ),
        ),
        10.height,
        ValueListenableBuilder(
          valueListenable: variantsNotifier,
          builder: (context, value, child) {
            return DefaultTextStyle(
              style: TextStyle(
                color: AppColors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              child: Column(
                children: value
                    .map(
                      (variant) => VariantTile(
                        variant: variant,
                        onEdit: () {
                          variantAttributeController.text = variant.attribute;
                          variantQuantityController.text =
                              variant.stock.toString();
                        },
                        onDelete: () {
                          variantsNotifier.value = variantsNotifier.value
                              .where(
                                (element) => element.id != variant.id,
                              )
                              .toList();
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          },
        )
      ],
    );
  }
}
