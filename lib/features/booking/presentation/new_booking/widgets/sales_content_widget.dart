part of '../pages/new_booking_screen.dart';

extension SalesFlowBuilders on NewBookingScreenState {
  Widget _buildSalesSinglePanel() {
    return Container(
      key: const ValueKey(2),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Phone
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Client Phone (WP)',
                    isRequired: false,
                    textInputAction: TextInputAction.done,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      cachePhoneE164(
                        rawPhoneNumber: digits,
                        e164: phoneNumberToE164(phone),
                      );
                      if (clientPhone1Controller.text != digits) {
                        clientPhone1Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(
                            offset: digits.length,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'Place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: _staffNameFocusNode,
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Staff Details
                  const Text(
                    'Staff',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 7),
                  StaffSearchNameField(
                    nameController: staffNameController,
                    errorText: _staffNameError,
                    focusNode: _staffNameFocusNode,
                    nextFocusNode: _notesFocusNode,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Notes
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
                      controller: descriptionController,
                      focusNode: _notesFocusNode,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Notes',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Discount
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: discountAmountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing + 8),

                  // Payment Method
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 16),

                  // WhatsApp Checkbox
                  if (context.read<UserCubit>().hasFeature(
                    AppPremiumFeatures.whatsappMessage,
                  ))
                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(
                            value: sendPdfToWhatsApp,
                            onChanged: (v) =>
                                setState(() => sendPdfToWhatsApp = v ?? false),
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

                  // Past Date Checkbox - Only show for sales with past dates
                  if (selectedBookingType == BookingType.sales && _isPastDate())
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F2FE),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: decreaseStockForPastDate,
                                onChanged: (v) => setState(
                                  () => decreaseStockForPastDate = v ?? false,
                                ),
                                activeColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Decrease Stock quantity',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'If unchecked, the stock quantity will not be decreased from the inventory',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Fixed Bottom Section with Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSummarySection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
