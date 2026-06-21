part of '../pages/new_booking_screen.dart';

// ignore_for_file: use_build_context_synchronously

extension BookingFlowBuilders on NewBookingScreenState {
  Widget _buildBookingContent() {
    return BookingTwoPanelLayout(
      left: BookingLeftPanel(
        dateSection: _buildDateSelectionSection(),
        serviceSection: _buildServiceSelectionSection(),
        showCustomization: showCustomization,
        customizationProducts: selectedProductsNotifier.value
            .where(
              (p) =>
                  (p.variant.mainServiceType?.isDress ?? false) ||
                  (p.variant.mainServiceType?.isCostume ?? false),
            )
            .toList(),
        onBackFromCustomization: () => rebuild(() => showCustomization = false),
        onSaveCustomization: (product, measurements) {
          rebuild(() {
            selectedProductsNotifier.value =
                SelectedProductsManager.updateMeasurements(
                  currentProducts: selectedProductsNotifier.value,
                  updatedProduct: product,
                  measurements: measurements,
                );
          });
        },
      ),
      right: _buildRightSidePanel(),
    );
  }

  Widget _buildRightSidePanel() {
    // For sales mode, show a single simplified panel
    if (selectedBookingType == BookingType.sales) {
      return _buildSalesSinglePanel();
    }

    // For bookings, keep the two-step process
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          ),
        );
      },
      child: _bookingStep == 0
          ? _buildClientDetailsPanel()
          : _buildPaymentSummaryPanel(),
    );
  }

  Widget _buildClientDetailsPanel() {
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
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),

                  // Name - Only show for bookings
                  if (selectedBookingType != BookingType.sales) ...[
                    // ClientName with Search
                    BlocListener<ClientCubit, ClientState>(
                      listener: (context, state) {
                        if (state.selectedClient != null) {
                          final client = state.selectedClient!;
                          // Auto-fill fields
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
                          // Store selected client ID
                          selectedClientId = client.id;
                        }
                      },
                      child: ClientSearchNameField(
                        nameController: clientNameController,
                        focusNode: _clientNameFocusNode,
                        hitText: 'Type or Search name',
                        onSubmitName: _onClientNameSubmitted,
                        onClientSelected: (_) => _onClientPickedFromList(),
                        onClear: () {
                          // Clear all client fields when search is cleared
                          clientNameController.clear();
                          BookingPhonePopulator.setPhoneFieldValue(
                            _clientPhone1FieldController,
                            clientPhone1Controller,
                            phoneNumber: null,
                            e164: null,
                          );
                          BookingPhonePopulator.setPhoneFieldValue(
                            _clientPhone2FieldController,
                            clientPhone2Controller,
                            phoneNumber: null,
                            e164: null,
                          );
                          clientAddressController.clear();
                          selectedClientId = null;
                        },
                        errorText: _clientNameError,
                      ),
                    ),
                    const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  ], // End of name section for bookings only
                  // Phone 1 (WhatsApp) - Always enabled
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Whatsapp number',
                    textInputAction: TextInputAction.next,
                    focusNode: _clientPhone1FocusNode,
                    nextFocusNode: selectedBookingType != BookingType.sales
                        ? _clientPhone2FocusNode
                        : _clientAddressFocusNode,
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
                  // Phone 2 - Optional, only show for bookings, always enabled
                  if (selectedBookingType != BookingType.sales)
                    CustomPhoneNumberField(
                      controller: _clientPhone2FieldController,
                      hintText: 'Phone 2',
                      isRequired: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _clientPhone2FocusNode,
                      nextFocusNode: _clientAddressFocusNode,
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
                  // Place - Optional
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: _staffNameFocusNode,
                    prefixIcon: Icons.location_on,
                  ),

                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
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
                            value: sendPdfToWhatsApp,
                            onChanged: (v) =>
                                rebuild(() => sendPdfToWhatsApp = v ?? false),
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

                  // Upload documents - Optional (images / PDFs / docs)
                  if (selectedBookingType == BookingType.booking) ...[
                    BookingDocumentUploadSection(
                      documentsNotifier: documentsNotifier,
                    ),
                    const SizedBox(height: 7),
                  ],

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
                    nameController: staffNameController,
                    errorText: _staffNameError,
                    focusNode: _staffNameFocusNode,
                    nextFocusNode: _notesFocusNode,
                  ),

                  const SizedBox(height: 7),

                  // Notes - Optional
                  BookingNotesField(
                    controller: descriptionController,
                    focusNode: _notesFocusNode,
                    onSubmitted: () => _continueButtonFocusNode.requestFocus(),
                  ),

                  const SizedBox(height: 7),

                  // Running Kilometers - Only for Vehicles
                  ValueListenableBuilder<List<ProductSelectedEntity>>(
                    valueListenable: selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return BookingTextFieldBuilder.buildRightPanelTextField(
                        controller: runningKilometersController,
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
              selectedProductsNotifier,
              additionalChargesNotifier,
              advanceAmountController,
              discountAmountController,
            ]),
            builder: (context, _) {
              final products = selectedProductsNotifier.value;
              if (products.isEmpty) return const SizedBox.shrink();

              final additionalCharges = additionalChargesNotifier.value;
              final isSaleType = selectedBookingType == BookingType.sales;
              final advanceAmount = isSaleType
                  ? 0
                  : (advanceAmountController.text.trim().toIntOrNull() ?? 0);
              final discountInput =
                  discountAmountController.text.trim().toIntOrNull() ?? 0;
              final rentalDays = !isSaleType ? _getEffectiveRentalDays() : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                final daysMultiplier =
                    (!isSaleType &&
                        _shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (rentalDays > 0 ? rentalDays : 1)
                    : 1;
                return sum +
                    (product.amount * product.quantity * daysMultiplier);
              });
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );
              final actualDiscount = isDiscountPercentage
                  ? ((productTotal + additionalTotal) * discountInput / 100)
                        .round()
                  : discountInput;
              final totalPayable =
                  productTotal + additionalTotal - actualDiscount;
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
                      color: const Color(0xFF6132E4).withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Collapsed view - always visible
                      InkWell(
                        onTap: () {
                          rebuild(() {
                            _isSummaryExpanded = !_isSummaryExpanded;
                          });
                        },
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
                                    !isSaleType && rentalDays > 1
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
                              _buildSummaryRow('Product total', productTotal),
                              if (additionalTotal > 0)
                                _buildSummaryRow(
                                  'Additional charges',
                                  additionalTotal,
                                ),
                              if (actualDiscount > 0)
                                _buildSummaryRow(
                                  '- Discount',
                                  actualDiscount,
                                  isNegative: true,
                                ),
                              const Divider(height: 12, thickness: 1),
                              if (!isSaleType && advanceAmount > 0)
                                _buildSummaryRow(
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
              child: Focus(
                focusNode: _continueButtonFocusNode,
                onKeyEvent: (_, event) {
                  if (event is KeyDownEvent &&
                      (event.logicalKey == LogicalKeyboardKey.enter ||
                          event.logicalKey == LogicalKeyboardKey.numpadEnter ||
                          event.logicalKey == LogicalKeyboardKey.space)) {
                    _validateAndContinue();
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: ListenableBuilder(
                  listenable: _continueButtonFocusNode,
                  builder: (context, _) {
                    final isFocused = _continueButtonFocusNode.hasFocus;
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isFocused
                              ? const Color(0xFF6132E4)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _validateAndContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6132E4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
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
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryPanel() {
    return Container(
      key: const ValueKey(1),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  InkWell(
                    onTap: () {
                      // Close search overlay before changing steps
                      _removeSearchOverlay();
                      rebuild(() => _bookingStep = 0);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Locations - Only for Vehicles
                  ValueListenableBuilder<List<ProductSelectedEntity>>(
                    valueListenable: selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingTextFieldBuilder.buildSectionHeader(
                            'Locations',
                            optional: true,
                          ),
                          const SizedBox(height: NewBookingScreenState._fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: startLocationController,
                            hint: 'Start location',
                          ),
                          const SizedBox(height: NewBookingScreenState._fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: pickupLocationController,
                            hint: 'Pickup location',
                          ),
                          const SizedBox(height: NewBookingScreenState._fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: destinationLocationController,
                            hint: 'Destination',
                          ),
                          const SizedBox(height: 14),
                        ],
                      );
                    },
                  ),

                  // Payment details
                  BookingTextFieldBuilder.buildSectionHeader(
                    'Payment details',
                    optional: true,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: advanceAmountController,
                    hint: 'Advance amount',
                    isNumber: true,
                    focusNode: _advanceAmountFocusNode,
                    nextFocusNode: _securityAmountFocusNode,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  // Payment Method Selection - only show if advance amount has value
                  ValueListenableBuilder(
                    valueListenable: advanceAmountController,
                    builder: (context, value, child) {
                      final hasAdvanceAmount =
                          value.text.trim().isNotEmpty &&
                          (int.tryParse(value.text.trim()) ?? 0) > 0;
                      if (hasAdvanceAmount) {
                        return Column(
                          children: [
                            _buildPaymentMethodSection(
                              label: 'Advance Payment Option',
                            ),
                            const SizedBox(height: 14),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: securityAmountController,
                    hint: 'Security amount',
                    isNumber: true,
                    focusNode: _securityAmountFocusNode,
                    nextFocusNode: _discountAmountFocusNode,
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  // Security Payment Method - show when security amount has value
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: securityAmountController,
                    builder: (context, value, child) {
                      final hasSecurityAmount =
                          value.text.trim().isNotEmpty &&
                          (int.tryParse(value.text.trim()) ?? 0) > 0;
                      if (hasSecurityAmount) {
                        return AccountSelectionField(
                          selectedAccount: selectedSecurityAccount,
                          onChanged: (account) => rebuild(() => selectedSecurityAccount = account),
                          label: 'Security Payment Option',
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: NewBookingScreenState._fieldSpacing),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child:
                                BookingTextFieldBuilder.buildRightPanelTextField(
                                  controller: discountAmountController,
                                  hint: isDiscountPercentage
                                      ? 'Discount %'
                                      : 'Discount amount',
                                  isNumber: true,
                                  focusNode: _discountAmountFocusNode,
                                  nextFocusNode: _confirmStepButtonFocusNode,
                                  suffix:
                                      ValueListenableBuilder<TextEditingValue>(
                                        valueListenable:
                                            discountAmountController,
                                        builder: (context, val, _) {
                                          final input =
                                              val.text.trim().toIntOrNull() ??
                                              0;
                                          final total =
                                              _getDiscountProductBase();
                                          if (input <= 0 || total <= 0) {
                                            return const SizedBox.shrink();
                                          }
                                          final String equiv;
                                          if (isDiscountPercentage) {
                                            final amount = (total * input / 100)
                                                .round();
                                            equiv = '≈ ₹$amount';
                                          } else {
                                            final pct = input / total * 100;
                                            final pctStr = pct % 1 == 0
                                                ? '${pct.round()}'
                                                : pct.toStringAsFixed(1);
                                            equiv = '≈ $pctStr%';
                                          }
                                          return Text(
                                            equiv,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade500,
                                            ),
                                          );
                                        },
                                      ),
                                ),
                          ),
                          const SizedBox(width: 8),
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.grey.shade600,
                            ),
                            onSelected: (value) {
                              rebuild(() {
                                final switchToPercent = value == 'percentage';
                                if (switchToPercent != isDiscountPercentage) {
                                  final input =
                                      discountAmountController.text
                                          .trim()
                                          .toIntOrNull() ??
                                      0;
                                  final total = PaymentCalculator.getDiscountProductBase(
                                    selectedProducts: selectedProductsNotifier.value,
                                    additionalCharges: additionalChargesNotifier.value,
                                    bookingType: selectedBookingType,
                                    effectiveRentalDays: _getEffectiveRentalDays(),
                                  );
                                  if (input > 0 && total > 0) {
                                    if (switchToPercent) {
                                      // amount → percentage
                                      final pct = (input / total * 100)
                                          .round()
                                          .clamp(0, 100);
                                      discountAmountController.text = pct
                                          .toString();
                                    } else {
                                      // percentage → amount
                                      final amount = (total * input / 100)
                                          .round();
                                      discountAmountController.text = amount
                                          .toString();
                                    }
                                  }
                                  isDiscountPercentage = switchToPercent;
                                  _discountTypeNotifier.value = switchToPercent;
                                }
                              });
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'amount',
                                child: Row(
                                  children: [
                                    Icon(
                                      isDiscountPercentage
                                          ? Icons.circle_outlined
                                          : Icons.check_circle,
                                      size: 18,
                                      color: isDiscountPercentage
                                          ? Colors.grey
                                          : const Color(0xFF6132E4),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Amount (₹)'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'percentage',
                                child: Row(
                                  children: [
                                    Icon(
                                      isDiscountPercentage
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 18,
                                      color: isDiscountPercentage
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Percentage (%)'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),
                  // // Payment Method Selection - only show if advance amount has value
                  // ValueListenableBuilder(
                  //   valueListenable: advanceAmountController,
                  //   builder: (context, value, child) {
                  //     final hasAdvanceAmount =
                  //         value.text.trim().isNotEmpty &&
                  //         (int.tryParse(value.text.trim()) ?? 0) > 0;
                  //     if (hasAdvanceAmount) {
                  //       return Column(
                  //         children: [
                  //           _buildPaymentMethodSection(
                  //             label: 'Advance Payment Option',
                  //           ),
                  //           const SizedBox(height: 14),
                  //         ],
                  //       );
                  //     }
                  //     return const SizedBox.shrink();
                  //   },
                  // ),

                  // Additional Charges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Additional charges',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      InkWell(
                        onTap: _addAdditionalCharge,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6132E4).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: Color(0xFF6132E4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Additional charges list
                  ValueListenableBuilder<List<AdditionalChargesEntity>>(
                    valueListenable: additionalChargesNotifier,
                    builder: (context, charges, _) {
                      if (charges.isEmpty) return const SizedBox();
                      return Column(
                        children: charges.map((charge) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFF6132E4).withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    charge.name ?? 'Charge',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D2D2D),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF6132E4,
                                        ).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        '₹${charge.amount ?? 0}',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF6132E4),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () => _removeCharge(charge),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade50,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          size: 14,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Fixed Bottom Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.transparent,
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
