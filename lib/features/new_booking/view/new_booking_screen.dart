import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart'
    show ServicesModel;
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
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

  int? selectedServiceId = -1; // Initialize to -1 for "All Services" as default
  final serviceSearchController = TextEditingController();

  // SelectProductBloc for inline search
  late SelectProductBloc _selectProductBloc;

  // Search overlay management
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;

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
    _removeSearchOverlay();
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

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
  }

  void _onSearchChanged() {
    // Allow search even if selectedServiceId is null (All Services)
    final query = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
            ? null
            : selectedServiceId;

    if (query.isEmpty) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
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
          serviceId: serviceIdToUse,
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

  void _loadProductsForService(int? serviceId) {
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected (-1), pass null to API
    final serviceIdToUse =
        (serviceId == null || serviceId == -1) ? null : serviceId;

    _selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
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

// BOOKING
  Widget _buildBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main area
        Expanded(
          flex: 5, // ⬅️ more space to main content
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Expanded(child: _buildLeftTopSection()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _buildServiceSelectionSection()),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // Right panel (Slim)
        SizedBox(
          width: 300, // ⬅️ fixed slim width
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
            height: 510,
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
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 10,
                height: 20,
              ),
              Text('  Selected Products',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800)),
            ],
          ),
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
        return BlocListener<SelectProductBloc, SelectProductState>(
          bloc: _selectProductBloc,
          listener: (context, state) {
            // Show/hide overlay based on state
            state.maybeWhen(
              loaded: (products, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11,
                  p12, p13, p14) {
                if (products.isNotEmpty &&
                    serviceSearchController.text.isNotEmpty) {
                  _showSearchOverlay(products);
                } else {
                  _removeSearchOverlay();
                }
              },
              orElse: () => _removeSearchOverlay(),
            );
          },
          child: CompositedTransformTarget(
            link: _searchLayerLink,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
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
                            items: [
                              // "All Services" option
                              DropdownMenuItem<int>(
                                value: -1,
                                child: Row(
                                  children: const [
                                    Icon(Icons.apps,
                                        size: 14, color: Color(0xFF6132E4)),
                                    SizedBox(width: 6),
                                    Text(
                                      'All Services',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6132E4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Regular service options
                              ...services.map((service) {
                                return DropdownMenuItem<int>(
                                  value: service.id,
                                  child: Text(
                                    service.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (id) {
                              if (id != null) {
                                setState(() => selectedServiceId = id);
                                _loadProductsForService(id);
                                serviceSearchController.clear();
                                _removeSearchOverlay();
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
                          _onSearchChanged();
                          if (value.isEmpty) {
                            _removeSearchOverlay();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSearchOverlay(List<ProductModel> products) {
    _removeSearchOverlay();

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.60 - 24,
        child: CompositedTransformFollower(
          link: _searchLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 44),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 320),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search Results (${products.length})',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            serviceSearchController.clear();
                            _removeSearchOverlay();
                          },
                          child: Icon(
                            Icons.close,
                            size: 18,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Product list
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (_, i) =>
                          _buildOverlaySearchItem(products[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  /// Builds search item for the overlay - tapping opens variant selection dialog
  Widget _buildOverlaySearchItem(ProductModel product) {
    final price = product.price ?? 0;
    final variants = product.variants;
    final variantAttributes =
        variants.map((v) => v.attribute).where((a) => a.isNotEmpty).toList();

    return InkWell(
      onTap: () {
        log('Overlay item tapped: ${product.name}');
        _removeSearchOverlay();
        serviceSearchController.clear();
        // Directly add the product instead of showing dialog
        _addProductFromSearch(product);
      },
      child: Center(
        child: Container(
          // width: 950, // 👈 fixed width
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 50,
                  height: 40,
                  color: Colors.grey.shade100,
                  child: product.image != null && product.image!.isNotEmpty
                      ? Image.network(
                          product.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.image_outlined,
                            size: 20,
                            color: Colors.grey.shade400,
                          ),
                        )
                      : Icon(Icons.image_outlined,
                          size: 20, color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(width: 10),
              // Product Info
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            product.color ?? 'color',
                            style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 76),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color(0xFFA6A6A6),
                    ),
                    const SizedBox(width: 76),
                    if (variantAttributes.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: variantAttributes.map((variant) {
                          return _variantChip(variant);
                        }).toList(),
                      ),
                    SizedBox(width: 76),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color(0xFFA6A6A6),
                    ),
                    SizedBox(width: 76),
                    Text(
                      'rent price: ',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),
              // Text(
              //   '₹$price',
              //   style: const TextStyle(
              //     fontSize: 11,
              //     fontWeight: FontWeight.w600,
              //     color: Color(0xFF6132E4),
              //   ),
              // ),
              const SizedBox(width: 8),
              Container(
                width: 70,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFF6132E4),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add, size: 18, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds individual search result item - tapping opens variant selection dialog
  Widget _buildSearchResultItem(ProductModel product) {
    // Check if product is already in selected list
    final selectedProducts = selectedProductsNotifier.value;
    final isAdded = selectedProducts.any(
      (p) => p.variant.productId == product.id,
    );

    // Get the quantity if already added
    int currentQty = 0;
    if (isAdded) {
      for (final p in selectedProducts) {
        if (p.variant.productId == product.id) {
          currentQty += p.quantity;
        }
      }
    }

    // Get variant names
    final variants = product.variants;
    final variantNames = variants
        .map((v) => v.attribute)
        .where((attr) => attr.isNotEmpty)
        .toList();
    final variantText =
        variantNames.isNotEmpty ? variantNames.join(', ') : 'No variants';

    // Get price
    final price = product.price ?? 0;

    return InkWell(
      onTap: () {
        log('Product tapped: ${product.name}');
        // Close search overlay first
        serviceSearchController.clear();
        // Open variant selection dialog
        _showVariantSelectionDialog(product);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 48,
                height: 48,
                color: Colors.grey.shade100,
                child: product.image != null && product.image!.isNotEmpty
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_outlined,
                          size: 24,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Icon(
                        Icons.image_outlined,
                        size: 24,
                        color: Colors.grey.shade400,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (variantNames.isNotEmpty)
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: variantNames.map((variant) {
                        return _variantChip(variant);
                      }).toList(),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    '₹$price',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6132E4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Status indicator
            if (isAdded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check, size: 12, color: Colors.green.shade700),
                    const SizedBox(width: 4),
                    Text(
                      'Added ($currentQty)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              )
            else
              GestureDetector(
                onTap: () => _showVariantSelectionDialog(product),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6132E4),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Add product from search results (uses first variant by default)
  void _addProductFromSearch(ProductModel product) {
    log('_addProductFromSearch called for: ${product.name}');

    final variants = product.variants;
    if (variants.isEmpty) {
      log('No variants available');
      context.showSnackBar('No variants available for this product',
          isError: true);
      return;
    }

    // Get first variant
    final variant = variants.first;
    final price = variant.price ?? product.price ?? 0;
    log('Adding variant: ${variant.attribute}, price: $price');

    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);

    // Check if this variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      // Increment quantity
      final existing = products[existingIndex];
      products[existingIndex] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      // Add new product with first variant
      final attribute =
          variant.attribute.isEmpty ? (product.model ?? '') : variant.attribute;

      products.add(ProductSelectedModel(
        variant: ProductInfoModel(
          id: variant.id,
          variantId: variant.id,
          productId: product.id,
          name: product.name,
          image: product.image,
          amount: price,
          category: product.category,
          color: product.color,
          model: product.model,
          mainServiceType: product.mainServiceType,
          variantAttribute: attribute,
          measurements: [],
          quantity: 1,
        ),
        quantity: 1,
        amount: price,
      ));
    }

    selectedProductsNotifier.value = products;
    log('Product added. Total selected: ${products.length}');
    setState(() {}); // Refresh to update UI
  }

  /// Decrement product quantity from search results
  void _decrementProductFromSearch(ProductModel product) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);

    // Find all variants of this product
    final productVariants =
        products.where((p) => p.variant.productId == product.id).toList();

    if (productVariants.isEmpty) return;

    // Decrement from last added variant
    final lastVariant = productVariants.last;
    final index = products.indexOf(lastVariant);

    if (lastVariant.quantity > 1) {
      products[index] =
          lastVariant.copyWith(quantity: lastVariant.quantity - 1);
    } else {
      products.removeAt(index);
    }

    selectedProductsNotifier.value = products;
    setState(() {}); // Refresh to update UI
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
                    child: Text('product.name',
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
              // onPressed: () {
              //   print(product);
              // },
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
              'Quantity',
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
              'Available',
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
          // Item name with variant info
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.variant.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.variant.color ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA6A6A6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (product.variant.variantAttribute != null &&
                    product.variant.variantAttribute!.isNotEmpty)
                  _variantChip(product.variant.variantAttribute!),
              ],
            ),
          ),
          // Quantity with +/- controls
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _decrementQuantity(product),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Icon(Icons.remove,
                        size: 14, color: Colors.grey.shade700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    '${product.quantity}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () => _incrementQuantity(product),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6132E4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Icon(Icons.add,
                        size: 14, color: Color(0xFF6132E4)),
                  ),
                ),
              ],
            ),
          ),
          // Available stock indicator
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: product.variant.quantity > 0
                      ? const Color(0xFF20D400).withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${product.variant.quantity} left',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: product.variant.quantity > 0
                        ? const Color(0xFF20D400)
                        : Colors.red,
                  ),
                ),
              ),
            ),
          ),
          // Price - Inline Editable
          Expanded(
            child: Container(
              width: 150,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller:
                    TextEditingController(text: product.amount.toString())
                      ..selection = TextSelection.fromPosition(
                        TextPosition(offset: product.amount.toString().length),
                      ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  isDense: true,
                  prefixText: '₹',
                  prefixStyle: TextStyle(fontSize: 14),
                ),
                onSubmitted: (value) {
                  final newPrice = int.tryParse(value) ?? product.amount;
                  _updateProductPrice(product, newPrice);
                },
              ),
            ),
          ),
          // Total
          Expanded(
            child: Text(
              total.toCurrency(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          // Remove button
          SizedBox(
            width: 30,
            child: IconButton(
              onPressed: () => _removeProduct(product),
              icon: Icon(Icons.close, size: 16, color: Colors.grey.shade500),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  /// Increment quantity of a product with stock validation
  void _incrementQuantity(ProductSelectedModel product) {
    // Check available stock
    final availableStock = product.variant.quantity;
    final currentQuantity = product.quantity;

    if (currentQuantity >= availableStock) {
      context.showSnackBar(
        'Cannot add more. Only $availableStock items available in stock',
        isError: true,
      );
      return;
    }

    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );
      selectedProductsNotifier.value = products;
    }
  }

  /// Decrement quantity of a product
  void _decrementQuantity(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index] = products[index].copyWith(
          quantity: products[index].quantity - 1,
        );
      } else {
        products.removeAt(index);
      }
      selectedProductsNotifier.value = products;
    }
  }

  /// Remove a product from the selected list
  void _removeProduct(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    selectedProductsNotifier.value = products;
  }

  /// Show dialog to edit product price
  void _showPriceEditDialog(ProductSelectedModel product) {
    final priceController = TextEditingController(
      text: product.amount.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Price',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.variant.name,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Price',
                prefixText: '₹ ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
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
              final newPrice =
                  int.tryParse(priceController.text) ?? product.amount;
              _updateProductPrice(product, newPrice);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
            ),
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Update the price of a product
  void _updateProductPrice(ProductSelectedModel product, int newPrice) {
    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      selectedProductsNotifier.value = products;
    }
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
                    label: 'Advance Amount (optional)',
                  ),
                  const SizedBox(height: 8),
                  if (!isSalesMode) ...[
                    _buildCompactAmountField(
                      controller: securityAmountController,
                      label: 'Security Amount (optional)',
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildCompactAmountField(
                    controller: discountAmountController,
                    label: 'Discount Amount (optional)',
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
        Row(
          children: [
            const Text(
              'Summary',
              style: TextStyle(fontSize: 18, color: Color(0xFF3E3E3E)),
            ),
          ],
        ),
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
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 13),
                hintText: label,
                prefixText: '₹ ',
                prefixStyle:
                    TextStyle(fontSize: 16, color: Colors.grey.shade600),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
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
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
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
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
        color: Color.fromARGB(255, 245, 242, 254),
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
                  _buildSummaryRow('Product total', productTotal),
                  if (additionalTotal > 0)
                    _buildSummaryRow('Additional charges', additionalTotal),
                  if (discountAmount > 0)
                    _buildSummaryRow('- Discount', discountAmount,
                        isNegative: true),
                  const Divider(height: 12),
                  _buildSummaryRow('Paid', advanceAmount,
                      valueColor: AppColors.green),
                  _buildSummaryRow(
                    'Total payable',
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

    // If "All Services" is selected (-1), pass null to the screen
    final serviceIdToUse = selectedServiceId == -1 ? null : selectedServiceId;

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
            serviceId: serviceIdToUse,
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

  void _handleConfirmBooking() async {
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

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Call the API to create booking
      final repository = getIt<BookingRepository>();
      await repository.addBooking(request);

      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Show success message
      if (mounted) {
        context.showSnackBar('Booking created successfully!');

        // Navigate back or close
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Show error message
      if (mounted) {
        context.showSnackBar(
          'Failed to create booking: ${e.toString()}',
          isError: true,
        );
      }
      log('Error creating booking: $e');
    }
  }

  RequestBookingModel _buildBookingRequest() {
    final products = selectedProductsNotifier.value;
    final additionalCharges = additionalChargesNotifier.value;

    // If there's no client ID, we need to send client data
    ClientRequestModel? clientData;
    if (selectedClientId == null) {
      final phone1 = clientPhone1Controller.text.trim().toIntOrNull();
      final phone2 = clientPhone2Controller.text.trim().toIntOrNull();

      clientData = ClientRequestModel(
        id: null,
        name: clientNameController.text.trim().isEmpty
            ? null
            : clientNameController.text.trim(),
        phone1: phone1,
        phone2: phone2,
      );
    }

    return RequestBookingModel(
      clientId: selectedClientId,
      staffId: selectedStaffId,
      client: clientData,
      address: clientAddressController.text.trim(),
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      coolingPeriodDate: coolingPeriodDate?.format(),
      advanceAmount: advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: securityAmountController.text.trim().toIntOrNull(),
      discountAmount: discountAmountController.text.trim().toIntOrNull(),
      purchaseMode: 'normal',
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

Widget _variantChip(String text) {
  return Container(
    width: 35,
    height: 35,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(255, 225, 215, 255),
      border: Border.all(color: Colors.grey.shade200, width: 0.6),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    ),
  );
}

// Widget _variantChipForSelected(String text) {
//   return Container(
//     width: 35,
//     height: 35,
//     alignment: Alignment.center,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       // color: Color.fromARGB(255, 225, 215, 255),
//       border: Border.all(color: Colors.grey.shade200, width: 0.6),
//     ),
//     child: Text(
//       text,
//       style: TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w600,
//         color: Colors.grey.shade700,
//       ),
//     ),
//   );
// }
class WebToast extends StatelessWidget {
  final String message;
  final bool isError;
  final Color? color;
  final VoidCallback onClose;

  const WebToast({
    required this.message,
    required this.onClose,
    this.isError = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: color ??
              (isError ? const Color(0xFFFFF0F0) : const Color(0xFFF0FFF5)),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isError ? Colors.red.shade300 : Colors.green.shade300,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black.withOpacity(.12),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              size: 18,
              color: isError ? Colors.red : Colors.green,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onClose,
              child: const Icon(Icons.close, size: 16),
            )
          ],
        ),
      ),
    );
  }
}
