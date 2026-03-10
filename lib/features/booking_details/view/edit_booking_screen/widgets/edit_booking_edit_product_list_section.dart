import 'dart:developer';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
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
              isActionsVisible: !formController.isReturnDateBeforeCurrentDate,
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

    final oldProduct = formController.originalBooking?.bookedItems.firstWhere(
      (item) => item.variantId == productModel.variant.variantId,
      orElse: () => productModel.variant,
    );

    final oldQty =
        (oldProduct?.quantity ?? productModel.quantity) < productModel.quantity
            ? productModel.quantity
            : (oldProduct?.quantity ?? productModel.quantity);

    final qtyController = TextEditingController(
      text: productModel.quantity.toString(),
    );

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Edit Product',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        content: SizedBox(
          width: context.isMobile ? double.infinity : 600,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info row
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: AppColors.grey),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Quantity can only be decreased',
                          style: TextStyle(fontSize: 13, color: AppColors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Responsive layout: Quantity & Amount side by side on large screens
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 500;
                    return Flex(
                      direction: isWide ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity section
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _qtyButton(
                                    icon: Icons.remove,
                                    onTap: () {
                                      final currentQty =
                                          qtyController.text.toIntOrDefault();
                                      if (currentQty > 1) {
                                        qtyController.text =
                                            (currentQty - 1).toString();
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: qtyController,
                                      validator: (value) =>
                                          AppInputValidators.quantity(
                                        value,
                                        maxValue: oldQty,
                                      ),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  _qtyButton(
                                    icon: Icons.add,
                                    onTap: () {
                                      final currentQty =
                                          int.tryParse(qtyController.text) ?? 0;
                                      if (currentQty < oldQty) {
                                        qtyController.text =
                                            (currentQty + 1).toString();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isWide) const SizedBox(width: 20),
                        // Amount section
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: isWide ? 0 : 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                CustomTextField(
                                  controller: amountController,
                                  validator: (value) =>
                                      AppInputValidators.amount(value,
                                          allowZero: true),
                                  hintText: 'Enter Amount',
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            onPressed: () {
              if (!formKey.currentState!.validate()) return;

              final quantity = int.parse(qtyController.text);
              if (quantity > oldQty) {
                context.showSnackBar(
                  'Quantity cannot be more than $oldQty',
                  isError: true,
                );
                return;
              }

              final newAmount = int.parse(amountController.text);
              final newList = selectedProductsNotifier.value.map((e) {
                if (e.variant.id == productModel.variant.id) {
                  return e.copyWith(
                    amount: newAmount,
                    quantity: quantity,
                    variant: e.variant.copyWith(quantity: quantity),
                  );
                }
                return e;
              }).toList();

              selectedProductsNotifier.value = newList;
              Navigator.pop(context);
            },
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _qtyButton({required IconData icon, required VoidCallback onTap}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(icon, color: AppColors.grey),
    ).onTapInkWell(onTap);
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
