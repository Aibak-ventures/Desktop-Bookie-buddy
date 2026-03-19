import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sales_request_model/sales_request_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Add or Edit Sales screen controllers and keys
class AddOrEditSalesFormStateController {
  // Form key
  final formKey = GlobalKey<FormState>();

  final focusGuard = FocusNode(debugLabel: 'AddOrEditSalesFocusGuard');

  // Date
  final saleDateController = TextEditingController();

  // Client
  final clientPhoneController = TextEditingController();

  // Other
  final placeController = TextEditingController();
  final descriptionController = TextEditingController();
  final staffNameController = TextEditingController();

  // Amount
  final discountController = TextEditingController();

  // Notifiers
  final selectedProductsNotifier = ValueNotifier<List<ProductSelectedModel>>(
    [],
  );

  final stockCountDecreaseNotifier = ValueNotifier<bool>(true);

  final paymentMethodNotifier = ValueNotifier(PaymentMethod.gPay);

  final isSharingPdfToWhatsAppNotifier = ValueNotifier<bool>(false);

  void dispose() {
    saleDateController.dispose();
    // nameController.dispose();
    clientPhoneController.dispose();
    // phone2Controller.dispose();
    placeController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    staffNameController.dispose();
    selectedProductsNotifier.dispose();
    // isClientSearchEnabledNotifier.dispose();
    stockCountDecreaseNotifier.dispose();
    paymentMethodNotifier.dispose();
    isSharingPdfToWhatsAppNotifier.dispose();
    focusGuard.dispose();
  }

  void setInitialValues(SaleDetailsModel saleDetails, BuildContext context) {
    focusGuard.skipTraversal = true;
    saleDateController.text = saleDetails.saleDate.formatToUiDate();

    staffNameController.text = saleDetails.staffName ?? 'Staff Name';

    // nameController.text = saleDetails.client.name;
    paymentMethodNotifier.value = saleDetails.paymentMethod;
    clientPhoneController.text = saleDetails.clientPhone.toString();
    // if (saleDetails.client.phone2 != null) {
    //   phone2Controller.text = saleDetails.client.phone2.toString();
    // }
    if (saleDetails.address.isNotNullOrEmpty) {
      placeController.text = saleDetails.address;
    }
    descriptionController.text = saleDetails.description;
    if (saleDetails.discountAmount > 0)
      discountController.text = saleDetails.discountAmount.toString();

    // context.read<ClientCubit>().selectClient(saleDetails.client);

    // isClientSearchEnabledNotifier.value = true;

    selectedProductsNotifier.value = saleDetails.products
        .map(
          (e) => ProductSelectedModel(
            amount: e.price,
            quantity: e.quantity,
            // fabricLength: e.fabricLength,
            variant: ProductInfoModel(
              id: e.id,
              productId: e.productId,
              variantId: e.variantId,
              name: e.name,
              image: e.image,
              quantity: e.quantity,
              // fabricLength: e.fabricLength,
              amount: e.price,
              category: e.category,
              color: e.color,
              mainServiceType: e.mainServiceType,
              model: e.model,
              variantAttribute: e.variantAttribute,
            ),
          ),
        )
        .toList();
  }

