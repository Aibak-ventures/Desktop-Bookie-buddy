import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingClientDetailsPanel extends StatefulWidget {
  final BookingFormControllers form;
  final bool isSales;
  final String? clientNameError;
  final String? phoneError;
  final String? staffNameError;
  final bool sendPdfToWhatsApp;
  final ValueChanged<bool> onSendPdfChanged;
  final VoidCallback onContinue;
  final int Function() calculateRentalDays;

  const BookingClientDetailsPanel({
    super.key,
    required this.form,
    required this.isSales,
    required this.clientNameError,
    required this.phoneError,
    required this.staffNameError,
    required this.sendPdfToWhatsApp,
    required this.onSendPdfChanged,
    required this.onContinue,
    required this.calculateRentalDays,
  });

  @override
  State<BookingClientDetailsPanel> createState() =>
      _BookingClientDetailsPanelState();
}

class _BookingClientDetailsPanelState
    extends State<BookingClientDetailsPanel>
    with BookingFormMixin<BookingClientDetailsPanel> {
  static const double _fieldSpacing = 8.0;

  bool _isSummaryExpanded = false;

  @override
  BookingFormControllers get form => widget.form;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey(0),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Details Header
                  const Text(
                    'Client details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Name - Only show for bookings
                  if (!widget.isSales) ...[
                    BlocListener<ClientCubit, ClientState>(
                      listener: (context, state) {
                        if (state.selectedClient != null) {
                          final client = state.selectedClient!;
                          form.clientNameController.text = client.name;
                          final phone1 =
                              extractPhoneFromE164(client.phone1E164);
                          if (phone1.isNotEmpty) {
                            cachePhoneE164(
                              rawPhoneNumber: phone1,
                              e164: client.phone1E164,
                            );
                            form.clientPhone1Controller.text = phone1;
                          }
                          if (client.phone2E164 != null) {
                            final phone2 =
                                extractPhoneFromE164(client.phone2E164);
                            if (phone2.isNotEmpty) {
                              cachePhoneE164(
                                rawPhoneNumber: phone2,
                                e164: client.phone2E164,
                              );
                              form.clientPhone2Controller.text = phone2;
                            }
                          }
                          form.selectedClientId = client.id;
                        }
                      },
                      child: ClientSearchNameField(
                        nameController: form.clientNameController,
                        focusNode: form.clientNameFocusNode,
                        hitText: 'Type or Search name',
                        onClear: () {
                          form.clientNameController.clear();
                          form.clientPhone1Controller.clear();
                          form.clientPhone2Controller.clear();
                          form.clientAddressController.clear();
                          form.selectedClientId = null;
                        },
                        errorText: widget.clientNameError,
                      ),
                    ),
                    const SizedBox(height: _fieldSpacing),
                  ],

                  // Phone 1 (WhatsApp) - Always enabled
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.clientPhone1Controller,
                    hint: 'Whatsapp number',
                    isNumber: true,
                    focusNode: form.clientPhone1FocusNode,
                    nextFocusNode: form.clientPhone2FocusNode,
                    errorText: widget.phoneError,
                    prefixSvgAsset: AppAssets.whatsAppSvg,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Phone 2 - Optional, only show for bookings
                  if (!widget.isSales)
                    BookingTextFieldBuilder.buildRightPanelTextField(
                      controller: form.clientPhone2Controller,
                      hint: 'Phone 2',
                      isNumber: true,
                      focusNode: form.clientPhone2FocusNode,
                      nextFocusNode: form.clientAddressFocusNode,
                      prefixIcon: Icons.phone,
                    ),
                  const SizedBox(height: _fieldSpacing),

                  // Place - Optional
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: form.clientAddressController,
                    hint: 'place',
                    focusNode: form.clientAddressFocusNode,
                    nextFocusNode: null,
                    prefixIcon: Icons.location_on,
                  ),

                  const SizedBox(height: _fieldSpacing),
                  const SizedBox(height: 16),

                  // WhatsApp Checkbox - Only if feature enabled
                  if (context.read<UserCubit>().hasFeature(
                    AppPremiumFeatures.whatsappMessage,
                  ))
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: widget.sendPdfToWhatsApp,
                            onChanged: (v) =>
                                widget.onSendPdfChanged(v ?? false),
                            activeColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Send invoice to whatsapp',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 7),

                  // Staff Details - Required
                  Row(
                    children: [
                      const Text(
                        'Staff details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '*',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),

                  StaffSearchNameField(
                    nameController: form.staffNameController,
                    errorText: widget.staffNameError,
                  ),

                  const SizedBox(height: 7),

                  // Notes - Optional
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: form.descriptionController,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Notes',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),

                  const SizedBox(height: 7),

                  // Running Kilometers - Only for Vehicles
                  ValueListenableBuilder<List<ProductSelectedEntity>>(
                    valueListenable: form.selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return BookingTextFieldBuilder.buildRightPanelTextField(
                        controller: form.runningKilometersController,
                        hint: 'Running Kilometers',
                        isNumber: true,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Expandable summary section in step 1
          ListenableBuilder(
            listenable: Listenable.merge([
              form.selectedProductsNotifier,
              form.additionalChargesNotifier,
              form.advanceAmountController,
              form.discountAmountController,
            ]),
            builder: (context, _) {
              final products = form.selectedProductsNotifier.value;
              if (products.isEmpty) return const SizedBox.shrink();

              final additionalCharges = form.additionalChargesNotifier.value;
              final advanceAmount = widget.isSales
                  ? 0
                  : (form.advanceAmountController.text.trim().toIntOrNull() ??
                        0);
              final discountAmount =
                  form.discountAmountController.text.trim().toIntOrNull() ?? 0;

              final rentalDays =
                  !widget.isSales ? widget.calculateRentalDays() : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                final daysMultiplier =
                    (!widget.isSales &&
                        shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (rentalDays > 0 ? rentalDays : 1)
                    : 1;
                return sum +
                    (product.amount * product.quantity * daysMultiplier);
              });
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );
              final totalPayable =
                  productTotal + additionalTotal - discountAmount;
              final remainingAmount = totalPayable - advanceAmount;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 245, 242, 254),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF6132E4).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Collapsed view - always visible
                      InkWell(
                        onTap: () => setState(
                          () => _isSummaryExpanded = !_isSummaryExpanded,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.receipt_long_rounded,
                                    size: 16,
                                    color: Color(0xFF6132E4),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    !widget.isSales && rentalDays > 1
                                        ? 'Total ($rentalDays days)'
                                        : 'Total amount',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF3E3E3E),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₹${remainingAmount > 0 ? remainingAmount : 0}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6132E4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    _isSummaryExpanded
                                        ? Icons.keyboard_arrow_up_rounded
                                        : Icons.keyboard_arrow_down_rounded,
                                    size: 20,
                                    color: const Color(0xFF6132E4),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Expanded breakdown
                      if (_isSummaryExpanded)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                          child: Column(
                            children: [
                              const Divider(height: 8, thickness: 1),
                              const SizedBox(height: 4),
                              buildSummaryRow('Product total', productTotal),
                              if (additionalTotal > 0)
                                buildSummaryRow(
                                  'Additional charges',
                                  additionalTotal,
                                ),
                              if (discountAmount > 0)
                                buildSummaryRow(
                                  '- Discount',
                                  discountAmount,
                                  isNegative: true,
                                ),
                              const Divider(height: 12, thickness: 1),
                              if (!widget.isSales && advanceAmount > 0)
                                buildSummaryRow(
                                  'Paid',
                                  advanceAmount,
                                  valueColor: const Color(0xFF1AB000),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          // Bottom Button - Continue
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: widget.onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6132E4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
