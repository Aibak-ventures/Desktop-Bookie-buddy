part of '../pages/new_booking_screen.dart';

extension OldBookingFlowBuilders on NewBookingScreenState {
  Widget _buildOldBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: dates + product search / table
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateSelectionSection(),
              const SizedBox(height: 16),
              Expanded(child: _buildServiceSelectionSection()),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right: client details + summary + submit
        SizedBox(width: 340, child: _buildOldBookingRightPanel()),
      ],
    );
  }

  Widget _buildOldBookingRightPanel() {
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
                  // Client Name
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
                        clientNameController.text = client.name;
                        BookingPhonePopulator.setPhoneFieldValue(
                          _clientPhone1FieldController,
                          clientPhone1Controller,
                          phoneNumber: client.phone1 > 0
                              ? client.phone1.toString()
                              : null,
                          e164: client.phone1E164,
                        );
                        BookingPhonePopulator.setPhoneFieldValue(
                          _clientPhone2FieldController,
                          clientPhone2Controller,
                          phoneNumber: (client.phone2 ?? 0) > 0
                              ? client.phone2.toString()
                              : null,
                          e164: client.phone2E164,
                        );
                        selectedClientId = client.id;
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: clientNameController,
                      errorText: _clientNameError,
                      hitText: 'Type or search name',
                    ),
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Client Phone
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Client Phone',
                    textInputAction: TextInputAction.next,
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

                  // Client Phone 2
                  CustomPhoneNumberField(
                    controller: _clientPhone2FieldController,
                    hintText: 'Client Phone 2 (Optional)',
                    isRequired: false,
                    textInputAction: TextInputAction.next,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(
                        RegExp(r'[^0-9]'),
                        '',
                      );
                      cachePhoneE164(
                        rawPhoneNumber: digits,
                        e164: phoneNumberToE164(phone),
                      );
                      if (clientPhone2Controller.text != digits) {
                        clientPhone2Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(
                            offset: digits.length,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Address
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'Place / Address',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Notes / Description
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
                  const SizedBox(height: NewBookingScreenState._fieldSpacing + NewBookingScreenState._fieldSpacing),

                  // Payment Account
                  AccountSelectionField(
                    selectedAccount: selectedAdvanceAccount,
                    onChanged: (account) =>
                        setState(() => selectedAdvanceAccount = account),
                    label: 'Payment Option',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Bottom: total + submit button
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
                  valueListenable: selectedProductsNotifier,
                  builder: (context, products, _) {
                    final total = products.fold<int>(
                      0,
                      (sum, product) =>
                          sum +
                          (product.amount *
                              product.quantity *
                              _getDaysMultiplierForProduct(product)),
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
                    onPressed: _handleConfirmOldBooking,
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
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
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

  void _handleConfirmOldBooking() async {
    final products = selectedProductsNotifier.value;

    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    if (clientNameController.text.trim().isEmpty) {
      setState(() => _clientNameError = 'Please enter client name');
      context.showSnackBar('Please enter client name', isError: true);
      return;
    }

    if (selectedAdvanceAccount == null) {
      context.showSnackBar('Please select a payment option', isError: true);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final repository = getIt<IBookingRepository>();
      final request = _buildOldBookingRequest();
      await repository.createOldBooking(request);

      if (mounted) Navigator.of(context).pop();
      if (mounted) {
        context.showSnackBar('Old booking saved successfully!');
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (mounted) Navigator.of(context).pop();
      if (mounted) {
        context.showSnackBar(
          'Failed to save old booking: ${e.toString()}',
          isError: true,
        );
      }
      log('Error creating old booking: $e');
    }
  }

  BookingRequestEntity _buildOldBookingRequest() {
    return BookingRequestBuilder.buildOldBookingRequest(
      products: selectedProductsNotifier.value,
      bookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
      selectedClientId: selectedClientId,
      clientName: clientNameController.text.trim(),
      phone1Raw: clientPhone1Controller.text.trim(),
      phone2Raw: clientPhone2Controller.text.trim(),
      address: clientAddressController.text.trim(),
      bookedDate: _bookedDate,
      pickupDate: pickupDate,
      returnDate: returnDate,
      description: _buildDescriptionWithPaymentSummary(),
      advanceAccountId: selectedAdvanceAccount?.id,
    );
  }
}