  SalesRequestModel? buildRequest({
    required BuildContext context,
    required SaleDetailsModel? saleDetails,
  }) {
    if (!(formKey.currentState?.validate() ?? true)) {
      context.showSnackBar(
        'Please fill all required fields',
        title: 'Form Error',
        isError: true,
      );
      return null;
    }
    final isEditMode = saleDetails != null;
    final selectedStaff = context.read<StaffSearchCubit>().state.selectedStaff;
    if (isEditMode) {
      if (saleDetails.staffId != null && selectedStaff == null) {
        context.showSnackBar(
          'Please select a staff',
          title: 'Staff Required',
          isError: true,
        );
        return null;
      }
    } else {
      if (selectedStaff == null) {
        context.showSnackBar(
          'Please select a staff',
          title: 'Staff Required',
          isError: true,
        );
        return null;
      }
    }

    if (selectedProductsNotifier.value.isEmpty) {
      context.showSnackBar(
        'Select at least one product',
        title: 'Product Required',
        isError: true,
      );
      return null;
    }
    final totalAmount = selectedProductsNotifier.value.fold(
      0,
      (p, e) => p + (e.amount * e.quantity),
    );
    final discountAmount = discountController.text.trim().toIntOrNull() ?? 0;
    if (discountAmount >= totalAmount) {
      context.showSnackBar(
        'Discount cannot be greater than total amount',
        title: 'Amount Error',
        isError: true,
      );
      return null;
    }

    // Fetch original sale details from the ancestor widget
    final original = saleDetails;

    if (original != null) {
      // Current form values
      final currentSaleDate = saleDateController.text.formatToUiDate();
      // Compare sale date
      final saleDateChanged =
          currentSaleDate != original.saleDate.formatToUiDate();

      // Compare client
      final isClientPhoneChanged =
          clientPhoneController.text.trim() != original.clientPhone.toString();

      final isStaffChanged = selectedStaff?.id != original.staffId;

      // Compare address
      final addressChanged =
          placeController.text.trim() != (original.address.trim());

      // Compare description
      final descriptionChanged =
          descriptionController.text.trim() != original.description.trim();

      // Compare discount
      final discountAmount = discountController.text.trim().toIntOrNull() ?? 0;
      final discountChanged = discountAmount != original.discountAmount;
      final paymentMethodChanged =
          paymentMethodNotifier.value != original.paymentMethod;

      // Compare products (id + variantId + quantity + amount)
      bool productsChanged = false;
      final newProducts = selectedProductsNotifier.value;
      if (newProducts.length != original.products.length) {
        productsChanged = true;
      } else {
        for (final p in newProducts) {
          ProductSaleInfoModel? match;
          for (final op in original.products) {
            if (op.id == p.variant.id && op.variantId == p.variant.variantId) {
              match = op;
              break;
            }
          }

          if (match == null ||
              match.quantity != p.quantity ||
              match.price != p.amount) {
            productsChanged = true;
            break;
          }
        }
      }

      debugPrint('isProductsChanged: $productsChanged');

      // If nothing changed -> pop with snackbar
      if (!(saleDateChanged ||
          isClientPhoneChanged ||
          addressChanged ||
          descriptionChanged ||
          discountChanged ||
          paymentMethodChanged ||
          isStaffChanged ||
          productsChanged)) {
        context
          ..pop()
          ..showSnackBar('Nothing to change');
        return null;
      }

      // CRITICAL FIX: Always send all products when any field has changed
      // This ensures the backend receives the complete product list
      return SalesRequestModel(
        id: original.id,
        saleDate: saleDateChanged ? currentSaleDate : null,
        staffId: isStaffChanged ? selectedStaff?.id : null,
        clientPhone:
            isClientPhoneChanged ? clientPhoneController.text.trim() : null,
        address: addressChanged ? placeController.text.trim() : null,
        // Send all current products if products changed OR if any other field changed
        // This prevents partial updates that might clear products
        products: newProducts.isNotEmpty ? newProducts : null,

        description:
            descriptionChanged ? descriptionController.text.trim() : null,
        discountAmount: discountChanged ? discountAmount : null,

        paymentMethod:
            paymentMethodChanged ? paymentMethodNotifier.value : null,
      );
    }
    return SalesRequestModel(
      saleDate: saleDateController.text.formatToUiDate(),
      staffId: selectedStaff?.id,
      clientPhone: clientPhoneController.text.trim(),
      address: placeController.text.trim(),
      products: selectedProductsNotifier.value,
      stockCountDecrease: stockCountDecreaseNotifier.value,
      description: descriptionController.text.trim(),
      discountAmount: discountAmount,
      paidAmount: totalAmount - discountAmount,
      paymentMethod: paymentMethodNotifier.value,
      sendPdfToWhatsApp: isSharingPdfToWhatsAppNotifier.value,
    );
  }
}
