import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart'
    show ServicesModel;
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_calendar_widget.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Booking types enum for the tab selection
enum BookingType { booking, sales }

/// New Booking Screen - ERP Desktop Layout
/// Features:
/// - Fixed sidebar always visible (rendered by parent)
/// - No full page scrolling
/// - Compact UI
/// - Service-based selection
/// - Time fields for pickup/return
class NewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const NewBookingScreen({super.key, this.onClose});

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

  // Products/Services
  final selectedProductsNotifier =
      ValueNotifier<List<ProductSelectedModel>>([]);

  // Additional charges
  final additionalChargesNotifier =
      ValueNotifier<List<AdditionalChargesModel>>([]);

  // Documents
  final documentsNotifier = ValueNotifier<List<DocumentFile>>([]);

  // Description
  final descriptionController = TextEditingController();

  // Service selection
  int? selectedServiceId;
  final serviceSearchController = TextEditingController();

  // SelectProductBloc for inline search
  late SelectProductBloc _selectProductBloc;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
    });
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
    serviceSearchController.dispose();
    _selectProductBloc.close();
    super.dispose();
  }

  void _onSearchChanged() {
    if (selectedServiceId == null) return;

    final query = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;

    if (query.isEmpty) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: selectedServiceId!,
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    } else {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId!,
          query: query,
          type: 'name',
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    }
  }

  void _loadProductsForService(int serviceId) {
    final isSales = selectedBookingType == BookingType.sales;
    _selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceId,
        pickupDate: pickupDate.format(),
        returnDate: returnDate.format(),
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: const Color(0xFFF5F6FA),
      height: screenHeight,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Header with tabs
            _buildCompactHeader(),
            // Main content - no scrolling
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: _buildMainContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: () {
              if (widget.onClose != null) {
                widget.onClose!();
              } else {
                Navigator.of(context).pop();
              }
            },
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          Text(
            _getTabTitle(),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 16),
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
        return 'New Booking';
      case BookingType.sales:
        return 'New Sale';
    }
  }

  Widget _buildTabButtons() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTabButton('Booking', BookingType.booking),
          _buildTabButton('Sales', BookingType.sales),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, BookingType type) {
    final isSelected = selectedBookingType == type;
    return GestureDetector(
      onTap: () => setState(() => selectedBookingType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6132E4) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    if (selectedBookingType == BookingType.sales) {
      return _buildSalesContent();
    }
    return _buildBookingContent();
  }

  Widget _buildBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left section - Date/Time & Client details
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // Top row: Date/Time and Client details
              SizedBox(
                // height: 210, // controls top row height
                child: Row(
                  children: [
                    // Expanded(child: _buildCompactDateTimeSection()),
                    // const SizedBox(width: 12),
                    Expanded(child: _buildLeftTopSection()),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              // Service selection section - scrollable
              Expanded(child: _buildServiceSelectionSection()),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right section - Payment & Summary
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
        // Left section
        Expanded(
          flex: 3,
          child: Column(
            children: [
              SizedBox(
                // height: 160,
                child: Row(
                  children: [
                    // Expanded(child: _buildSalesDateSection()),
                    // const SizedBox(width: 12),
                    Expanded(child: _buildLeftTopSection()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildServiceSelectionSection()),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Right section
        Expanded(
          flex: 1,
          child: _buildRightSection(),
        ),
      ],
    );
  }

  // Widget _buildCompactDateTimeSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(color: Colors.grey.shade200),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text(
  //           'Booking Period',
  //           style: TextStyle(
  //             fontSize: 13,
  //             fontWeight: FontWeight.w600,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         const SizedBox(height: 10),
  //         // Pickup Date & Time
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 2,
  //               child: _buildCompactDateField(
  //                 label: 'Pickup Date',
  //                 value: pickupDate.format(),
  //                 onTap: () => _selectDate(isPickup: true),
  //               ),
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: _buildCompactTimeField(
  //                 label: 'Time',
  //                 value: pickupTime?.format(context) ?? '--:--',
  //                 onTap: () => _selectTime(isPickup: true),
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         // Return Date & Time
  //         Row(
  //           children: [
  //             Expanded(
  //               flex: 2,
  //               child: _buildCompactDateField(
  //                 label: 'Return Date',
  //                 value: returnDate.format(),
  //                 onTap: () => _selectDate(isPickup: false),
  //               ),
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: _buildCompactTimeField(
  //                 label: 'Time',
  //                 value: returnTime?.format(context) ?? '--:--',
  //                 onTap: () => _selectTime(isPickup: false),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildCompactDateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 14, color: AppColors.purple),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 16, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompactTimeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(Icons.access_time, size: 14, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate({required bool isPickup}) async {
    final initialDate = isPickup ? pickupDate : returnDate;
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          pickupDate = picked;
          if (returnDate.isBefore(picked)) {
            returnDate = picked.add(const Duration(days: 1));
          }
        } else {
          returnDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime({required bool isPickup}) async {
    final initialTime = isPickup
        ? (pickupTime ?? TimeOfDay.now())
        : (returnTime ?? TimeOfDay.now());
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          pickupTime = picked;
        } else {
          returnTime = picked;
        }
      });
    }
  }

  Widget _buildSalesDateSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sale Date',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          _buildCompactDateField(
            label: 'Date',
            value: pickupDate.format(),
            onTap: () => _selectDate(isPickup: true),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            'Notes',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                expands: true,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'Enter notes...',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 12),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftTopSection() {
    return SizedBox(
      // height: 510,
      child: Column(
        children: [
          // Calendar + date time (already compact)
          SizedBox(
            height: 496,
            child: BookingCalendarWidget(
              staffNameController: staffNameController,
              clientNameController: clientNameController,
              clientPhone1Controller: clientPhone1Controller,
              clientPhone2Controller: clientPhone2Controller,
              clientAddressController: clientAddressController,
              isSearchClientEnabled: isSearchClientEnabled,
              onSearchClientToggle: (v) =>
                  setState(() => isSearchClientEnabled = v),
              onStaffSelected: (id) => setState(() => selectedStaffId = id),
              onClientSelected: (id) => setState(() => selectedClientId = id),
              pickupDate: pickupDate,
              returnDate: returnDate,
              coolingPeriodDate: coolingPeriodDate,
              pickupTime: pickupTime,
              returnTime: returnTime,
              coolingPeriodTime: null,
              onPickupDateChanged: (d) => setState(() => pickupDate = d),
              onReturnDateChanged: (d) => setState(() => returnDate = d),
              onCoolingPeriodDateChanged: (d) =>
                  setState(() => coolingPeriodDate = d),
              onPickupTimeChanged: (t) => setState(() => pickupTime = t),
              onReturnTimeChanged: (t) => setState(() => returnTime = t),
              onCoolingPeriodTimeChanged: (_) {},
            ),
          ),

          // const SizedBox(height: 10),

          // Client + Staff compact block
          // Expanded(
          // child: BookingClientDetailsCompact(
          // staffNameController: staffNameController,
          // clientNameController: clientNameController,
          // clientPhone1Controller: clientPhone1Controller,
          // clientPhone2Controller: clientPhone2Controller,
          // clientAddressController: clientAddressController,
          // isSearchClientEnabled: isSearchClientEnabled,
          // onSearchClientToggle: (v) => setState(() => isSearchClientEnabled = v),
          // onStaffSelected: (id) => setState(() => selectedStaffId = id),
          // onClientSelected: (id) => setState(() => selectedClientId = id),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildServiceSelectionSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _buildProductSearchBar(),
          const SizedBox(height: 6),
          Expanded(child: _buildSelectedProductsTable()),
        ],
      ),
    );
  }

  Widget _buildSelectedProductsTable() {
    return Column(
      children: [
        _buildProductListHeader(),
        Expanded(child: _buildSelectedProductsList()),
      ],
    );
  }

  Widget _buildProductSearchBar() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocBuilder<SelectProductBloc, SelectProductState>(
          bloc: _selectProductBloc,
          builder: (context, state) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    // Service Category Dropdown
                    serviceState.maybeWhen(
                      loaded: (services) {
                        return Container(
                          height: 34,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: selectedServiceId,
                              hint: const Text(
                                'Select Service',
                                style: TextStyle(fontSize: 12),
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                size: 18,
                                color: Colors.grey.shade600,
                              ),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                              items: services.map((service) {
                                return DropdownMenuItem<int>(
                                  value: service.id,
                                  child: Text(
                                    service.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }).toList(),
                              onChanged: (id) {
                                if (id != null) {
                                  setState(() => selectedServiceId = id);
                                  _loadProductsForService(id);
                                  serviceSearchController.clear();
                                }
                              },
                            ),
                          ),
                        );
                      },
                      orElse: () => const SizedBox(
                        width: 100,
                        height: 34,
                        child: Center(
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Search TextField
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: CustomTextField(
                          validator: (value) => null,
                          controller: serviceSearchController,
                          hintText: 'Search product name',
                          prefixIcon: const Icon(Icons.search, size: 16),
                          onChanged: (value) {
                            // Trigger search on text change
                            _onSearchChanged();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                state.maybeWhen(
                  loaded: (products, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10,
                      p11, p12, p13, p14) {
                    if (products.isEmpty ||
                        serviceSearchController.text.isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Positioned(
                      top: 36,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 6)
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (_, i) {
                            final p = products[i];
                            return ListTile(
                              dense: true,
                              title: Text(p.name,
                                  style: const TextStyle(fontSize: 11)),
                              subtitle: Text("${p.variants.length} variants",
                                  style: const TextStyle(fontSize: 10)),
                              onTap: () {
                                serviceSearchController.clear();
                                _showVariantSelectionDialog(p);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildProductTableHeader() {
    return Container(
      height: 32,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          Expanded(
              flex: 4, child: Text("Item", style: TextStyle(fontSize: 11))),
          Expanded(child: Text("Variants", style: TextStyle(fontSize: 11))),
          Expanded(child: Text("Price", style: TextStyle(fontSize: 11))),
          SizedBox(width: 60),
        ],
      ),
    );
  }

  Widget _buildProductTableRow(dynamic product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(product.image,
                      width: 32, height: 32, fit: BoxFit.cover),
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(product.name,
                        style: const TextStyle(fontSize: 12))),
              ],
            ),
          ),
          Expanded(
              child: Text("${product.variants.length}",
                  style: const TextStyle(fontSize: 12))),
          Expanded(
              child: Text(product.rentPrice.toCurrency(),
                  style: const TextStyle(fontSize: 12))),
          SizedBox(
            width: 60,
            child: ElevatedButton(
              onPressed: () => _showVariantSelectionDialog(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6132E4),
                minimumSize: const Size(50, 26),
                padding: EdgeInsets.zero,
              ),
              child: const Text("Add", style: TextStyle(fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductListTable() {
    return BlocBuilder<SelectProductBloc, SelectProductState>(
      bloc: _selectProductBloc,
      builder: (context, state) {
        return state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e) => Center(child: Text(e)),
          loaded: (
            products,
            _,
            __,
            ___,
            ____,
            _____,
            isSearching,
            p1,
            p2,
            p3,
            p4,
            p5,
            p6,
            p7,
            p8,
          ) {
            if (products.isEmpty) {
              return const Center(child: Text("No products"));
            }

            return Column(
              children: [
                _buildProductTableHeader(),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, i) => _buildProductTableRow(products[i]),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showVariantSelectionDialog(dynamic product) {
    final variants = product.variants ?? [];

    if (variants.isEmpty) {
      context.showSnackBar('No variants available', isError: true);
      return;
    }

    final selectedVariants = selectedProductsNotifier.value;

    showSizeAmountDialog(
      context: context,
      isSales: selectedBookingType == BookingType.sales,
      alreadySelectedVariants: selectedVariants,
      mainServiceType: product.mainServiceType,
      productImageUrl: product.image!,
      availableVariants: variants,
      initialAmount: null,
      initialQuantity: null,
      onConfirm: (id, size, amount, quantity) {
        final attribute = size == null || size.isEmpty
            ? (variants.first.attribute.isEmpty
                ? product.model
                : variants.first.attribute)
            : size;

        final products =
            List<ProductSelectedModel>.from(selectedProductsNotifier.value);

        final existingIndex =
            products.indexWhere((p) => p.variant.variantId == id);

        if (existingIndex != -1) {
          final existing = products[existingIndex];
          products[existingIndex] =
              existing.copyWith(quantity: existing.quantity + quantity);
        } else {
          products.add(ProductSelectedModel(
            variant: ProductInfoModel(
              id: id,
              variantId: id,
              productId: product.id,
              name: product.name,
              image: product.image,
              amount: amount.toInt(),
              category: product.category,
              color: product.color,
              model: product.model,
              mainServiceType: product.mainServiceType,
              variantAttribute: attribute,
              measurements: [],
              quantity: quantity,
            ),
            quantity: quantity,
            amount: amount.toInt(),
          ));
        }

        selectedProductsNotifier.value = products;
      },
    );
  }

  void _addProductVariant(dynamic product, dynamic variant) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);

    // Check if variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.variantId,
    );

    if (existingIndex != -1) {
      // Increment quantity
      final existing = products[existingIndex];
      products[existingIndex] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      // Add new product
      final isSales = selectedBookingType == BookingType.sales;
      final price =
          isSales ? (variant.sellPrice ?? 0) : (variant.rentPrice ?? 0);

      products.add(ProductSelectedModel(
        variant: variant,
        quantity: 1,
        amount: price,
      ));
    }

    selectedProductsNotifier.value = products;
    context.showSnackBar('Added ${variant.name ?? "item"} to selection');
  }

  Widget _buildServiceTabs() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        return state.when(
          loading: () => const SizedBox(
            height: 26,
            child: Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          error: (error) => Text(
            'Error loading services',
            style: TextStyle(color: Colors.red.shade400, fontSize: 11),
          ),
          loaded: (services) {
            // Auto-select first service and load products
            if (selectedServiceId == null && services.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() => selectedServiceId = services.first.id);
                _loadProductsForService(services.first.id);
              });
            }
            return SizedBox(
              height: 26,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: services.length,
                separatorBuilder: (_, __) => const SizedBox(width: 6),
                itemBuilder: (context, index) {
                  final service = services[index];
                  final isSelected = selectedServiceId == service.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedServiceId = service.id);
                      _loadProductsForService(service.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF6132E4).withOpacity(0.1)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6132E4)
                              : Colors.grey.shade300,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Text(
                        service.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF6132E4)
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProductListHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Item',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Qty',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Price',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(List<ServicesModel> services) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedServiceId,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 12, color: Colors.black),
          items: services
              .map((s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.name, style: const TextStyle(fontSize: 12)),
                  ))
              .toList(),
          onChanged: (id) {
            if (id == null) return;
            setState(() => selectedServiceId = id);
            _loadProductsForService(id); // <<< CRITICAL
          },
        ),
      ),
    );
  }

  Widget _buildSelectedProductsList() {
    return ValueListenableBuilder<List<ProductSelectedModel>>(
      valueListenable: selectedProductsNotifier,
      builder: (context, products, _) {
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 32, color: Colors.grey.shade300),
                const SizedBox(height: 8),
                Text(
                  'No items selected',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Click on products to add',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: products.length,
          separatorBuilder: (_, __) =>
              Divider(height: 1, color: Colors.grey.shade200),
          itemBuilder: (context, index) => _buildProductRow(products[index]),
        );
      },
    );
  }

  Widget _buildProductRow(ProductSelectedModel product) {
    final total = product.amount * product.quantity;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          // Item name
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: product.variant.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            product.variant.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.image,
                              size: 16,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        )
                      : Icon(Icons.image,
                          size: 16, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    product.variant.name,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          // Quantity
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${product.quantity}',
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _incrementQuantity(product),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6132E4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Icon(Icons.add,
                        size: 12, color: Color(0xFF6132E4)),
                  ),
                ),
              ],
            ),
          ),
          // Price
          Expanded(
            child: Text(
              product.amount.toCurrency(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          // Total
          Expanded(
            child: Text(
              total.toCurrency(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          // Remove button
          SizedBox(
            width: 30,
            child: IconButton(
              onPressed: () => _removeProduct(product),
              icon: Icon(Icons.close, size: 14, color: Colors.grey.shade500),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightSection() {
    final isSalesMode = selectedBookingType == BookingType.sales;
    return Column(
      children: [
        // Payment section - compact
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Details',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Order: Advance, Security, Discount, Additional Charges, Payment Method, Delivery Status
                  _buildCompactAmountField(
                    controller: advanceAmountController,
                    label: 'Advance',
                  ),
                  const SizedBox(height: 8),
                  if (!isSalesMode) ...[
                    _buildCompactAmountField(
                      controller: securityAmountController,
                      label: 'Security',
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildCompactAmountField(
                    controller: discountAmountController,
                    label: 'Discount',
                  ),
                  const SizedBox(height: 10),
                  // Additional charges
                  _buildAdditionalChargesSection(),
                  const SizedBox(height: 10),
                  // Payment method
                  // _buildPaymentMethodSection(),
                  const SizedBox(height: 10),
                  // Delivery status
                  if (!isSalesMode) _buildDeliveryStatusSection(),
                  const SizedBox(height: 10),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 10),
                  if (!isSalesMode) ...[
                    BookingDocumentUploadSection(
                      documentsNotifier: documentsNotifier,
                    ),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Summary section
        _buildSummarySection(),
      ],
    );
  }

  Widget _buildCompactAmountField({
    required TextEditingController controller,
    required String label,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
          ),
        ),
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                prefixText: '₹ ',
                prefixStyle:
                    TextStyle(fontSize: 12, color: Colors.grey.shade600),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalChargesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Additional Charges',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
            ),
            InkWell(
              onTap: _addAdditionalCharge,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFF6132E4).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child:
                    const Icon(Icons.add, size: 14, color: Color(0xFF6132E4)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder<List<AdditionalChargesModel>>(
          valueListenable: additionalChargesNotifier,
          builder: (context, charges, _) {
            if (charges.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    'No additional charges',
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                  ),
                ),
              );
            }
            return Column(
              children: charges.map((charge) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        charge.name ?? 'Charge',
                        style: const TextStyle(fontSize: 11),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${charge.amount ?? 0}',
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () => _removeCharge(charge),
                            child: Icon(Icons.close,
                                size: 12, color: Colors.grey.shade500),
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
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: _buildPaymentMethodOption(
                label: 'UPI',
                value: PaymentMethod.gPay,
                icon: Icons.account_balance_wallet_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildPaymentMethodOption(
                label: 'Cash',
                value: PaymentMethod.cash,
                icon: Icons.money_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption({
    required String label,
    required PaymentMethod value,
    required IconData icon,
  }) {
    final isSelected = paymentMethod == value;
    return InkWell(
      onTap: () => setState(() => paymentMethod = value),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6132E4).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 14,
                color: isSelected
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color:
                    isSelected ? const Color(0xFF6132E4) : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Status',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DeliveryStatus>(
              value: deliveryStatus,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  size: 18, color: Colors.grey.shade600),
              style: const TextStyle(fontSize: 12, color: Colors.black87),
              items: DeliveryStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.name,
                            style: const TextStyle(fontSize: 12)),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => deliveryStatus = value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Summary rows
          ListenableBuilder(
            listenable: Listenable.merge([
              selectedProductsNotifier,
              additionalChargesNotifier,
              advanceAmountController,
              discountAmountController,
            ]),
            builder: (context, _) {
              final products = selectedProductsNotifier.value;
              final additionalCharges = additionalChargesNotifier.value;
              final advanceAmount =
                  advanceAmountController.text.trim().toIntOrNull() ?? 0;
              final discountAmount =
                  discountAmountController.text.trim().toIntOrNull() ?? 0;

              final productTotal = products.fold<int>(
                0,
                (sum, product) => sum + (product.amount * product.quantity),
              );
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );
              final totalPayable =
                  productTotal + additionalTotal - discountAmount;
              final remainingAmount = totalPayable - advanceAmount;

              return Column(
                children: [
                  _buildSummaryRow('Subtotal', productTotal),
                  if (additionalTotal > 0)
                    _buildSummaryRow('+ Additional', additionalTotal),
                  if (discountAmount > 0)
                    _buildSummaryRow('- Discount', discountAmount,
                        isNegative: true),
                  const Divider(height: 12),
                  _buildSummaryRow('Paid', advanceAmount,
                      valueColor: AppColors.green),
                  _buildSummaryRow(
                    'Balance',
                    remainingAmount > 0 ? remainingAmount : 0,
                    valueColor: const Color(0xFF6132E4),
                    isBold: true,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          // Confirm button - Color #6132E4
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: _handleConfirmBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6132E4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    int amount, {
    Color? valueColor,
    bool isBold = false,
    bool isNegative = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
              color: Colors.grey.shade700,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
            style: TextStyle(
              fontSize: isBold ? 14 : 12,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Actions
  void _openProductSelection() async {
    if (selectedServiceId == null) {
      context.showSnackBar('Please select a service first', isError: true);
      return;
    }

    final result = await Navigator.push<List<ProductSelectedModel>>(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => SelectProductBloc(
                repository: getIt<ProductRepository>(),
              ),
            ),
            BlocProvider(create: (_) => SelectedProductsCubit()),
          ],
          child: SelectProductScreen(
            serviceId: selectedServiceId!,
            pickupDate: pickupDate.format(),
            returnDate: returnDate.format(),
            pickupTime: pickupTime,
            returnTime: returnTime,
            preSelectedData: selectedProductsNotifier.value,
            isSales: selectedBookingType == BookingType.sales,
            useAvailableProductsApi: selectedBookingType != BookingType.sales,
          ),
        ),
      ),
    );

    if (result != null) {
      selectedProductsNotifier.value = result;
    }
  }

  void _incrementQuantity(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      final updatedProduct = product.copyWith(quantity: product.quantity + 1);
      products[index] = updatedProduct;
      selectedProductsNotifier.value = products;
    }
  }

  void _removeProduct(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    products
        .removeWhere((p) => p.variant.variantId == product.variant.variantId);
    selectedProductsNotifier.value = products;
  }

  void _addAdditionalCharge() async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final result = await showDialog<AdditionalChargesModel>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Charge', style: TextStyle(fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Delivery',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amount = int.tryParse(amountController.text);
              if (name.isNotEmpty && amount != null && amount > 0) {
                Navigator.pop(
                  context,
                  AdditionalChargesModel(name: name, amount: amount),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null) {
      final charges =
          List<AdditionalChargesModel>.from(additionalChargesNotifier.value);
      charges.add(result);
      additionalChargesNotifier.value = charges;
    }
  }

  void _removeCharge(AdditionalChargesModel charge) {
    final charges =
        List<AdditionalChargesModel>.from(additionalChargesNotifier.value);
    charges.remove(charge);
    additionalChargesNotifier.value = charges;
  }

  void _handleConfirmBooking() {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    final request = _buildBookingRequest();
    log('Booking Request: ${request.toJson()}');

    // TODO: Call the API to create booking
    context.showSnackBar('Booking created successfully!');
  }

  RequestBookingModel _buildBookingRequest() {
    final products = selectedProductsNotifier.value;
    final additionalCharges = additionalChargesNotifier.value;

    return RequestBookingModel(
      clientId: selectedClientId,
      staffId: selectedStaffId,
      client: null,
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

// /// Model for uploaded document files
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
