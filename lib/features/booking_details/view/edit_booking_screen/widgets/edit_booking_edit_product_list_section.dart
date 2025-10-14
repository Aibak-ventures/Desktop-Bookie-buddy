import 'dart:developer';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_vehicle_customization_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/customization_expansion_tile.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_customization_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/widgets/edit_booking_section_column.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/components/edit_booking_product_list_tile.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:flutter/material.dart';

class EditBookingEditProductListSection extends StatelessWidget {
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final EditBookingFormStateController formController;
  final TextEditingController pickUpdDateController;
  final TextEditingController returnDateController;
  final TextEditingController coolingPeriodDateController;

  const EditBookingEditProductListSection({
    super.key,
    required this.selectedProductsNotifier,
    required this.formController,
    required this.pickUpdDateController,
    required this.returnDateController,
    required this.coolingPeriodDateController,
  });

  @override
  Widget build(BuildContext context) => EditBookingSectionColumn(
    title: 'Product Details',
    child: Column(
      children: [
        _buildProductList(context),
        ValueListenableBuilder(
          valueListenable: returnDateController,
          builder: (context, value, child) {
            if (formController.isReturnDateBeforeCurrentDate)
              return const SizedBox.shrink();
            return _buildAddMoreButton(context);
          },
        ),
      ],
    ),
  );

  Widget _buildProductList(BuildContext context) => ValueListenableBuilder(
    valueListenable: selectedProductsNotifier,
    builder: (context, selectedProducts, _) => ListView.builder(
      itemCount: selectedProducts.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final productModel = selectedProducts[index];

        return EditBookingProductListTile(
          amount: productModel.amount,
          product: productModel.variant,
          isActionsVisible: formController.isReturnDateBeforeCurrentDate,
          onEdit: () => _editProductAmount(context, productModel),
          onRemove: () => _removeProduct(context, productModel),
          trailing: _buildCustomization(context, productModel),
        );
      },
    ),
  );

  Widget _buildAddMoreButton(BuildContext context) => Container(
    padding: (10, 3).padding,
    decoration: ShapeDecoration(
      color: AppColors.purpleLight,
      shape: RoundedRectangleBorder(borderRadius: 5.radiusBorder),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.add, color: AppColors.purple),
        Text('Add more', style: TextStyle(color: AppColors.purple)),
      ],
    ),
  ).onTap(() => _handleAddMore(context));

  void _editProductAmount(
    BuildContext context,
    ProductSelectedModel productModel,
  ) {
    final amountController = TextEditingController(
      text: productModel.amount.toString(),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Product Amount', textAlign: TextAlign.center),
        content: SizedBox(
          width: context.isMobile ? null : 0.5.widthR,
          child: CustomTextField(
            controller: amountController,
            validator: (value) =>
                AppInputValidators.amount(value, allowZero: true),
            hintText: 'Enter Amount',
            keyboardType: TextInputType.number,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text('Save', style: TextStyle(color: AppColors.white)),
            onPressed: () {
              final newAmount = int.parse(amountController.text);
              final newList = selectedProductsNotifier.value.map((e) {
                if (e.variant.id == productModel.variant.id) {
                  return e.copyWith(amount: newAmount);
                }
                return e;
              }).toList();
              selectedProductsNotifier.value = newList;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _removeProduct(BuildContext context, ProductSelectedModel productModel) {
    final currentList = selectedProductsNotifier.value;

    selectedProductsNotifier.value = currentList
        .where((item) => item.variant.id != productModel.variant.id)
        .toList();
  }

  Widget? _buildCustomization(
    BuildContext context,
    ProductSelectedModel model,
  ) {
    final product = model.variant;
    final measurements = model.measurements;

    if (!product.mainServiceType.isDress &&
        !product.mainServiceType.isVehicle) {
      return null;
    }

    return CustomizationExpansionTile(
      expansionTitle: product.mainServiceType.isVehicle ? 'More Details' : null,
      measurements: measurements,
      onButtonTap: () async {
        if (product.mainServiceType.isVehicle) {
          final result = await showVehicleCustomizationDialog(
            context,
            measurements.firstOrNull,
          );
          if (result != null) {
            _updateProductMeasurement(model, [result]);
          }
          return;
        }

        final result = await context.push<List<MeasurementValueModel>>(
          AddCustomizationScreen(addedMeasurements: measurements),
        );
        if (result != null) {
          _updateProductMeasurement(model, result);
        }
      },
    );
  }

  void _updateProductMeasurement(
    ProductSelectedModel model,
    List<MeasurementValueModel> result,
  ) {
    selectedProductsNotifier.value = selectedProductsNotifier.value.map((e) {
      if (e.variant.variantId == model.variant.variantId) {
        return e.copyWith(measurements: result);
      }
      return e;
    }).toList();
  }

  Future<void> _handleAddMore(BuildContext context) async {
    try {
      final pickup =
          pickUpdDateController.text.parseToDateTime().isBefore(DateTime.now())
          ? DateTime.now().format()
          : pickUpdDateController.text;
      await context.push<List<ProductSelectedModel>>(
        SelectServiceScreen(
          onServiceSelected: (service, context) async {
            final result = await context.push<List<ProductSelectedModel>>(
              SelectProductScreen(
                serviceId: service.id,
                preSelectedData: selectedProductsNotifier.value,
                pickupDate: pickup,
                returnDate: coolingPeriodDateController.text.isNotEmpty
                    ? coolingPeriodDateController.text
                    : returnDateController.text,
              ),
            );
            if (result != null) {
              selectedProductsNotifier.value = result;
            }
            context.pop(); // close service screen
          },
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }
}
