import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:flutter/services.dart';
import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart'
    show ServicesModel;
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_search_type_bottom_sheet.dart';

import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_sales_model/request_sales_model.dart';

import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_header.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_date_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_product_selection_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_client_details_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_payment_details_section.dart';

/// Booking types enum for the tab selection
enum BookingType { booking, sales, customWork }

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
  State<NewBookingScreen> createState() => NewBookingScreenState();
}

class NewBookingScreenState extends State<NewBookingScreen> {
  // Current selected tab
  BookingType selectedBookingType = BookingType.booking;

  static const double kFieldSpacing = 10.0;
  bool isDocumentsExpanded = false;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Date controllers
  late DateTime pickupDate;
  late DateTime returnDate;
  DateTime? coolingPeriodDate;
  TimeOfDay? coolingPeriodTime;
  TimeOfDay? pickupTime;

  TimeOfDay? returnTime;
  int coolingPeriodDays = 0;

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
  bool sendPdfToWhatsApp = true;

  // Products/Services
  final selectedProductsNotifier =
      ValueNotifier<List<ProductSelectedModel>>([]);

  // Additional charges
  final additionalChargesNotifier =
      ValueNotifier<List<AdditionalChargesModel>>([]);

  // Documents
  final documentsNotifier = ValueNotifier<List<DocumentFile>>([]);

  // Description
  // Description
  final descriptionController = TextEditingController();

  int? selectedServiceId = -1; // Initialize to -1 for "All Services" as default

  // SelectProductBloc for inline search
  late SelectProductBloc _selectProductBloc;

  // Right Panel Page Controller
  late PageController _rightPanelPageController;
  final startLocationController = TextEditingController();
  final destinationController = TextEditingController();

