import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_calendar_widget.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_payment_details_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_product_selection_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Booking types enum for the tab selection
enum BookingType { booking, sales, customWork }

class NewBookingScreen extends StatefulWidget {
  const NewBookingScreen({super.key});

  @override
  State<NewBookingScreen> createState() => _NewBookingScreenState();
}

class _NewBookingScreenState extends State<NewBookingScreen> {
  // Current selected tab
  BookingType selectedBookingType = BookingType.booking;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Date controllers
  late DateTime pickupDate;
  late DateTime returnDate;
  DateTime? coolingPeriodDate;
  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;
  TimeOfDay? coolingPeriodTime;

  // Client details controllers
  final clientNameController = TextEditingController();
  final clientPhone1Controller = TextEditingController();
  final clientPhone2Controller = TextEditingController();
  final clientAddressController = TextEditingController();
  final staffNameController = TextEditingController();
  int? selectedStaffId;
  int? selectedClientId;
  bool isSearchClientEnabled = false;

  // Payment controllers
  final advanceAmountController = TextEditingController();
  final securityAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  PaymentMethod paymentMethod = PaymentMethod.gPay;
  DeliveryStatus deliveryStatus = DeliveryStatus.booked;

  // Products
  final selectedProductsNotifier =
      ValueNotifier<List<ProductSelectedModel>>([]);

  // Additional charges
  final additionalChargesNotifier =
      ValueNotifier<List<AdditionalChargesModel>>([]);

  // Documents
  final documentsNotifier = ValueNotifier<List<DocumentFile>>([]);

  // Description
  final descriptionController = TextEditingController();

