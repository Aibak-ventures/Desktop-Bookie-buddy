import 'dart:developer';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/widgets/add_or_edit_sales_section.dart';
// import 'package:bookie_buddy_web/features/add_or_edit_sales/views/widgets/add_or_edit_sales_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/components/edit_booking_product_list_tile.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrEditSalesProductsSection extends StatelessWidget {
  const AddOrEditSalesProductsSection({
    super.key,
    required this.selectedProductsNotifier,
    required this.stockCountDecreaseNotifier,
    required this.pickUpDateController,
    required this.returnDateController,
    this.isEditMode = false,
  });

  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final ValueNotifier<bool> stockCountDecreaseNotifier;
  final TextEditingController pickUpDateController;
  final TextEditingController returnDateController;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) => AddOrEditSalesSection(
        title: 'Products',
        child: Column(
          children: [
            _buildProductList(context),
            _buildAddMoreButton(context),
            20.height,
            ValueListenableBuilder(
              valueListenable: pickUpDateController,
              builder: (context, pickupValue, child) => ValueListenableBuilder(
                valueListenable: stockCountDecreaseNotifier,
                builder: (context, stockCountDecrease, child) {
                  final isVisible = stockCountDecrease == false ||
                      (pickupValue.text.isNotEmpty &&
                              pickupValue.text
                                  .parseToDateTime()
                                  .dateOnly
                                  .isBefore(
                                    DateTime.now().dateOnly,
                                  )) &&
                          !isEditMode;

                  return Visibility(
                    visible: isVisible,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey400),
                        borderRadius: 5.radiusBorder,
                        color: AppColors.purpleLightShade,
                      ),
                      child: CheckboxListTile.adaptive(
                        secondary: const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.purple,
                        ),
                        value: stockCountDecrease,
                        onChanged: (value) {
                          if (value != null)
                            stockCountDecreaseNotifier.value = value;
                        },
                        title: const Text('Decrease Stock quantity'),
                        subtitle: const Text(
                          'If unchecked, the stock quantity will not be decreased from the inventory',
                        ),
                      ),
                    ),
                  );
                },
              ),
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
              amount: productModel.amount * productModel.quantity,
              product: productModel.variant,
              needColor: false,
              extraField: 'Price: ${productModel.amount.toCurrency()}',
              onEdit: () => _editProductAmount(context, productModel),
              onRemove: () => _removeProduct(context, productModel),
              // trailing: _buildCustomization(context, productModel),
            );
          },
        ),
      );

  Widget _buildAddMoreButton(BuildContext context) => ValueListenableBuilder(
        valueListenable: selectedProductsNotifier,
        child: const Icon(Icons.add, color: AppColors.purple),
        builder: (context, products, child) => Container(
          padding: (10, 3).padding,
          decoration: ShapeDecoration(
            color: AppColors.purpleLight,
            shape: RoundedRectangleBorder(borderRadius: 5.radiusBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (child != null) child,
              Text(
                products.isEmpty ? 'Add Products' : 'Add more',
                style: const TextStyle(color: AppColors.purple),
              ),
            ],
          ),
        ).onTap(() => _handleAddMore(context)),
      );

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
                AppInputValidators.amount(value, allowZero: false),
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

  // Widget? _buildCustomization(
  //   BuildContext context,
  //   ProductSelectedModel model,
  // ) {
  //   final product = model.variant;
  //   final measurements = model.measurements;

  //   if (!product.mainServiceType.isDress &&
  //       !product.mainServiceType.isVehicle) {
  //     return null;
  //   }

  //   return CustomizationExpansionTile(
  //     expansionTitle: product.mainServiceType.isVehicle ? 'More Details' : null,
  //     measurements: measurements,
  //     onButtonTap: () async {
  //       if (product.mainServiceType.isVehicle) {
  //         final result = await showVehicleCustomizationDialog(
  //           context,
  //           measurements.firstOrNull,
  //         );
  //         if (result != null) {
  //           _updateProductMeasurement(model, [result]);
  //         }
  //         return;
  //       }

  //       final result = await context.push<List<MeasurementValueModel>>(
  //         AddCustomizationScreen(addedMeasurements: measurements),
  //       );
  //       if (result != null) {
  //         _updateProductMeasurement(model, result);
  //       }
  //     },
  //   );
  // }

  // void _updateProductMeasurement(
  //   ProductSelectedModel model,
  //   List<MeasurementValueModel> result,
  // ) {
  //   selectedProductsNotifier.value = selectedProductsNotifier.value.map((e) {
  //     if (e.variant.variantId == model.variant.variantId) {
  //       return e.copyWith(measurements: result);
  //     }
  //     return e;
  //   }).toList();
  // }

  Future<void> _handleAddMore(BuildContext context) async {
    try {
      final result = await Navigator.push<List<ProductSelectedModel>>(
        context,
        MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => SelectProductBloc(
                  repository: getIt<ProductRepository>(),
                ),
              ),
              BlocProvider(create: (_) => SelectedProductsCubit()),
            ],
            child: SelectProductScreen(
              serviceId: null, // All services
              pickupDate: pickUpDateController.text,
              returnDate: returnDateController.text,
              preSelectedData: selectedProductsNotifier.value,
              isSales: true,
              useAvailableProductsApi: false,
            ),
          ),
        ),
      );
      if (result != null) {
        selectedProductsNotifier.value = result;
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
    }
  }
}