  final serviceSearchController = TextEditingController();
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;
  final ValueNotifier<bool> _isPriceFilterEnabled = ValueNotifier<bool>(false);
  final ValueNotifier<int> _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final List<String> _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final ValueNotifier<double> _maxPriceNotifier = ValueNotifier<double>(10000);
  final ValueNotifier<RangeValues> _priceRange =
      ValueNotifier<RangeValues>(const RangeValues(0, 10000));

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));
    _rightPanelPageController = PageController();

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      context.read<StaffSearchCubit>().getAllStaffs();
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
    _selectProductBloc.close();
    _rightPanelPageController.dispose();
    startLocationController.dispose();
    destinationController.dispose();
    serviceSearchController.dispose();
    _isPriceFilterEnabled.dispose();
    _selectedSearchTypeIndex.dispose();
    _maxPriceNotifier.dispose();
    _priceRange.dispose();
    super.dispose();
  }

  /// Check if there are any unsaved changes
  bool hasUnsavedChanges() {
    // Check if products are selected
    if (selectedProductsNotifier.value.isNotEmpty) return true;

    // Check if client details are filled
    if (clientNameController.text.trim().isNotEmpty) return true;
    if (clientPhone1Controller.text.trim().isNotEmpty) return true;
    if (clientPhone2Controller.text.trim().isNotEmpty) return true;
    if (clientAddressController.text.trim().isNotEmpty) return true;

    // Check if payment details are filled
    if (advanceAmountController.text.trim().isNotEmpty) return true;
    if (securityAmountController.text.trim().isNotEmpty) return true;
    if (discountAmountController.text.trim().isNotEmpty) return true;

    // Check if additional charges exist
    if (additionalChargesNotifier.value.isNotEmpty) return true;

    // Check if documents are uploaded
    if (documentsNotifier.value.isNotEmpty) return true;

    // Check if description is filled
    if (descriptionController.text.trim().isNotEmpty) return true;

    return false;
  }

  /// Handle back navigation with discard dialog if needed
  Future<void> _handleBackNavigation() async {
    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true) {
        if (!mounted) return;
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop();
        }
      }
    } else {
      // No changes, navigate directly
      if (widget.onClose != null) {
        widget.onClose!();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _handleTabSwitch(BookingType newType) async {
    // print('Switching tab to $newType');
    if (selectedBookingType == newType) return;

    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true) {
        _resetForm();
        setState(() => selectedBookingType = newType);
        _loadProductsForService(selectedServiceId);
      }
    } else {
      setState(() => selectedBookingType = newType);
      _loadProductsForService(selectedServiceId);
    }
  }

  void _resetForm() {
    clientNameController.clear();
    clientPhone1Controller.clear();
    clientPhone2Controller.clear();
    clientAddressController.clear();
    staffNameController.clear();
    selectedStaffId = null;
    selectedClientId = null;
    advanceAmountController.clear();
    securityAmountController.clear();
    discountAmountController.clear();
    descriptionController.clear();
    selectedProductsNotifier.value = [];
    additionalChargesNotifier.value = [];
    documentsNotifier.value = [];
    serviceSearchController.clear();
    context.read<StaffSearchCubit>().clearSelectedStaff();
    context.read<ClientCubit>().clearSelected();
  }

  /// Show product filter bottom sheet
  void _showProductFilterBottomSheet() {
    // Get available services
    final serviceState = context.read<ServiceBloc>().state;
    final services = serviceState.maybeWhen(
        loaded: (s) => s, orElse: () => <ServicesModel>[]);

    // Create notifier for service selection (default to -1/All if null)
    final selectedServiceIdNotifier =
        ValueNotifier<int>(selectedServiceId ?? -1);

    // Calculate max price from current product list
    final currentProducts = _selectProductBloc.state.maybeWhen(
      loaded: (
        products,
        nextPageUrl,
        serviceId,
        pickupDate,
        returnDate,
        isPaginating,
        isSearching,
        searchQuery,
        searchType,
        startPrice,
        endPrice,
        pickupTime,
        returnTime,
        useAvailableProductsApi,
        isSales,
      ) =>
          products,
      orElse: () => <ProductModel>[],
    );

    if (currentProducts.isNotEmpty) {
      double maxProductPrice = 0;
      for (final product in currentProducts) {
        final productPrice = product.price ?? 0;
        if (productPrice > maxProductPrice) {
          maxProductPrice = productPrice.toDouble();
        }
        // Also check variant prices
        for (final variant in product.variants) {
          final variantPrice = variant.price ?? 0;
          if (variantPrice > maxProductPrice) {
            maxProductPrice = variantPrice.toDouble();
          }
        }
      }
      if (maxProductPrice > _maxPriceNotifier.value) {
        _maxPriceNotifier.value = maxProductPrice;
        _priceRange.value = RangeValues(0, maxProductPrice);
      }
    }

    showSearchTypeBottomSheet(
      context: context,
      searchTypes: _searchTypes,
      selectedSearchTypeIndex: _selectedSearchTypeIndex,
      onTap: (type, index) {
        _selectedSearchTypeIndex.value = index;
      },
      priceRange: _priceRange,
      minPrice: 0,
      maxPriceNotifier: _maxPriceNotifier,
      onPriceChanged: (range) {
        _priceRange.value = range;
      },
      isPriceFilterEnabledNotifier: _isPriceFilterEnabled,
      onApply: (typeIndex, range, isPriceEnabled) {
        // Update selected service
        setState(() {
          selectedServiceId = selectedServiceIdNotifier.value;
        });

        // Apply filters to product search
        _applyProductFilters(typeIndex, range, isPriceEnabled);
      },
      services: services,
      selectedServiceIdNotifier: selectedServiceIdNotifier,
    );
  }

  /// Apply product filters based on selection
  void _applyProductFilters(
      int searchTypeIndex, RangeValues priceRange, bool isPriceEnabled) {
    _isPriceFilterEnabled.value = isPriceEnabled;
    final searchTerm = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;

    // Determine search type
    String? searchType;
    switch (searchTypeIndex) {
      case 0:
        searchType = 'name';
        break;
      case 1:
        searchType = 'category';
        break;
      case 2:
        searchType = 'model';
        break;
      case 3:
        searchType = 'color';
        break;
    }

    // Check if any filter is applied
    final hasAnyFilter =
        searchTerm.isNotEmpty || isPriceEnabled || searchTypeIndex != 0;

    // Trigger search with filters
    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: searchTerm.isEmpty ? null : searchTerm,
          type: searchType,
          startPrice: isPriceEnabled ? priceRange.start.toInt() : null,
          endPrice: isPriceEnabled ? priceRange.end.toInt() : null,
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    } else {
      // No filters applied, load all products
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
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

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _handleBackNavigation();
      },
      child: Container(
        color: const Color(0xFFF5F6FA),
        height: screenHeight,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header with tabs
              BookingHeader(
                selectedBookingType: selectedBookingType,
                onTabSwitch: _handleTabSwitch,
                onBack: _handleBackNavigation,
              ),
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
      ),
    );
  }

  Widget _buildMainContent() {
    switch (selectedBookingType) {
      case BookingType.sales:
        return _buildSalesContent();
      case BookingType.customWork:
        return const Center(child: Text('Custom Work UI Placeholder'));
      case BookingType.booking:
        return _buildBookingContent();
    }
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
              BookingDateSection(
                pickupDate: pickupDate,
                returnDate: returnDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodDays: coolingPeriodDays,
                onPickupDateTap: () => _selectDate(isPickup: true),
                onReturnDateTap: () => _selectDate(isPickup: false),
                onPickupTimeTap: () => _selectTime(isPickup: true),
                onReturnTimeTap: () => _selectTime(isPickup: false),
                onCoolingPeriodChanged: (days) {
                  if (days != null) {
                    setState(() {
                      coolingPeriodDays = days;
                      if (days > 0) {
                        coolingPeriodDate =
                            returnDate.add(Duration(days: days));
                      } else {
                        coolingPeriodDate = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BookingProductSelectionSection(
                  selectProductBloc: _selectProductBloc,
                  selectedProductsNotifier: selectedProductsNotifier,
                  bookingType: selectedBookingType,
                  pickupDate: pickupDate,
                  returnDate: returnDate,
                  pickupTime: pickupTime,
                  returnTime: returnTime,
                ),
              ),
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
          flex: 5,
          child: Column(
            children: [
              BookingDateSection(
                pickupDate: pickupDate,
                returnDate: returnDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodDays: coolingPeriodDays,
                onPickupDateTap: () => _selectDate(isPickup: true),
                onReturnDateTap: () => _selectDate(isPickup: false),
                onPickupTimeTap: () => _selectTime(isPickup: true),
                onReturnTimeTap: () => _selectTime(isPickup: false),
                onCoolingPeriodChanged: (days) {
                  if (days != null) {
                    setState(() {
                      coolingPeriodDays = days;
                      if (days > 0) {
                        coolingPeriodDate =
                            returnDate.add(Duration(days: days));
                      } else {
                        coolingPeriodDate = null;
                      }
                    });
                  }
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BookingProductSelectionSection(
                  selectProductBloc: _selectProductBloc,
                  selectedProductsNotifier: selectedProductsNotifier,
                  bookingType: selectedBookingType,
                  pickupDate: pickupDate,
                  returnDate: returnDate,
                  pickupTime: pickupTime,
                  returnTime: returnTime,
                ),
              ),
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
        // Update cooling period date if days are selected
        if (coolingPeriodDays > 0) {
          coolingPeriodDate = returnDate.add(Duration(days: coolingPeriodDays));
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
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: descriptionController,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter notes...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 13,
                    fontFamily: 'Inter',
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftTopSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              // Pickup Date
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildCompactDateField(
                        label: 'Pickup Date',
                        value: pickupDate.format(),
                        onTap: () => _selectDate(isPickup: true),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: _buildCompactTimeField(
                        label: 'Time',
                        value: pickupTime?.format(context) ?? '--:--',
                        onTap: () => _selectTime(isPickup: true),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Return Date
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildCompactDateField(
                        label: 'Return Date',
                        value: returnDate.format(),
                        onTap: () => _selectDate(isPickup: false),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: _buildCompactTimeField(
                        label: 'Time',
                        value: returnTime?.format(context) ?? '--:--',
                        onTap: () => _selectTime(isPickup: false),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Cooling Period (Days Selector)
              Expanded(
                child: _buildCoolingPeriodSelector(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCoolingPeriodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cooling Period',
          style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Container(
          height: 38, // Match approximate height of date field
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: coolingPeriodDays,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  size: 16, color: Colors.grey.shade500),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                fontFamily: 'Inter',
              ),
              items: [
                const DropdownMenuItem<int>(
                  value: 0,
                  child: Text('None'),
                ),
                ...List.generate(30, (index) {
                  final days = index + 1;
                  return DropdownMenuItem<int>(
                    value: days,
                    child: Text('$days Day${days > 1 ? 's' : ''}'),
                  );
                }),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    coolingPeriodDays = value;
                    if (value > 0) {
                      coolingPeriodDate = returnDate.add(Duration(days: value));
                    } else {
                      coolingPeriodDate = null;
                    }
                  });
                }
              },
            ),
          ),
        ),
      ],
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
              loaded: (products, p1, p2, p3, p4, p5, isSearching, p7, p8, p9,
                  p10, p11, p12, p13, p14) {
                // Show overlay if:
                // 1. There are products AND
                // 2. Either search text is not empty OR filters are applied (isSearching = true)
                final hasSearchText = serviceSearchController.text.isNotEmpty;
                final hasFilters = _isPriceFilterEnabled.value ||
                    _selectedSearchTypeIndex.value != 0;

                if (hasSearchText ||
                    hasFilters ||
                    (products.isNotEmpty && isSearching)) {
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
                  // Search TextField - Now takes full width minus filter button
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: serviceSearchController,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIcon: const Icon(Icons.search, size: 18),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                        onChanged: (value) {
                          _onSearchChanged();
                          if (value.isEmpty) {
                            _removeSearchOverlay();
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Filter Button
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: IconButton(
                      onPressed: _showProductFilterBottomSheet,
                      icon: const Icon(Icons.tune, size: 20),
                      color: const Color(0xFF6132E4),
                      tooltip: 'Filter products',
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

  void _onSearchChanged() {
    final searchTerm = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;

    // Determine search type
    String? searchType;
    switch (_selectedSearchTypeIndex.value) {
      case 0:
        searchType = 'name';
        break;
      case 1:
        searchType = 'category';
        break;
      case 2:
        searchType = 'model';
        break;
      case 3:
        searchType = 'color';
        break;
    }

    _selectProductBloc.add(
      SelectProductEvent.searchProducts(
        serviceId: selectedServiceId == -1 ? null : selectedServiceId,
        query: searchTerm.isEmpty ? null : searchTerm,
        type: searchType,
        startPrice: _isPriceFilterEnabled.value
            ? _priceRange.value.start.toInt()
            : null,
        endPrice:
            _isPriceFilterEnabled.value ? _priceRange.value.end.toInt() : null,
        pickupDate: pickupDate.format(),
        returnDate: returnDate.format(),
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
      ),
    );
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
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
                  products.isEmpty
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.search_off_rounded,
                                  size: 48, color: Colors.grey.shade300),
                              const SizedBox(height: 16),
                              Text(
                                'No results found',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Try adjusting your search or filters',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Flexible(
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

  /// Builds search item for the overlay - requires variant selection before adding
  Widget _buildOverlaySearchItem(ProductModel product) {
    return _OverlaySearchItem(
      product: product,
      onAddProduct: (selectedVariant) {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _addProductFromSearchWithVariant(product, selectedVariant);
      },
    );
  }

  /// Add product from search with specific variant
  void _addProductFromSearchWithVariant(
      ProductModel product, ProductVariantModel variant) {
    log('_addProductFromSearchWithVariant called for: ${product.name}, variant: ${variant.attribute}');

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
      // Add new product with selected variant
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
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 72,
                height: 72,
                color: Colors.grey.shade100,
                child: product.image != null && product.image!.isNotEmpty
                    ? Image.network(
                        product.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(
                          Icons.image_outlined,
                          size: 32,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Icon(
                        Icons.image_outlined,
                        size: 32,
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
      height: 36,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "Item",
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Variants",
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Price",
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          const SizedBox(width: 60),
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
            flex: 4,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'items',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Variants',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Available',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Price / item',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Total',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 30), // Spacing for close icon
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
            child: SingleChildScrollView(
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          // ITEMS COLUMN (Flex 4)
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: product.variant.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            product.variant.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.image_outlined,
                              size: 20,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        )
                      : Icon(Icons.image_outlined,
                          size: 20, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.variant.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${product.variant.color ?? ''}, ${product.variant.category ?? ''}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8C8C8C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // VARIANTS COLUMN (Flex 2)
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                (product.variant.variantAttribute != null &&
                        product.variant.variantAttribute!.isNotEmpty)
                    ? product.variant.variantAttribute!
                    : '-',
                style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // AVAILABLE COLUMN (Flex 2)
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF20D400).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1AB000),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${product.variant.quantity} left',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1AB000),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // QUANTITY COLUMN (Flex 2)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _decrementQuantity(product),
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EAFC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.remove,
                        size: 14, color: Color(0xFF6132E4)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${product.quantity}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                InkWell(
                  onTap: product.quantity >= product.variant.quantity
                      ? null
                      : () => _incrementQuantity(product),
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0EAFC),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.add,
                        size: 14, color: Color(0xFF6132E4)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // PRICE / ITEM COLUMN (Flex 2)
          Expanded(
            flex: 2,
            child: _InlinePriceEditor(
              initialPrice: product.amount,
              onPriceChanged: (newPrice) =>
                  _updateProductPrice(product, newPrice),
            ),
          ),
          const SizedBox(width: 4),
          // TOTAL COLUMN (Flex 2)
          Expanded(
            flex: 2,
            child: Text(
              total.toCurrency(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          // Remove button
          SizedBox(
            width: 30,
            child: IconButton(
              onPressed: () => _removeProduct(product),
              icon: const Icon(Icons.close, size: 18, color: Colors.black87),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              splashRadius: 20,
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

  /// Update product price
  void _updateProductPrice(ProductSelectedModel product, int newPrice) {
    if (newPrice < 0) return;

    final products =
        List<ProductSelectedModel>.from(selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );

    if (index != -1) {
      products[index] = products[index].copyWith(
        amount: newPrice,
      );
      selectedProductsNotifier.value = products;
    }
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

  Widget _buildRightSection() {
    return PageView(
      controller: _rightPanelPageController,
      physics: const NeverScrollableScrollPhysics(), // Disable swipe
      children: [
        BookingClientDetailsSection(
          clientNameController: clientNameController,
          clientPhone1Controller: clientPhone1Controller,
          clientPhone2Controller: clientPhone2Controller,
          clientAddressController: clientAddressController,
          staffNameController: staffNameController,
          descriptionController: descriptionController,
          documentsNotifier: documentsNotifier,
          sendPdfToWhatsApp: sendPdfToWhatsApp,
          onWhatsAppChanged: (val) => setState(() => sendPdfToWhatsApp = val),
          onStaffSelected: (staff) {
            setState(() {
              selectedStaffId = staff.id;
              staffNameController.text = staff.name;
            });
          },
          onContinue: () {
            _rightPanelPageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        BookingPaymentDetailsSection(
          startLocationController: startLocationController,
          pickupLocationController:
              clientAddressController, // reusing client address as pickup?
          destinationController: destinationController,
          advanceAmountController: advanceAmountController,
          securityAmountController: securityAmountController,
          discountAmountController: discountAmountController,
          additionalChargesNotifier: additionalChargesNotifier,
          selectedProductsNotifier: selectedProductsNotifier,
          onBack: () {
            _rightPanelPageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          onConfirmBooking: _handleConfirmBooking,
        ),
      ],
    );
  }

  Widget _buildClientDetailsStep() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Client Details',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Name", clientNameController),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Phone", clientPhone1Controller),
                        const SizedBox(height: kFieldSpacing),
                        _buildClientField("Phone 2", clientPhone2Controller),
                        const SizedBox(height: kFieldSpacing),
                        // Replaced standard field with Autocomplete
                        _buildAddressAutocompleteField(
                            "Place", clientAddressController),
                        const SizedBox(height: kFieldSpacing),
                        _buildWhatsappSection(),
                        const SizedBox(height: kFieldSpacing),
                        _buildDocumentUploadSection(),
                        const SizedBox(height: kFieldSpacing),
                        _buildStaffSection(),
                        const SizedBox(height: kFieldSpacing),
                        _buildNotesField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                // Continue Button (Fixed at bottom)
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      _rightPanelPageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentStep() {
    return Column(
      children: [
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
                  // Back Button Header
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _rightPanelPageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Icon(Icons.arrow_back,
                            size: 18, color: Colors.grey.shade700),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Locations Section
                  Row(
                    children: const [
                      Text(
                        'Locations',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildClientField("Start location", startLocationController,
                      action: TextInputAction.next),
                  const SizedBox(height: kFieldSpacing),
                  _buildClientField("Pickup location", clientAddressController,
                      action: TextInputAction.next),
                  const SizedBox(height: kFieldSpacing),
                  _buildClientField(
                      "Destination location", destinationController,
                      action: TextInputAction.next),

                  const SizedBox(height: 16),

                  // Payment Details Section
                  Row(
                    children: const [
                      Text(
                        'Payment details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3E3E3E),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(optional)',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildClientField("Advance amount", advanceAmountController,
                      action: TextInputAction.next),
                  const SizedBox(height: kFieldSpacing),
                  _buildClientField("Security amount", securityAmountController,
                      action: TextInputAction.next),
                  const SizedBox(height: kFieldSpacing),
                  _buildClientField("Discount amount", discountAmountController,
                      action: TextInputAction.done),

                  const SizedBox(height: 16),

                  // Additional Charges Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Additional charges',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      InkWell(
                        onTap: _addAdditionalCharge,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F2FF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add,
                              size: 16, color: Color(0xFF6132E4)),
                        ),
                      ),
                    ],
                  ),
                  // List of additional charges
                  ValueListenableBuilder<List<AdditionalChargesModel>>(
                    valueListenable: additionalChargesNotifier,
                    builder: (context, charges, _) {
                      if (charges.isEmpty) return const SizedBox.shrink();
                      return Column(
                        children: charges.map((charge) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    charge.name ?? 'Charge',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                                Text(
                                  '+ ₹${charge.amount ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () => _removeCharge(charge),
                                  child: const Icon(Icons.close,
                                      size: 14, color: Colors.red),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Summary Header for the second step
        Row(
          children: const [
            SizedBox(width: 6),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Color(0xFF3E3E3E),
              ),
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
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]')), // Strict regex for digits
            ],
            onChanged: (value) {
              // Extra layer of protection
              if (value.contains(RegExp(r'[^0-9]'))) {
                final cleanText = value.replaceAll(RegExp(r'[^0-9]'), '');
                controller.value = TextEditingValue(
                  text: cleanText,
                  selection: TextSelection.collapsed(offset: cleanText.length),
                );
              }
            },
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                final amount = int.tryParse(value);
                if (amount == 0) {
                  return 'Amount cannot be 0';
                }
              }
              return null;
            },
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                color: Color(0xFF8C8C8C),
              ),
              hintText: label,
              prefixText: '₹ ',
              prefixStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              // Use OutlineInputBorder to match previous container style
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF6132E4), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                  borderRadius: BorderRadius.circular(8),
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
                  borderRadius: BorderRadius.circular(8),
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
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        charge.name ?? 'Charge',
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '₹${charge.amount ?? 0}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
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
        height: 40, // Consistent height for payment method options
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6132E4).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
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
                fontSize: 13,
                fontFamily: 'Inter',
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
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DeliveryStatus>(
              value: deliveryStatus,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  size: 18, color: Colors.grey.shade600),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
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
                    const Divider(height: 6),
                    _buildSummaryRow('Paid', advanceAmount,
                        valueColor: const Color(0xFF1AB000)),
                    _buildSummaryRow(
                      'Total payable',
                      remainingAmount > 0 ? remainingAmount : 0,
                      valueColor: const Color(0xFFD30000),
                      isBold: true,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
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
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget _buildStaffSection() {
    return BlocBuilder<StaffSearchCubit, StaffSearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Staff Details',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            LayoutBuilder(
              builder: (context, constraints) {
                return Autocomplete<StaffModel>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return state.staffs;
                    }
                    return state.staffs.where((StaffModel option) {
                      return option.name
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  displayStringForOption: (StaffModel option) => option.name,
                  onSelected: (StaffModel selection) {
                    setState(() {
                      selectedStaffId = selection.id;
                      staffNameController.text = selection.name;
                    });
                  },
                  fieldViewBuilder: (
                    BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted,
                  ) {
                    // Sync controller with local state if needed
                    if (selectedStaffId != null &&
                        textEditingController.text.isEmpty &&
                        staffNameController.text.isNotEmpty) {
                      textEditingController.text = staffNameController.text;
                    }

                    return Container(
                      height: 40,
                      alignment: Alignment.centerLeft,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 0.50,
                            color: Color(0xFFA2A2A2),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          hintText: 'Select Staff',
                          hintStyle: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                          suffixIcon: Icon(Icons.keyboard_arrow_down,
                              size: 18, color: Color(0xFF8C8C8C)),
                        ),
                      ),
                    );
                  },
                  optionsViewBuilder: (
                    BuildContext context,
                    AutocompleteOnSelected<StaffModel> onSelected,
                    Iterable<StaffModel> options,
                  ) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        child: Container(
                          width: constraints.maxWidth,
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final StaffModel option =
                                  options.elementAt(index);
                              return InkWell(
                                onTap: () {
                                  onSelected(option);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 10.0),
                                  child: Text(
                                    option.name,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildClientField(String label, TextEditingController controller,
      {TextInputAction action = TextInputAction.next}) {
    return Container(
      width: double.infinity,
      height: 37,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFA2A2A2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: controller,
        textInputAction: action,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF8C8C8C),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildAddressAutocompleteField(
      String label, TextEditingController controller) {
    return Container(
      width: double.infinity,
      height: 37,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFA2A2A2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Color(0xFF8C8C8C),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          isDense: true,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildNotesField() {
    return Container(
      width: double.infinity,
      height: 77,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.50,
            color: Color(0xFFA2A2A2),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: null,
        expands: true,
        textInputAction: TextInputAction.newline,
        textAlignVertical: TextAlignVertical.top,
        style: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Colors.black87,
        ),
        decoration: const InputDecoration(
          hintText: 'Notes',
          hintStyle: TextStyle(
            color: Color(0xFF8C8C8C),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildWhatsappSection() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              sendPdfToWhatsApp = !sendPdfToWhatsApp;
            });
          },
          child: Container(
            width: 18,
            height: 18,
            decoration: ShapeDecoration(
              color: sendPdfToWhatsApp
                  ? const Color(0xFF6132E4)
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: sendPdfToWhatsApp
                      ? const Color(0xFF6132E4)
                      : const Color(0xFFA2A2A2),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: sendPdfToWhatsApp
                ? const Icon(Icons.check,
                    size: 14, color: Color(0xFFFFD700)) // Golden tick
                : null,
          ),
        ),
        const SizedBox(width: 10),
        const SizedBox(
          child: Text(
            'Send invoice to whatsapp',
            style: TextStyle(
              color: Color(0xFF8C8C8C),
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSummaryRow(
    String label,
    int amount, {
    Color? valueColor,
    bool isBold = false,
    bool isNegative = false,
  }) {
    final isTotalPayable = label == 'Total payable';
    final isPaid = label == 'Paid';
    final isProductTotal = label == 'Product total';

    double labelSize = 15;
    double valueSize = 13;
    FontWeight labelWeight = isBold ? FontWeight.w600 : FontWeight.w400;
    FontWeight valueWeight = isBold ? FontWeight.w700 : FontWeight.w500;
    Color labelColor = const Color(0xFF3E3E3E);

    if (isTotalPayable) {
      labelSize = 15;
      valueSize = 15;
      labelWeight = FontWeight.w600;
      valueWeight = FontWeight.w700;
      valueColor = const Color(0xFFD30000);
    } else if (isPaid) {
      labelSize = 15;
      valueSize = 15;
      labelWeight = FontWeight.w500;
      valueWeight = FontWeight.w600;
      valueColor = const Color(0xFF1AB000);
    } else if (isProductTotal) {
      labelSize = 13;
      valueSize = 13;
      labelWeight = FontWeight.w400;
      valueWeight = FontWeight.w500;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: labelSize,
              fontFamily: 'Inter',
              fontWeight: labelWeight,
              color: labelColor,
            ),
          ),
          Text(
            '${isNegative ? '-' : ''}${amount.abs().toCurrency()}',
            style: TextStyle(
              fontSize: valueSize,
              fontFamily: 'Inter',
              fontWeight: valueWeight,
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
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
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

  Widget _buildDocumentUploadSection() {
    return ValueListenableBuilder<List<DocumentFile>>(
      valueListenable: documentsNotifier,
      builder: (context, documents, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload Documents',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            if (documents.isEmpty)
              InkWell(
                onTap: () => _pickDocuments(),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0.50,
                        color: Color(0xFFA2A2A2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.upload_file,
                          size: 16, color: Color(0xFF8C8C8C)),
                      const SizedBox(width: 8),
                      Text(
                        'Click to upload',
                        style: TextStyle(
                          color: const Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else if (!isDocumentsExpanded)
              InkWell(
                onTap: () {
                  setState(() {
                    isDocumentsExpanded = true;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 0.50,
                        color: Color(0xFFA2A2A2),
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${documents.length} document uploads',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 80,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.5, color: Color(0xFFA2A2A2)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: documents.length + 1,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    if (index == documents.length) {
                      return InkWell(
                        onTap: () => _pickDocuments(),
                        child: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Icon(Icons.add, color: Colors.grey),
                        ),
                      );
                    }
                    final doc = documents[index];
                    // Basic thumbnail
                    return Stack(
                      children: [
                        Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: doc.bytes != null &&
                                  [
                                    'jpg',
                                    'jpeg',
                                    'png',
                                    'gif',
                                    'webp'
                                  ].contains(
                                      doc.name.split('.').last.toLowerCase())
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.memory(
                                    Uint8List.fromList(doc.bytes!),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Icon(Icons.description,
                                      size: 24, color: Colors.grey)),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              final newDocs = List<DocumentFile>.from(
                                  documentsNotifier.value);
                              newDocs.removeAt(index);
                              documentsNotifier.value = newDocs;
                              if (newDocs.isEmpty) {
                                setState(() {
                                  isDocumentsExpanded = false;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              color: Colors.white.withOpacity(0.7),
                              child: const Icon(Icons.close,
                                  size: 12, color: Colors.red),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  void _pickDocuments() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'],
        allowMultiple: true,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final newDocs = result.files.map((file) {
          return DocumentFile(
            name: file.name,
            path: file.path ?? '',
            bytes: file.bytes,
          );
        }).toList();

        final currentDocs = List<DocumentFile>.from(documentsNotifier.value);
        currentDocs.addAll(newDocs);
        documentsNotifier.value = currentDocs;
      }
    } catch (e) {
      debugPrint('Error picking files: $e');
      if (mounted) {
        context.showSnackBar('Error picking files', isError: true);
      }
    }
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

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final repository = getIt<BookingRepository>();

      // Check if it's a sale or booking
      if (selectedBookingType == BookingType.sales) {
        // Build sales request
        final salesRequest = _buildSalesRequest();
        log('Sales Request: ${salesRequest.toJson()}');

        // Call the API to create sale
        await repository.createSale(salesRequest.toJson());

        // Close loading dialog
        if (mounted) Navigator.of(context).pop();

        // Show success message
        if (mounted) {
          context.showSnackBar('Sale created successfully!');
          // Navigate back or close
          if (widget.onClose != null) {
            widget.onClose!();
          } else {
            Navigator.of(context).pop();
          }
        }
      } else {
        // Build booking request
        final bookingRequest = _buildBookingRequest();
        log('Booking Request: ${bookingRequest.toJson()}');

        // Call the API to create booking
        await repository.addBooking(bookingRequest);

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
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) Navigator.of(context).pop();

      // Show error message
      if (mounted) {
        final message = selectedBookingType == BookingType.sales
            ? 'Failed to create sale: ${e.toString()}'
            : 'Failed to create booking: ${e.toString()}';
        context.showSnackBar(message, isError: true);
      }
      log('Error: $e');
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
      pickupDate: pickupDate.format().appendTimeToDate(time: pickupTime),
      returnDate: returnDate.format().appendTimeToDate(time: returnTime),
      coolingPeriodDate:
          coolingPeriodDate?.format().appendTimeToDate(time: coolingPeriodTime),
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
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
    );
  }

  /// Build sales request for creating a sale
  RequestSalesModel _buildSalesRequest() {
    final products = selectedProductsNotifier.value;

    // Build variants array with id, quantity, and amount
    final variants = products.map((product) {
      return {
        'id': product.variant.variantId,
        'quantity': product.quantity,
        'amount': product.amount,
      };
    }).toList();

    // Use phone1 as client_phone
    final clientPhone = clientPhone1Controller.text.trim();

    return RequestSalesModel(
      staffId: selectedStaffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      clientAddress: clientAddressController.text.trim().isEmpty
          ? null
          : clientAddressController.text.trim(),
      saleDate: pickupDate.format(), // Use pickup date as sale date
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      sendInvoice: sendPdfToWhatsApp,
      variants: variants,
      paidAmount: advanceAmountController.text.trim().toIntOrNull() ?? 0,
      paymentMethod: paymentMethod,
      discount: discountAmountController.text.trim().toIntOrNull() ?? 0,
      decreaseStock: false,
    );
  }
}

// Stateful widget for overlay search item with variant selection
class _OverlaySearchItem extends StatefulWidget {
  final ProductModel product;
  final Function(ProductVariantModel) onAddProduct;

  const _OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
  });

  @override
  State<_OverlaySearchItem> createState() => _OverlaySearchItemState();
}

class _OverlaySearchItemState extends State<_OverlaySearchItem> {
  ProductVariantModel? selectedVariant;

  @override
  void initState() {
    super.initState();
    // Do not auto-select first variant as per user request
    selectedVariant = null;
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.product.price ?? 0;
    final variants = widget.product.variants;

    return Container(
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
              child: widget.product.image != null &&
                      widget.product.image!.isNotEmpty
                  ? Image.network(
                      widget.product.image!,
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

          // Product Info - Fixed width
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.color ?? 'color',
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

          const SizedBox(width: 12),
          // Divider
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
          const SizedBox(width: 12),

          // Variants section - Flexible with horizontal scroll
          Expanded(
            child: SizedBox(
              height: 40,
              child: variants.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: variants.map((variant) {
                          final isSelected = selectedVariant?.id == variant.id;
                          return Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: _SelectableVariantChip(
                              text: variant.attribute,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  selectedVariant = variant;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),

          const SizedBox(width: 12),
          // Divider
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
          const SizedBox(width: 12),

          // Price section - Fixed width (equal to button)
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'rent price',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
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

          const SizedBox(width: 12),
          // Add button - Fixed width (equal to price)
          GestureDetector(
            onTap: selectedVariant != null
                ? () => widget.onAddProduct(selectedVariant!)
                : null,
            child: Container(
              width: 90,
              height: 36,
              decoration: BoxDecoration(
                color: selectedVariant != null
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6),
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
          ),
        ],
      ),
    );
  }
}

// Selectable variant chip widget
class _SelectableVariantChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectableVariantChip({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isShortText = text.length <= 3;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isShortText ? 33 : null,
        height: 33,
        padding:
            isShortText ? null : const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isShortText ? null : BorderRadius.circular(8),
          color: isSelected ? AppColors.purpleLight : const Color(0xFFF8F7FF),
          border: Border.all(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
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
  final isShortText = text.length <= 3;

  return Container(
    // Use fixed size for circles, flexible for rectangles
    width: isShortText ? 35 : null,
    height: 33,
    padding: isShortText ? null : const EdgeInsets.symmetric(horizontal: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      // Use circle for short text, rounded rectangle for long text
      shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: isShortText ? null : BorderRadius.circular(8),
      color: Color.fromARGB(255, 225, 215, 255),
      border: Border.all(color: Colors.grey.shade200, width: 0.6),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
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

class _InlinePriceEditor extends StatefulWidget {
  final int initialPrice;
  final ValueChanged<int> onPriceChanged;

  const _InlinePriceEditor({
    required this.initialPrice,
    required this.onPriceChanged,
  });

  @override
  State<_InlinePriceEditor> createState() => _InlinePriceEditorState();
}

class _InlinePriceEditorState extends State<_InlinePriceEditor> {
  bool _isEditing = false;
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialPrice.toString());
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _submitPrice();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _InlinePriceEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPrice != oldWidget.initialPrice && !_isEditing) {
      _controller.text = widget.initialPrice.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitPrice() {
    final newPrice = int.tryParse(_controller.text);
    if (newPrice != null) {
      widget.onPriceChanged(newPrice);
    } else {
      _controller.text = widget.initialPrice.toString();
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return SizedBox(
        width: 80,
        height: 32,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF6132E4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF6132E4)),
            ),
          ),
          onSubmitted: (_) => _submitPrice(),
        ),
      );
    }

    return InkWell(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
        _focusNode.requestFocus();
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.initialPrice.toCurrency(),
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF6132E4)),
          ],
        ),
      ),
    );
  }
}
