import 'dart:developer';

import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
// 🔴 Removed client_select_widget import
// import 'package:bookie_buddy_web/core/ui/widgets/client_select_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_button.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/add_or_edit_sales_products_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/add_or_edit_sales_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/enums/payment_method_enums.dart';

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
                          hintText: 'Select Booked Date',
                          label: 'Booked Date',
                        ).onTap(() => selectBookedDate(context)),
                      ],
                    ),
                  ),
                  15.height,

                  // ---- Staff (same as mobile) ----
                  StaffSearchNameField(
                    nameController: _formController.staffNameController,
                  ),
                  15.height,

                  // ---- Client section (matched to mobile: phone + place, no client search) ----
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
                    isEditMode: isEditMode,
                  ),

                  20.height,

                  // ---- WhatsApp & Stock Checkboxes ----
                  ValueListenableBuilder(
                    valueListenable:
                        _formController.isSharingPdfToWhatsAppNotifier,
                    builder: (context, isSharingPdf, __) => Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Column(
                        children: [
                          // WhatsApp checkbox
                          CheckboxListTile(
                            value: isSharingPdf,
                            onChanged: (value) {
                              _formController.isSharingPdfToWhatsAppNotifier
                                  .value = value ?? false;
                            },
                            activeColor: AppColors.purple,
                            title: const Text(
                              'Send PDF to WhatsApp',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          // Decrease Stock checkbox - only show for past dates
                          ValueListenableBuilder(
                            valueListenable:
                                _formController.stockCountDecreaseNotifier,
                            builder: (context, stockCountDecrease, __) {
                              // Check if selected date is in the past
                              final saleDateText =
                                  _formController.saleDateController.text;
                              bool isPastDate = false;
                              if (saleDateText.isNotEmpty) {
                                try {
                                  final saleDate = saleDateText
                                      .formatToUiDate()
                                      .parseToDateTime();
                                  final today = DateTime.now();
                                  final todayDate = DateTime(
                                      today.year, today.month, today.day);
                                  final selectedDate = DateTime(saleDate.year,
                                      saleDate.month, saleDate.day);
                                  isPastDate = selectedDate.isBefore(todayDate);
                                } catch (e) {
                                  isPastDate = false;
                                }
                              }

                              if (!isPastDate) return const SizedBox.shrink();

                              return Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F2FE),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: AppColors.purple,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CheckboxListTile(
                                                value: stockCountDecrease,
                                                onChanged: (value) {
                                                  _formController
                                                      .stockCountDecreaseNotifier
                                                      .value = value ?? true;
                                                },
                                                activeColor: AppColors.purple,
                                                title: const Text(
                                                  'Decrease Stock quantity',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                subtitle: const Text(
                                                  'If unchecked, the stock quantity will not be decreased from the inventory',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                contentPadding: EdgeInsets.zero,
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                if (isEditMode) {
                                  if (widget.saleDetails?.id != null) {
                                    context.pop(true);
                                  }
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

  // ---- Client section: same fields as mobile (phone + place), no search client ----
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
                // Optional address – same pattern as description/discount
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
    // If editing, compare against original sale details
    final original = widget.saleDetails;
    final products = _formController.selectedProductsNotifier.value;
    final discountText = _formController.discountController.text.trim();

    // Creation mode: if no original, detect any user input
    if (original == null) {
      final anyClientInput =
          _formController.clientPhoneController.text.trim().isNotEmpty;
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
        original.saleDate.formatToUiDate()) {
      changed = true;
    }

    // Client phone
    if (_formController.clientPhoneController.text.trim() !=
        original.clientPhone.toString()) {
      changed = true;
    }

    // Address
    if (_formController.placeController.text.trim() !=
        original.address.trim()) {
      changed = true;
    }

    // Description
    if (_formController.descriptionController.text.trim() !=
        original.description.trim()) {
      changed = true;
    }

    // Discount
    final originalDiscount =
        original.discountAmount > 0 ? original.discountAmount.toString() : '';
    if (discountText != originalDiscount) {
      changed = true;
    }

    // Payment method
    if (_formController.paymentMethodNotifier.value != original.paymentMethod) {
      changed = true;
    }

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
