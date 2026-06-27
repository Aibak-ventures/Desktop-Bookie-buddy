import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_phone_populator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

class OldBookingContentWidget extends StatefulWidget {
  final Widget dateSection;
  final Widget serviceSection;
  final TextEditingController clientNameController;
  final PhoneController phone1FieldController;
  final PhoneController phone2FieldController;
  final TextEditingController clientPhone1Controller;
  final TextEditingController clientPhone2Controller;
  final TextEditingController clientAddressController;
  final TextEditingController descriptionController;
  final AccountEntity? selectedAdvanceAccount;
  final ValueChanged<AccountEntity?> onAdvanceAccountChanged;
  final ValueNotifier<List<ProductSelectedEntity>> selectedProductsNotifier;
  final String? clientNameError;
  final void Function(int? clientId) onClientIdChanged;
  final void Function({required String rawPhoneNumber, required String? e164}) onCachePhoneE164;
  final int Function(ProductSelectedEntity product) getDaysMultiplier;
  final VoidCallback onConfirm;

  static const double _fieldSpacing = 8.0;

  const OldBookingContentWidget({
    super.key,
    required this.dateSection,
    required this.serviceSection,
    required this.clientNameController,
    required this.phone1FieldController,
    required this.phone2FieldController,
    required this.clientPhone1Controller,
    required this.clientPhone2Controller,
    required this.clientAddressController,
    required this.descriptionController,
    required this.selectedAdvanceAccount,
    required this.onAdvanceAccountChanged,
    required this.selectedProductsNotifier,
    required this.clientNameError,
    required this.onClientIdChanged,
    required this.onCachePhoneE164,
    required this.getDaysMultiplier,
    required this.onConfirm,
  });

  @override
  State<OldBookingContentWidget> createState() =>
      _OldBookingContentWidgetState();
}

class _OldBookingContentWidgetState extends State<OldBookingContentWidget> {
  // Focus chain so Enter/Next moves through the client fields in order:
  // name → phone 1 → phone 2 → address → notes.
  final _nameFocusNode = FocusNode();
  final _phone1FocusNode = FocusNode();
  final _phone2FocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _notesFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _phone1FocusNode.dispose();
    _phone2FocusNode.dispose();
    _addressFocusNode.dispose();
    _notesFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.dateSection,
              const SizedBox(height: 16),
              Expanded(child: widget.serviceSection),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(width: 340, child: _buildRightPanel(context)),
      ],
    );
  }

  Widget _buildRightPanel(BuildContext context) {
    const fieldSpacing = OldBookingContentWidget._fieldSpacing;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Client',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  BlocListener<ClientCubit, ClientState>(
                    listener: (context, state) {
                      if (state.selectedClient != null) {
                        final client = state.selectedClient!;
                        widget.clientNameController.text = client.name;
                        BookingPhonePopulator.setPhoneFieldValue(
                          widget.phone1FieldController,
                          widget.clientPhone1Controller,
                          phoneNumber: client.phone1 > 0 ? client.phone1.toString() : null,
                          e164: client.phone1E164,
                        );
                        BookingPhonePopulator.setPhoneFieldValue(
                          widget.phone2FieldController,
                          widget.clientPhone2Controller,
                          phoneNumber: (client.phone2 ?? 0) > 0 ? client.phone2.toString() : null,
                          e164: client.phone2E164,
                        );
                        widget.onClientIdChanged(client.id);
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: widget.clientNameController,
                      errorText: widget.clientNameError,
                      hitText: 'Type or search name',
                      focusNode: _nameFocusNode,
                      onSubmitName: () => _phone1FocusNode.requestFocus(),
                    ),
                  ),
                  const SizedBox(height: fieldSpacing),
                  CustomPhoneNumberField(
                    controller: widget.phone1FieldController,
                    hintText: 'Client Phone',
                    focusNode: _phone1FocusNode,
                    nextFocusNode: _phone2FocusNode,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      widget.onCachePhoneE164(
                        rawPhoneNumber: digits,
                        e164: phoneNumberToE164(phone),
                      );
                      if (widget.clientPhone1Controller.text != digits) {
                        widget.clientPhone1Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: fieldSpacing),
                  CustomPhoneNumberField(
                    controller: widget.phone2FieldController,
                    hintText: 'Client Phone 2 (Optional)',
                    isRequired: false,
                    focusNode: _phone2FocusNode,
                    nextFocusNode: _addressFocusNode,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      widget.onCachePhoneE164(
                        rawPhoneNumber: digits,
                        e164: phoneNumberToE164(phone),
                      );
                      if (widget.clientPhone2Controller.text != digits) {
                        widget.clientPhone2Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: widget.clientAddressController,
                    hint: 'Place / Address',
                    prefixIcon: Icons.location_on,
                    focusNode: _addressFocusNode,
                    nextFocusNode: _notesFocusNode,
                  ),
                  const SizedBox(height: fieldSpacing),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: widget.descriptionController,
                      focusNode: _notesFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Notes / Description',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: fieldSpacing * 2),
                  AccountSelectionField(
                    selectedAccount: widget.selectedAdvanceAccount,
                    onChanged: widget.onAdvanceAccountChanged,
                    label: 'Payment Option',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                ValueListenableBuilder<List<ProductSelectedEntity>>(
                  valueListenable: widget.selectedProductsNotifier,
                  builder: (context, products, _) {
                    final total = products.fold<int>(
                      0,
                      (sum, p) => sum + (p.amount * p.quantity * widget.getDaysMultiplier(p)),
                    );
                    return Text(
                      total.toCurrency(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6132E4),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save Old Booking',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
