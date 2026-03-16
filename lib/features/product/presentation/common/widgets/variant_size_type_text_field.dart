import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class VariantSizeTypeTextField extends StatelessWidget {
  VariantSizeTypeTextField({
    super.key,
    required this.variantAttributeController,
    required this.variantsNotifier,
  });

  final TextEditingController variantAttributeController;
  final ValueNotifier<List<ProductVariantModel>> variantsNotifier;
  final variantSizeTypeNotifier =
      ValueNotifier<VariantSizeType>(VariantSizeType.letter);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: variantSizeTypeNotifier,
        builder: (context, sizeType, child) {
          final isFreeSize = sizeType == VariantSizeType.freeSize;

          return TextFormField(
            controller: variantAttributeController,
            readOnly: isFreeSize,
            validator: sizeType.validate,
            textCapitalization: sizeType == VariantSizeType.letter
                ? TextCapitalization.characters
                : TextCapitalization.none,
            decoration: InputDecoration(
              hintText: sizeType.hintText,
              hintStyle: const TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
              suffix: SizeTypeMenuButton(
                variantsNotifier: variantsNotifier,
                onSelected: (option) {
                  variantSizeTypeNotifier.value = option;
                  variantAttributeController.clear();
                  if (VariantSizeType.freeSize == option) {
                    variantAttributeController.text = option.name;
                  }
                },
              ),
            ),
          );
        });
  }
}

class SizeTypeMenuButton extends StatelessWidget {
  final Function(VariantSizeType option) onSelected;
  final ValueNotifier<List<ProductVariantModel>> variantsNotifier;
  const SizeTypeMenuButton({
    required this.onSelected,
    required this.variantsNotifier,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VariantSizeType>(
      icon: const Icon(Icons.more_vert),
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => VariantSizeType.values.map(
        (e) {
          final isEmpty = variantsNotifier.value.isEmpty;
          final isFreeSizeContains = variantsNotifier.value.any(
            (e) => VariantSizeType.isFreeSize(e.attribute),
          );
          return PopupMenuItem<VariantSizeType>(
            enabled: () {
              if (isEmpty) return true;

              if (isFreeSizeContains) {
                // If Free Size already exists, only allow selecting Free Size again
                return e == VariantSizeType.freeSize;
              } else {
                // If other sizes exist, disable Free Size
                return e != VariantSizeType.freeSize;
              }
            }(), // calling this function from here,
            value: e,
            child: Text(e.name),
          );
        },
      ).toList(),
    );
  }
}

enum VariantSizeType {
  number,
  letter,
  freeSize;

  String get name {
    switch (this) {
      case VariantSizeType.number:
        return 'Number';
      case VariantSizeType.letter:
        return 'Letter';
      case VariantSizeType.freeSize:
        return 'Free Size';
    }
  }

  static VariantSizeType fromString(String value) {
    switch (value) {
      case 'Number':
        return VariantSizeType.number;
      case 'Letter':
        return VariantSizeType.letter;
      case 'Free Size':
        return VariantSizeType.freeSize;
      default:
        return VariantSizeType.number;
    }
  }

  String get hintText {
    switch (this) {
      case VariantSizeType.number:
        return 'Eg: 32 or 35';
      case VariantSizeType.letter:
        return 'Eg: S,M or L';
      case VariantSizeType.freeSize:
        return 'Free Size';
    }
  }

  static bool isFreeSize(String value) {
    return fromString(value) == VariantSizeType.freeSize;
  }

  String? validate(String? value) {
    if (this == VariantSizeType.freeSize) {
      return null;
    }
    if (value == null || value.trim().isEmpty) {
      return 'Enter size';
    }

    switch (this) {
      case VariantSizeType.number:
        final val = double.tryParse(value.trim());
        if (val == null || val <= 0 || value.length > 2) {
          return 'Enter valid number like 32 or 35';
        }
        return null;

      case VariantSizeType.letter:
        if (value.length > 4) {
          return 'Up to 4 characters allowed';
        }
        if (!RegExp(r'^[A-Za-z]{1,4}$').hasMatch(value.trim())) {
          return 'Enter valid size like S, M, L, XL';
        }
        return null;

      case VariantSizeType.freeSize:
        return null;
    }
  }
}
