import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
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

class AddOrEditSalesScreen extends StatefulWidget {
  const AddOrEditSalesScreen({super.key, this.saleDetails});

  final SaleDetailsModel? saleDetails;

  @override
  State<AddOrEditSalesScreen> createState() => _AddOrEditSalesScreenState();
}

class _AddOrEditSalesScreenState extends State<AddOrEditSalesScreen> {
  // Use this controller to manage the form state and other controllers used in this screen
  final _formController = AddOrEditSalesFormStateController();
  late final Listenable _totalAmountListener;
  @override
  void initState() {
    super.initState();
    if (widget.saleDetails != null) {
      _formController.setInitialValues(widget.saleDetails!, context);
    } else {
      _formController.saleDateController.text = DateTime.now().format();
    }
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
    final isEditMode = widget.saleDetails != null;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditMode ? 'Edit Sales' : 'Add Sales'),
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
              AddOrEditSalesSection(
                title: 'Date',
                child: Column(
                  children: [
                    CustomTextField(
                      ignorePointers: true,
                      controller: _formController.saleDateController,
                      keyboardType: TextInputType.datetime,
                      validator: (value) => null,
                      hintText: 'Select Booked Date',
                      label: 'Booked Date',
                    ).onTap(() => selectBookedDate(context)),
                  ],
                ),
              ),
              15.height,
              StaffSearchNameField(
                nameController: _formController.staffNameController,
              ),
              15.height,
              buildClientSection(),
              15.height,
              AddOrEditSalesProductsSection(
                selectedProductsNotifier:
                    _formController.selectedProductsNotifier,
                stockCountDecreaseNotifier:
                    _formController.stockCountDecreaseNotifier,
                pickUpDateController: _formController.saleDateController,
                returnDateController: _formController.saleDateController,
                isEditMode: isEditMode,
              ),
              20.height,
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
              AddOrEditSalesSection(
                title: 'Payment Details',
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _formController.paymentMethodNotifier,
                      builder: (context, paymentMethod, child) => RadioGroup(
                        onChanged: (value) {
                          if (value != null)
                            _formController.paymentMethodNotifier.value = value;
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
                      validator: (value) => AppInputValidators.isEmpty(value)
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
                        final total = products.fold(
                              0,
                              (pv, e) => pv + (e.variant.quantity * e.amount),
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
                            if (isEditMode) {
                              if (widget.saleDetails?.id != null)
                                context.pop(true);
                              context.showSnackBar(
                                message ?? 'Sales updated successfully',
                              );
                            } else {
                              context.push(
                                SuccessAnimationScreen(
                                  text: 'Sales saved successfully',
                                  afterSuccess: () {
                                    context
                                      ..pop()
                                      ..pop();
                                  },
                                ),
                              );
                            }
                          },
                          failure: (failure) {
                            context.showSnackBar(failure, isError: true);
                          },
                        );
                      },
                      builder: (context, state) {
                        final isSaving = state.maybeMap(
                          orElse: () => false,
                          saving: (_) => true,
                        );
                        return CustomElevatedButton(
                          text: 'Submit',
                          isLoading: isSaving,
                          width: double.infinity,
                          onPressed: () {
                            final req = _formController.buildRequest(
                              saleDetails: widget.saleDetails,
                              context: context,
                            );
                            log('Sales Request: $req');
                            if (req == null) return;
                            context.read<SaveSalesCubit>().saveSales(
                                  salesRequest: req,
                                  isEditMode: isEditMode,
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

  Widget buildClientSection() => Column(
        children: [
          ClientSelectWidget(
            nameController: _formController.nameController,
            phone1Controller: _formController.phone1Controller,
            phone2Controller: _formController.phone2Controller,
            textSize: 16,
            spacing: 15,
            isClientSearchEnabledNotifier:
                _formController.isClientSearchEnabledNotifier,
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
                validator: AppInputValidators.address,
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

  // booked date function
  Future<void> selectBookedDate(BuildContext context) async {
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

  // -------- Discard Changes Helpers (explicit comparisons like EditBookingScreen) --------
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
    // If editing, compare against original sale details
    final original = widget.saleDetails;
    final products = _formController.selectedProductsNotifier.value;
    final discountText = _formController.discountController.text.trim();

    // Creation mode: if no original, detect any user input
    if (original == null) {
      final anyClientInput =
          _formController.nameController.text.trim().isNotEmpty ||
              _formController.phone1Controller.text.trim().isNotEmpty ||
              _formController.phone2Controller.text.trim().isNotEmpty;
      final anyOther = _formController.placeController.text.trim().isNotEmpty ||
          _formController.descriptionController.text.trim().isNotEmpty ||
          discountText.isNotEmpty ||
          products.isNotEmpty;
      // Sale date controller is always set (today) so ignore that.
      return anyClientInput || anyOther;
    }

    bool changed = false;

    // Sale date
    if (_formController.saleDateController.text.formatToUiDate() !=
        original.saleDate.formatToUiDate()) changed = true;

    // Client (existing vs new not strictly needed; treat by field diff)
    if (_formController.nameController.text.trim() != original.client.name)
      changed = true;
    if (_formController.phone1Controller.text.trim() !=
        original.client.phone1.toString()) changed = true;
    if ((_formController.phone2Controller.text.trim().isNotEmpty
            ? _formController.phone2Controller.text.trim()
            : '') !=
        (original.client.phone2?.toString() ?? '')) changed = true;

    // Address
    if (_formController.placeController.text.trim() != original.address.trim())
      changed = true;

    // Description
    if (_formController.descriptionController.text.trim() !=
        original.description.trim()) changed = true;

    // Discount
    final originalDiscount =
        original.discountAmount > 0 ? original.discountAmount.toString() : '';
    if (discountText != originalDiscount) changed = true;

    // Payment method
    if (_formController.paymentMethodNotifier.value != original.paymentMethod)
      changed = true;

    // Products comparison (length + each id/variant/qty/amount)
    if (!changed) {
      if (products.length != original.products.length) {
        changed = true;
      } else {
        for (final p in products) {
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
            changed = true;
            break;
          }
        }
      }
    }

    return changed;
  }
}
