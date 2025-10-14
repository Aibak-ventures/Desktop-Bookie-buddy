import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_vehicle_customization_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_icon_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/customization_expansion_tile.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_customization_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';

class SelectedProductInAddBooking extends StatelessWidget {
  const SelectedProductInAddBooking({
    super.key,
    required this.selected,
    required this.serviceId,
    required this.onRemove,
    required this.selectedProductsNotifier,
  });

  final int? serviceId;
  final ProductSelectedModel selected;
  final VoidCallback onRemove;
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;

  @override
  Widget build(BuildContext context) {
     final product = selected.variant;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: 5.radiusBorder,
            border: Border.all(
              color: AppColors.grey200,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey200,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
                ProductSimpleDetailsTile(
                name: product.name,
                quantity: product.quantity,
                category: product.category,
                color: product.color,
                image: product.image,
                model: product.model,
                variantAttribute: product.variantAttribute,
                mainServiceType: product.mainServiceType,
                amount: selected.amount,
              ),
               if (selected.variant.mainServiceType.isDress ||
                  selected.variant.mainServiceType.isVehicle)
                CustomizationExpansionTile(
                  expansionTitle: selected.variant.mainServiceType.isVehicle
                      ? 'More Details'
                      : null,
                  measurements: selected.measurements,
                  onButtonTap: () async {
                    // add customization
                    if (selected.variant.mainServiceType.isVehicle) {
                      final result = await showVehicleCustomizationDialog(
                        context,
                        selected.measurements.firstOrNull,
                      );
                      if (result != null) {
                        selectedProductsNotifier.value =
                            selectedProductsNotifier.value.map(
                          (e) {
                            if (e.variant.variantId ==
                                selected.variant.variantId) {
                              return ProductSelectedModel(
                                variant: e.variant,
                                amount: e.amount,
                                measurements: [result],
                                quantity: e.quantity,
                              );
                            }
                            return e;
                          },
                        ).toList();
                      }
                    } else {
                      final result =
                          await context.push<List<MeasurementValueModel>>(
                              AddCustomizationScreen(
                        addedMeasurements: selected.measurements,
                      ));
                      if (result != null) {
                        result.forEach(print);
                        selectedProductsNotifier.value =
                            selectedProductsNotifier.value.map(
                          (e) {
                            if (e.variant.variantId ==
                                selected.variant.variantId) {
                              return ProductSelectedModel(
                                variant: e.variant,
                                amount: e.amount,
                                measurements: result,
                                quantity: e.quantity,
                              );
                            }
                            return e;
                          },
                        ).toList();
                      }
                    }
                  },
                ),
            ],
          ),
        ),

        // close button
        Positioned(
          right: 8,
          top: -10,
          child: CustomIconButton(
            bgColor: AppColors.redLight,
            radius: 50,
            height: 25,
            width: 25,
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.redTomato,
            ),
            onTap: onRemove,
          ),
        ),
      ],
    );
  }
}