  late final int coolingPeriodDuration;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));
    coolingPeriodDuration =
        context.read<UserCubit>().state?.shopSettings.coolingPeriodDuration ??
            0;
  }

  @override
  void dispose() {
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();
    staffNameController.dispose();
    advanceAmountController.dispose();
    securityAmountController.dispose();
    discountAmountController.dispose();
    descriptionController.dispose();
    selectedProductsNotifier.dispose();
    additionalChargesNotifier.dispose();
    documentsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: _buildMainContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button and title
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(4),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'New Order',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                _getTabTitle(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          // Tab buttons
          _buildTabButtons(),
          const Spacer(),
        ],
      ),
    );
  }

  String _getTabTitle() {
    switch (selectedBookingType) {
      case BookingType.booking:
        return 'New booking';
      case BookingType.sales:
        return 'New sales';
      case BookingType.customWork:
        return 'Custom work';
    }
  }

  Widget _buildTabButtons() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabButton('Booking', BookingType.booking),
          _buildTabButton('Sales', BookingType.sales),
          _buildTabButton('Custom work', BookingType.customWork),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, BookingType type) {
    final isSelected = selectedBookingType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBookingType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    // Sales tab has simplified layout
    if (selectedBookingType == BookingType.sales) {
      return _buildSalesContent();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left section - Date selection & Staff/Client details & Products
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildLeftTopSection(),
              const SizedBox(height: 20),
              _buildProductSelectionSection(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Right section - Payment details & Summary
        Expanded(
          flex: 1,
          child: _buildRightSection(),
        ),
      ],
    );
  }

  Widget _buildSalesContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left section - Date & Staff/Client & Products
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildSalesLeftTopSection(),
              const SizedBox(height: 20),
              _buildProductSelectionSection(),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Right section - Payment & Summary
        Expanded(
          flex: 1,
          child: _buildRightSection(),
        ),
      ],
    );
  }

  Widget _buildSalesLeftTopSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Single date selection for Sales
        Expanded(
          child: _buildSalesDateSection(),
        ),
        const SizedBox(width: 20),
        // Staff and simplified client details
        Expanded(
          child: _buildSalesClientSection(),
        ),
      ],
    );
  }

  Widget _buildSalesDateSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sale Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Sale date picker
          InkWell(
            onTap: () => _selectSaleDate(),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 18,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      pickupDate.format(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Description field
          const Text(
            'Description (optional)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Enter description...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectSaleDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: pickupDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.purple,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => pickupDate = picked);
    }
  }

  Widget _buildSalesClientSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Staff & Client',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Staff name field
          const Text(
            'Staff name',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: staffNameController,
              decoration: InputDecoration(
                hintText: 'Enter staff name',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Client phone number field
          const Text(
            'Client phone number',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: clientPhone1Controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Place field
          const Text(
            'Place',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: clientAddressController,
              decoration: InputDecoration(
                hintText: 'Enter place',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftTopSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Calendar section
        Expanded(
          child: BookingCalendarWidget(
            pickupDate: pickupDate,
            returnDate: returnDate,
            coolingPeriodDate: coolingPeriodDate,
            pickupTime: pickupTime,
            returnTime: returnTime,
            coolingPeriodTime: coolingPeriodTime,
            onPickupDateChanged: (date) => setState(() => pickupDate = date),
            onReturnDateChanged: (date) => setState(() => returnDate = date),
            onCoolingPeriodDateChanged: (date) =>
                setState(() => coolingPeriodDate = date),
            onPickupTimeChanged: (time) => setState(() => pickupTime = time),
            onReturnTimeChanged: (time) => setState(() => returnTime = time),
            onCoolingPeriodTimeChanged: (time) =>
                setState(() => coolingPeriodTime = time),
          ),
        ),
        const SizedBox(width: 20),
        // Staff and Client details
        Expanded(
          child: BookingClientDetailsSection(
            staffNameController: staffNameController,
            clientNameController: clientNameController,
            clientPhone1Controller: clientPhone1Controller,
            clientPhone2Controller: clientPhone2Controller,
            clientAddressController: clientAddressController,
            isSearchClientEnabled: isSearchClientEnabled,
            onSearchClientToggle: (value) {
              setState(() => isSearchClientEnabled = value);
            },
            onStaffSelected: (staffId) {
              setState(() => selectedStaffId = staffId);
            },
            onClientSelected: (clientId) {
              setState(() => selectedClientId = clientId);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductSelectionSection() {
    return BookingProductSelectionSection(
      selectedProductsNotifier: selectedProductsNotifier,
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      pickupTime: pickupTime,
      returnTime: returnTime,
      isSales: selectedBookingType == BookingType.sales,
    );
  }

  Widget _buildRightSection() {
    final isSalesMode = selectedBookingType == BookingType.sales;
    return Column(
      children: [
        // Payment details
        BookingPaymentDetailsSection(
          advanceAmountController: advanceAmountController,
          securityAmountController: securityAmountController,
          discountAmountController: discountAmountController,
          additionalChargesNotifier: additionalChargesNotifier,
          deliveryStatus: deliveryStatus,
          onDeliveryStatusChanged: (status) {
            setState(() => deliveryStatus = status);
          },
          paymentMethod: paymentMethod,
          onPaymentMethodChanged: (method) {
            setState(() => paymentMethod = method);
          },
          isSalesMode: isSalesMode,
        ),
        const SizedBox(height: 20),
        // Document upload (hide for sales)
        if (!isSalesMode) ...[
          BookingDocumentUploadSection(
            documentsNotifier: documentsNotifier,
          ),
          const SizedBox(height: 20),
        ],
        // Summary
        BookingSummarySection(
          selectedProductsNotifier: selectedProductsNotifier,
          additionalChargesNotifier: additionalChargesNotifier,
          advanceAmountController: advanceAmountController,
          discountAmountController: discountAmountController,
          onConfirmBooking: _handleConfirmBooking,
        ),
      ],
    );
  }

  void _handleConfirmBooking() {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one product', isError: true);
      return;
    }

    // Build the request model
    final request = _buildBookingRequest();
    log('Booking Request: ${request.toJson()}');

    // TODO: Call the API to create booking
    // context.read<AddBookingBloc>().add(AddBookingEvent.addNewBooking(booking: request));
  }

  RequestBookingModel _buildBookingRequest() {
    final products = selectedProductsNotifier.value;
    final additionalCharges = additionalChargesNotifier.value;

    return RequestBookingModel(
      clientId: selectedClientId,
      staffId: selectedStaffId,
      client: selectedClientId == null
          ? null
          : null, // Will be populated if new client
      address: clientAddressController.text.trim(),
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      coolingPeriodDate: coolingPeriodDate?.format(),
      advanceAmount: advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: securityAmountController.text.trim().toIntOrNull(),
      discountAmount: discountAmountController.text.trim().toIntOrNull(),
      paymentMethod: paymentMethod,
      deliveryStatus: deliveryStatus,
      products: products,
      additionalCharges:
          additionalCharges.isNotEmpty ? additionalCharges : null,
      description: descriptionController.text.trim().isNotEmpty
          ? descriptionController.text.trim()
          : null,
      pickupTime: pickupTime,
      returnTime: returnTime,
    );
  }
}

/// Model for uploaded document files
class DocumentFile {
  final String name;
  final String path;
  final List<int>? bytes;

  DocumentFile({
    required this.name,
    required this.path,
    this.bytes,
  });
}
