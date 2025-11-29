import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
// import 'package:bookie_buddy_web/features/add_booking/view_model/cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/models/sales_request_model/sales_request_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Add or Edit Sales screen controllers and keys
class AddOrEditSalesFormStateController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Date
  final saleDateController = TextEditingController();

  // Client
  final nameController = TextEditingController();
  final phone1Controller = TextEditingController();
  final phone2Controller = TextEditingController();

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
  final isClientSearchEnabledNotifier = ValueNotifier<bool>(false);

  final stockCountDecreaseNotifier = ValueNotifier<bool>(true);

  final paymentMethodNotifier = ValueNotifier(PaymentMethod.gPay);

  void dispose() {
    saleDateController.dispose();
    nameController.dispose();
    phone1Controller.dispose();
    phone2Controller.dispose();
    placeController.dispose();
    discountController.dispose();
    descriptionController.dispose();
    staffNameController.dispose();
    selectedProductsNotifier.dispose();
    isClientSearchEnabledNotifier.dispose();
    stockCountDecreaseNotifier.dispose();
    paymentMethodNotifier.dispose();
  }

  void setInitialValues(SaleDetailsModel saleDetails, BuildContext context) {
    saleDateController.text = saleDetails.saleDate.formatToUiDate();

    staffNameController.text = saleDetails.staffName ?? 'Staff Name';

    if (saleDetails.client != null) {
      nameController.text = saleDetails.client!.name;
      phone1Controller.text = saleDetails.client!.phone1.toString();
      if (saleDetails.client!.phone2 != null) {
        phone2Controller.text = saleDetails.client!.phone2.toString();
      }
      context.read<ClientCubit>().selectClient(saleDetails.client!);
    } else if (saleDetails.clientPhone != null) {
      phone1Controller.text = saleDetails.clientPhone.toString();
    }
    paymentMethodNotifier.value = saleDetails.paymentMethod;
    if (saleDetails.address.isNotNullOrEmpty) {
      placeController.text = saleDetails.address;
    }
    descriptionController.text = saleDetails.description;
    if (saleDetails.discountAmount > 0)
      discountController.text = saleDetails.discountAmount.toString();

    isClientSearchEnabledNotifier.value = true;

    selectedProductsNotifier.value = saleDetails.products
        .map(
          (e) => ProductSelectedModel(
            amount: e.price,
            quantity: e.quantity,
            variant: ProductInfoModel(
              id: e.id,
              productId: e.productId,
              variantId: e.variantId,
              name: e.name,
              image: e.image,
              quantity: e.quantity,
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

    final isExistingClient = isClientSearchEnabledNotifier.value;
    final selectedClient = context.read<ClientCubit>().getSelectedClient();
    if (selectedClient == null && isExistingClient) {
      context.showSnackBar(
        'Please select a client',
        title: 'Client Required',
        isError: true,
      );
      return null;
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
      bool clientChanged = false;
      if (isExistingClient) {
        clientChanged = selectedClient?.id != original.client?.id;
      } else {
        clientChanged = nameController.text.trim() != original.client?.name ||
            phone1Controller.text.trim() != original.client?.phone1.toString() ||
            (phone2Controller.text.trim().isNotEmpty
                    ? phone2Controller.text.trim()
                    : null) !=
                original.client?.phone2?.toString();
      }

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
          // final match = original.products.firstWhere(
          //   (op) =>
          //       op.id == p.variant.id && op.variantId == p.variant.variantId,
          //   orElse: () => const SaleProductModelPlaceholder(),
          // );
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
          clientChanged ||
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

      final client = clientChanged && !isExistingClient
          ? ClientRequestModel(
              id: null,
              name: nameController.text.trim(),
              phone1: phone1Controller.text.trim().toInt(),
              phone2: phone2Controller.text.trim().toIntOrNull(),
            )
          : null;
      return SalesRequestModel(
        id: original.id,
        saleDate: saleDateChanged ? currentSaleDate : null,
        staffId: isStaffChanged ? selectedStaff?.id : null,
        clientId: clientChanged && isExistingClient ? selectedClient?.id : null,
        clientName: client?.name,
        clientPhone1: client?.phone1?.toString(),
        clientPhone2: client?.phone2?.toString(),
        address: addressChanged ? placeController.text.trim() : null,
        products:
            productsChanged && newProducts.isNotEmpty ? newProducts : null,
        description:
            descriptionChanged ? descriptionController.text.trim() : null,
        discountAmount: discountChanged ? discountAmount : null,
        paymentMethod:
            paymentMethodChanged ? paymentMethodNotifier.value : null,
      );
    }
    final client = isExistingClient
        ? null
        : ClientRequestModel(
            id: null,
            name: nameController.text.trim(),
            phone1: phone1Controller.text.trim().toInt(),
            phone2: phone2Controller.text.trim().toIntOrNull(),
          );
    return SalesRequestModel(
      saleDate: saleDateController.text.formatToUiDate(),
      staffId: selectedStaff?.id,
      clientId: isExistingClient ? selectedClient?.id : null,
      clientName: client?.name,
      clientPhone1: client?.phone1?.toString(),
      clientPhone2: client?.phone2?.toString(),
      address: placeController.text.trim(),
      products: selectedProductsNotifier.value,
      stockCountDecrease: stockCountDecreaseNotifier.value,
      description: descriptionController.text.trim(),
      discountAmount: discountAmount,
      paidAmount: totalAmount - discountAmount,
      paymentMethod: paymentMethodNotifier.value,
    );
  }
}
