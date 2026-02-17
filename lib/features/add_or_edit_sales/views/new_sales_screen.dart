import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/widgets/add_or_edit_sales_products_section.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/widgets/add_or_edit_sales_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/enums/payment_method_enums.dart';

/// New Sales Screen - Dedicated screen for creating new sales
/// This is a simplified version of AddOrEditSalesScreen focused only on creation
class NewSalesScreen extends StatefulWidget {
  const NewSalesScreen({super.key});

  @override
  State<NewSalesScreen> createState() => _NewSalesScreenState();
}

class _NewSalesScreenState extends State<NewSalesScreen> {
  // Use this controller to manage the form state and other controllers used in this screen
  final _formController = AddOrEditSalesFormStateController();
  late final Listenable _totalAmountListener;

  @override
  void initState() {
    super.initState();
    // Initialize with today's date
    _formController.saleDateController.text = DateTime.now().format();

    _totalAmountListener = Listenable.merge([
      _formController.discountController,
      _formController.selectedProductsNotifier,
    ]);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('New Sale'),
          leading: BackButton(
            onPressed: () async {
              if (_hasUnsavedChanges()) {
                final discard = await showDiscardDialog(context);
                if (discard ?? false) {
                  if (context.mounted) Navigator.of(context).pop();
                }
              } else {
                if (context.mounted) Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Form(
              key: _formController.formKey,
              child: ListView(
                padding: context.isMobile ? 16.padding : (40, 24).padding,
                children: [
                  // ---- Date ----
                  AddOrEditSalesSection(
                    title: 'Date',
                    child: Column(
                      children: [
                        CustomTextField(
                          ignorePointers: true,
                          controller: _formController.saleDateController,
                          keyboardType: TextInputType.datetime,
                          validator: (value) => null,
                          hintText: 'Select Sale Date',
                          label: 'Sale Date',
                        ).onTap(() => selectSaleDate(context)),
                      ],
                    ),
                  ),
                  15.height,

                  // ---- Staff ----
                  StaffSearchNameField(
                    nameController: _formController.staffNameController,
                  ),
                  15.height,

                  // ---- Client section (phone + place, no client search) ----
                  buildClientSection(),
                  15.height,

                  // ---- Products ----
                  AddOrEditSalesProductsSection(
                    selectedProductsNotifier:
                        _formController.selectedProductsNotifier,
                    stockCountDecreaseNotifier:
                        _formController.stockCountDecreaseNotifier,
                    pickUpDateController: _formController.saleDateController,
                    returnDateController: _formController.saleDateController,
                    isEditMode: false,
                  ),

                  20.height,

                  // ---- Description ----
                  Stack(
                    children: [
                      CustomTextField(
                        controller: _formController.descriptionController,
                        hintText: 'Description (Optional)',
                        prefixIcon: const SizedBox.shrink(),
                        maxLines: 3,
                        validator: (value) => AppInputValidators.isEmpty(value)
                            ? null
                            : AppInputValidators.description(value),
                      ),
                      Positioned(
                        top: 16,
                        left: 12,
                        child: Icon(
                          Icons.description,
                          color: AppColors.purple.lighten(0.2),
                        ),
                      ),
                    ],
                  ),

                  20.height,

                  // ---- Payment Details ----
                  AddOrEditSalesSection(
                    title: 'Payment Details',
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable:
                              _formController.paymentMethodNotifier,
                          builder: (context, paymentMethod, child) =>
                              RadioGroup(
                            onChanged: (value) {
                              if (value != null) {
                                _formController.paymentMethodNotifier.value =
                                    value;
                              }
                            },
                            groupValue: paymentMethod,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(PaymentMethod.gPay.name),
                                    value: PaymentMethod.gPay,
                                    activeColor: AppColors.purple,
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: Text(PaymentMethod.cash.name),
                                    value: PaymentMethod.cash,
                                    activeColor: AppColors.purple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        15.height,
                        CustomTextField(
                          controller: _formController.discountController,
                          hintText: 'Discount Amount (Optional)',
                          label: 'Discount Amount (Optional)',
                          prefixIcon: const Icon(Icons.currency_rupee),
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              AppInputValidators.isEmpty(value)
                                  ? null
                                  : AppInputValidators.amount(
                                      value,
                                      allowZero: true,
                                      fieldName: 'Discount',
                                    ),
                        ),
                      ],
                    ),
                  ),

                  20.height,

                  // ---- Total + Submit ----
                  Row(
                    children: [
                      Expanded(
                        child: ListenableBuilder(
                          listenable: _totalAmountListener,
                          builder: (context, child) {
                            final products =
                                _formController.selectedProductsNotifier.value;
                            final discountText =
                                _formController.discountController.text;
                            final total = products.fold<int>(
                                  0,
                                  (pv, e) =>
                                      pv + (e.variant.quantity * e.amount),
                                ) -
                                (discountText.trim().isNotEmpty
                                    ? discountText.toIntOrNull() ?? 0
                                    : 0);
                            return Center(
                              child: Text(
                                'Total: ${total.toCurrency()}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: BlocConsumer<SaveSalesCubit, SaveSalesState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              success: (message) {
                                context.push(
                                  SuccessAnimationScreen(
                                    text: 'Sale created successfully!',
                                    afterSuccess: () {
                                      context
                                        ..pop()
                                        ..pop();
                                    },
                                  ),
                                );
                              },
                              failure: (failure) {
                                context.showSnackBar(
                                  failure,
                                  isError: true,
                                );
                              },
                            );
                          },
                          builder: (context, state) {
                            final isSaving = state.maybeMap(
                              orElse: () => false,
                              saving: (_) => true,
                            );
                            return CustomElevatedButton(
                              text: 'Create Sale',
                              isLoading: isSaving,
                              width: double.infinity,
                              onPressed: () {
                                final req = _formController.buildRequest(
                                  saleDetails: null,
                                  context: context,
                                );
                                log('Sales Request: $req');
                                if (req == null) return;
                                context.read<SaveSalesCubit>().saveSales(
                                      salesRequest: req,
                                      isEditMode: false,
                                    );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- Client section: phone + place fields ----
  Widget buildClientSection() => Column(
        children: [
          CustomTextField(
            controller: _formController.clientPhoneController,
            hintText: 'Client Phone Number',
            label: 'Client Phone Number',
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone),
            validator: (value) =>
                AppInputValidators.phoneNumber(value, isRequired: false),
          ),
          15.height,
          Stack(
            children: [
              CustomTextField(
                controller: _formController.placeController,
                keyboardType: TextInputType.streetAddress,
                hintText: 'Place',
                prefixIcon: const SizedBox.shrink(),
                maxLines: 3,
                validator: (value) => AppInputValidators.isEmpty(value)
                    ? null
                    : AppInputValidators.address(value),
              ),
              Positioned(
                top: 16,
                left: 12,
                child: Icon(
                  Icons.location_on,
                  color: AppColors.purple.lighten(0.2),
                ),
              ),
            ],
          ),
        ],
      );

  // Sale date picker
  Future<void> selectSaleDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _formController.saleDateController.text.isEmpty
          ? DateTime.now()
          : _formController.saleDateController.text.parseToDateTime(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _formController.saleDateController.text = picked.format();
    }
  }

  // -------- Discard Changes Helpers --------
  void _handlePop(bool didPop, dynamic result) async {
    if (didPop) return;
    if (_hasUnsavedChanges()) {
      final discard = await showDiscardDialog(context);
      if (discard ?? false) {
        if (context.mounted) Navigator.pop(context, result);
      }
    } else {
      if (context.mounted) Navigator.pop(context, result);
    }
  }

  bool _hasUnsavedChanges() {
    final products = _formController.selectedProductsNotifier.value;
    final discountText = _formController.discountController.text.trim();

    final anyClientInput =
        _formController.clientPhoneController.text.trim().isNotEmpty;
    final anyOther = _formController.placeController.text.trim().isNotEmpty ||
        _formController.descriptionController.text.trim().isNotEmpty ||
        discountText.isNotEmpty ||
        products.isNotEmpty;

    return anyClientInput || anyOther;
  }
}
