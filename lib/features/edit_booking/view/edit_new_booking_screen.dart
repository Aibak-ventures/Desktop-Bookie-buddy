import 'dart:developer';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_other_details_model/booking_other_details_model.dart';

import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/edit_booking/view/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/new_booking_app_bar.dart';
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
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_client/client_cubit.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_staff_search/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_booking/models/additional_charges_model/additional_charges_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/models/sales_request_model/sales_request_model.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_calendar_widget.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/new_booking/view/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/new_booking/models/document_file_model.dart';

import 'package:bookie_buddy_web/features/new_booking/view/widgets/variant_chip.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';

import 'package:bookie_buddy_web/features/sale_details/view/widgets/generate_sale_details_pdf.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
// import 'package:bookie_buddy_web/features/main/cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';

/// Booking types enum for the tab selection
enum BookingType { booking, sales, customWork }

class EditNewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;
  final BookingDetailsModel? bookingDetails;
  final SaleDetailsModel? saleDetails;
  final int? bookingId;

  const EditNewBookingScreen({
    super.key,
    this.onClose,
    this.bookingDetails,
    this.saleDetails,
    this.bookingId,
  });

  @override
  State<EditNewBookingScreen> createState() => EditNewBookingScreenState();
}

class EditNewBookingScreenState extends State<EditNewBookingScreen> {
  // Current selected tab
  BookingType selectedBookingType = BookingType.booking;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Date controllers
  late DateTime pickupDate;
  late DateTime returnDate;
  DateTime? coolingPeriodDate;
  TimeOfDay? coolingPeriodTime;
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
  BookingStatus? bookingStatus; // Track booking status
  String? bookingCompletedDate; // Store completed date
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
  final descriptionController = TextEditingController();

  int? selectedServiceId = -1; // Initialize to -1 for "All Services" as default
  final serviceSearchController = TextEditingController();

  // SelectProductBloc for inline search
  late SelectProductBloc _selectProductBloc;

  // Search overlay management
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;

  // Product search filter state
  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);

  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  // New Fields for Redesign
  int coolingPeriodDays = 1;
  // int coolingPeriodDays = 1;
  // int coolingPeriodDays = 1;
  final runningKilometersController = TextEditingController();

  // Step state
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;
  final startLocationController = TextEditingController();
  final pickupLocationController = TextEditingController();
  final destinationLocationController = TextEditingController();

  // Inline editing state
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();

  // State variables for payment method
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Focus nodes for client details navigation
  final _clientNameFocusNode = FocusNode();
  final _clientPhone1FocusNode = FocusNode();
  final _clientPhone2FocusNode = FocusNode();
  final _clientAddressFocusNode = FocusNode();

  // Original values for change tracking (incremental updates)
  BookingDetailsModel? _originalBooking;
  DateTime? _originalPickupDate;
  DateTime? _originalReturnDate;
  TimeOfDay? _originalPickupTime;
  TimeOfDay? _originalReturnTime;
  String? _originalClientName;
  String? _originalClientPhone1;
  String? _originalClientPhone2;
  String? _originalClientAddress;
  int? _originalStaffId;
  int? _originalAdvanceAmount;
  int? _originalSecurityAmount;
  int? _originalDiscountAmount;
  List<ProductSelectedModel>? _originalProducts;
  List<AdditionalChargesModel>? _originalAdditionalCharges;
  List<DocumentFile>? _originalDocuments; // Track original documents for removal detection

  // Customization state
  bool showCustomization = false;
  ProductSelectedModel? _selectedProductForCustomization;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );

    // Pre-fill data if editing
    if (widget.bookingDetails != null) {
      _initializeFromBooking(widget.bookingDetails!);
    } else if (widget.saleDetails != null) {
      _initializeFromSale(widget.saleDetails!);
    }

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      // Load staffs for staff search dropdown
      context.read<StaffSearchCubit>().getAllStaffs();

      // 🔄 Load available products immediately using check-availability API
      // This ensures only products available for the booking dates are shown
      _loadAvailableProducts();
    });
  }

  /// Initialize form from existing booking
  void _initializeFromBooking(BookingDetailsModel booking) {
    selectedBookingType = BookingType.booking;

    // Set dates
    if (booking.pickupDate != null) {
      pickupDate = booking.pickupDate!.parseToDateTime();
      pickupTime = TimeOfDay.fromDateTime(pickupDate);
    }
    returnDate = booking.returnDate.parseToDateTime();
    returnTime = TimeOfDay.fromDateTime(returnDate);

    if (booking.coolingPeriodDate != null) {
      coolingPeriodDate = booking.coolingPeriodDate!.parseToDateTime();
    }

    // Set client details
    clientNameController.text = booking.client.name;
    clientPhone1Controller.text = booking.client.phone1.toString();
    if (booking.client.phone2 != null) {
      clientPhone2Controller.text = booking.client.phone2.toString();
    }
    if (booking.address != null) {
      clientAddressController.text = booking.address!;
    }
    selectedClientId = booking.client.id;

    // Set staff details
    if (booking.staffName != null) {
      staffNameController.text = booking.staffName!;
    }
    if (booking.staffId != null) {
      selectedStaffId = booking.staffId;
    }

    // Set payment details
    advanceAmountController.text = booking.paidAmount.toString();
    if (booking.securityAmount != null) {
      securityAmountController.text = booking.securityAmount.toString();
    }
    if (booking.discountAmount != null) {
      discountAmountController.text = booking.discountAmount.toString();
    }
    // paymentMethod = booking.p;
    deliveryStatus = booking.deliveryStatus;
    bookingStatus = booking.bookingStatus; // Load booking status
    bookingCompletedDate = booking.bookingCompletedDate; // Load completed date

    // Set description
    if (booking.description != null) {
      descriptionController.text = booking.description!;
    }

    // Set other details (locations & running kilometers)
    if (booking.otherDetails.locationStart != null) {
      startLocationController.text = booking.otherDetails.locationStart!;
    }
    if (booking.otherDetails.locationFrom != null) {
      pickupLocationController.text = booking.otherDetails.locationFrom!;
    }
    if (booking.otherDetails.locationTo != null) {
      destinationLocationController.text = booking.otherDetails.locationTo!;
    }
    if (booking.otherDetails.end != null) {
      runningKilometersController.text = booking.otherDetails.end!;
    }

    // Set products
    log('🔧 Loading ${booking.bookedItems.length} products from booking');
    final products = booking.bookedItems.map((item) {
      log('📦 Product: ${item.name}, Measurements: ${item.measurements.length}');
      return ProductSelectedModel(
        variant: ProductInfoModel(
          id: item.id,
          variantId: item.variantId,
          productId: item.productId,
          name: item.name,
          image: item.image,
          amount: item.amount,
          category: item.category,
          color: item.color,
          model: item.model,
          mainServiceType: item.mainServiceType,
          variantAttribute: item.variantAttribute,
          measurements: item.measurements,
          quantity: item.quantity,
          stock: null,
          remainingStock: null,
        ),
        measurements: item
            .measurements, // CRITICAL: Copy measurements to ProductSelectedModel
        quantity: item.quantity,
        amount: item.amount,
      );
    }).toList();
    log('✅ Loaded ${products.length} products. Products with measurements: ${products.where((p) => p.measurements.isNotEmpty).length}');
    selectedProductsNotifier.value = products;

    // Set additional charges
    additionalChargesNotifier.value = booking.additionalCharges!;

    // Load existing documents for preview
    log('📄 Loading documents from booking. Total documents: ${booking.documents.length}');
    if (booking.documents.isNotEmpty) {
      log('📄 Raw documents data: ${booking.documents}');
      final docs = booking.documents
          .map((doc) {
            if (doc is Map<String, dynamic>) {
              final url = doc['url'] ?? doc['file'] ?? '';
              final name = doc['name'] ?? _extractFilenameFromUrl(url);
              log('📄 Parsed document - Name: $name, URL: $url');
              return DocumentFile(name: name, path: url);
            } else if (doc is String) {
              log('📄 Simple string document: $doc');
              final filename = _extractFilenameFromUrl(doc);
              log('📄 Extracted filename: $filename');
              return DocumentFile(name: filename, path: doc);
            }
            log('⚠️ Unknown document format: $doc');
            return null;
          })
          .whereType<DocumentFile>()
          .toList();
      log('✅ Loaded ${docs.length} documents for preview');
      documentsNotifier.value = docs;
    } else {
      log('ℹ️ No documents found in booking');
    }

    // Store original values for change tracking (incremental updates)
    _storeOriginalValues(booking);
  }

  /// Store original values to track changes for incremental updates
  void _storeOriginalValues(BookingDetailsModel booking) {
    _originalBooking = booking;
    _originalPickupDate = booking.pickupDate?.parseToDateTime();
    _originalReturnDate = booking.returnDate.parseToDateTime();
    _originalPickupTime = booking.pickupDate != null
        ? TimeOfDay.fromDateTime(booking.pickupDate!.parseToDateTime())
        : null;
    _originalReturnTime = TimeOfDay.fromDateTime(booking.returnDate.parseToDateTime());
    
    _originalClientName = booking.client.name;
    _originalClientPhone1 = booking.client.phone1?.toString();
    _originalClientPhone2 = booking.client.phone2?.toString();
    _originalClientAddress = booking.address;
    
    _originalStaffId = booking.staffId;
    
    _originalAdvanceAmount = booking.paidAmount;
    _originalSecurityAmount = booking.securityAmount;
    _originalDiscountAmount = booking.discountAmount;
    
    // Store deep copy of products
    _originalProducts = selectedProductsNotifier.value.map((p) => ProductSelectedModel(
      variant: p.variant,
      measurements: List.from(p.measurements),
      quantity: p.quantity,
      amount: p.amount,
    )).toList();
    
    // Store deep copy of additional charges
    _originalAdditionalCharges = additionalChargesNotifier.value.map((c) => AdditionalChargesModel(
      id: c.id,
      name: c.name,
      amount: c.amount,
    )).toList();

    // Store deep copy of documents
    _originalDocuments = documentsNotifier.value.map((d) => DocumentFile(
      name: d.name,
      path: d.path,
      bytes: d.bytes != null ? List<int>.from(d.bytes!) : null,
    )).toList();

    log('✅ Original values stored for incremental update tracking');
  }

  /// Check if dates have changed
  bool _haveDatesChanged() {
    if (_originalBooking == null) return true; // New booking, send all
    
    final currentPickupDate = pickupDate.format().appendTimeToDate(time: pickupTime);
    final currentReturnDate = returnDate.format().appendTimeToDate(time: returnTime);
    final originalPickupDateStr = _originalPickupDate?.format().appendTimeToDate(time: _originalPickupTime);
    final originalReturnDateStr = _originalReturnDate?.format().appendTimeToDate(time: _originalReturnTime);
    
    return currentPickupDate != originalPickupDateStr || 
           currentReturnDate != originalReturnDateStr;
  }

  /// Check if client details have changed
  bool _hasClientChanged() {
    if (_originalBooking == null) return true;
    
    final currentClientName = clientNameController.text.trim();
    final currentClientPhone1 = clientPhone1Controller.text.trim();
    final currentClientPhone2 = clientPhone2Controller.text.trim();
    final currentClientAddress = clientAddressController.text.trim();
    
    return currentClientName != (_originalClientName ?? '') ||
           currentClientPhone1 != (_originalClientPhone1 ?? '') ||
           currentClientPhone2 != (_originalClientPhone2 ?? '') ||
           currentClientAddress != (_originalClientAddress ?? '');
  }

  /// Check if staff has changed
  bool _hasStaffChanged() {
    if (_originalBooking == null) return true;
    return selectedStaffId != _originalStaffId;
  }

  /// Check if amounts have changed
  bool _haveAmountsChanged() {
    if (_originalBooking == null) return true;
    
    final currentAdvance = advanceAmountController.text.trim().toIntOrNull() ?? 0;
    final currentSecurity = securityAmountController.text.trim().toIntOrNull() ?? 0;
    final currentDiscount = discountAmountController.text.trim().toIntOrNull() ?? 0;
    
    return currentAdvance != (_originalAdvanceAmount ?? 0) ||
           currentSecurity != (_originalSecurityAmount ?? 0) ||
           currentDiscount != (_originalDiscountAmount ?? 0);
  }

  /// Check if products have changed (added, removed, or modified)
  bool _haveProductsChanged() {
    if (_originalBooking == null) return true;
    if (_originalProducts == null) return true;
    
    final currentProducts = selectedProductsNotifier.value;
    
    // Check if count changed
    if (currentProducts.length != _originalProducts!.length) return true;
    
    // Check if any product changed
    for (int i = 0; i < currentProducts.length; i++) {
      final current = currentProducts[i];
      final original = _originalProducts![i];
      
      if (current.variant.id != original.variant.id ||
          current.quantity != original.quantity ||
          current.amount != original.amount ||
          current.measurements.length != original.measurements.length) {
        return true;
      }
    }
    
    return false;
  }

  /// Check if additional charges have changed
  bool _haveAdditionalChargesChanged() {
    if (_originalBooking == null) return true;
    if (_originalAdditionalCharges == null) return true;
    
    final currentCharges = additionalChargesNotifier.value;
    
    // Check if count changed
    if (currentCharges.length != _originalAdditionalCharges!.length) return true;
    
    // Check if any charge changed
    for (int i = 0; i < currentCharges.length; i++) {
      final current = currentCharges[i];
      final original = _originalAdditionalCharges![i];
      
      if (current.name != original.name ||
          current.amount != original.amount) {
        return true;
      }
    }
    
    return false;
  }

  /// Build partial update request with only changed fields
  Map<String, dynamic> _buildPartialUpdateRequest() {
    final updates = <String, dynamic>{};
    
    // Only include dates if changed
    if (_haveDatesChanged()) {
      updates['pickup_date'] = pickupDate.format().appendTimeToDate(time: pickupTime);
      updates['return_date'] = returnDate.format().appendTimeToDate(time: returnTime);
      updates['cooling_period_date'] = returnDate
          .add(Duration(days: coolingPeriodDays))
          .format()
          .appendTimeToDate(time: returnTime);
    }
    
    // Include client entirely if any client field changed
    if (_hasClientChanged()) {
      if (selectedClientId != null) {
        updates['client_id'] = selectedClientId;
      } else {
        // New client
        final phone1 = clientPhone1Controller.text.trim().toIntOrNull();
        final phone2 = clientPhone2Controller.text.trim().toIntOrNull();
        updates['client'] = {
          'name': clientNameController.text.trim().isEmpty
              ? null
              : clientNameController.text.trim(),
          'phone1': phone1,
          'phone2': phone2,
        };
      }
      updates['address'] = clientAddressController.text.trim();
    }
    
    // Include staff if changed
    if (_hasStaffChanged()) {
      updates['staff_id'] = selectedStaffId;
    }
    
    // Include amounts if changed
    if (_haveAmountsChanged()) {
      updates['advance_amount'] = advanceAmountController.text.trim().toIntOrNull();
      updates['security_amount'] = securityAmountController.text.trim().toIntOrNull();
      updates['discount_amount'] = discountAmountController.text.trim().toIntOrNull();
    }
    
    // Include products (variants) if changed
    // Note: API expects 'variants' not 'products'
    if (_haveProductsChanged()) {
      final products = selectedProductsNotifier.value;
      updates['variants'] = products.map((p) => {
        'variant_id': p.variant.variantId,
        'quantity': p.quantity,
        'amount': p.amount,
        'measurements': p.measurements.isNotEmpty ? p.measurements : null,
      }).toList();
    }

    // Include additional charges if changed
    if (_haveAdditionalChargesChanged()) {
      final charges = additionalChargesNotifier.value;
      updates['additional_charges'] = charges.map((c) => {
        'name': c.name,
        'amount': c.amount,
      }).toList();
    }

    // Always include other metadata
    updates['purchase_mode'] = 'normal';
    updates['payment_method'] = paymentMethod.toJson();
    updates['delivery_status'] = deliveryStatus.toValue();
    
    // Include description if present
    final description = descriptionController.text.trim();
    if (description.isNotEmpty) {
      updates['description'] = description;
    }
    
    // Include other details
    updates['other_details'] = {
      'location_start': startLocationController.text.trim().nullIfEmpty,
      'location_from': pickupLocationController.text.trim().nullIfEmpty,
      'location_to': destinationLocationController.text.trim().nullIfEmpty,
      'end': runningKilometersController.text.trim().nullIfEmpty,
    };
    
    log('📝 Partial update payload: $updates');
    return updates;
  }

  /// Extract filename from URL
  String _extractFilenameFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        return segments.last;
      }
    } catch (e) {
      log('⚠️ Error parsing URL: $e');
    }
    return 'Document';
  }

  /// Initialize form from existing sale
  void _initializeFromSale(SaleDetailsModel sale) {
    selectedBookingType = BookingType.sales;

    // Set sale date
    pickupDate = sale.saleDate.parseToDateTime();

    // Set client details
    clientPhone1Controller.text = sale.clientPhone.toString();
    if (sale.address.isNotEmpty) {
      clientAddressController.text = sale.address;
    }

    // Set staff details
    if (sale.staffName != null) {
      staffNameController.text = sale.staffName!;
    }

    // Set payment details
    advanceAmountController.text = sale.paidAmount.toString();
    discountAmountController.text = sale.discountAmount.toString();
    paymentMethod = sale.paymentMethod;

    // Set description
    if (sale.description.isNotEmpty) {
      descriptionController.text = sale.description;
    }

    // Set products
    final products = sale.products.map((item) {
      return ProductSelectedModel(
        variant: ProductInfoModel(
          id: item.id,
          variantId: item.variantId,
          productId: item.productId,
          name: item.name,
          image: item.image,
          amount: item.price,
          category: item.category,
          color: item.color,
          model: item.model,
          mainServiceType: item.mainServiceType,
          variantAttribute: item.variantAttribute ?? '',
          measurements: [],
          quantity: item.quantity,
          stock: null,
          remainingStock: null,
        ),
        quantity: item.quantity,
        amount: item.price,
      );
    }).toList();
    selectedProductsNotifier.value = products;
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();
    startLocationController.dispose();
    pickupLocationController.dispose();
    destinationLocationController.dispose();
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    _clientNameFocusNode.dispose();
    _clientPhone1FocusNode.dispose();
    _clientPhone2FocusNode.dispose();
    _clientAddressFocusNode.dispose();
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
    _selectedSearchTypeIndex.dispose();
    _priceRange.dispose();
    _maxPriceNotifier.dispose();
    _isPriceFilterEnabled.dispose();
    runningKilometersController.dispose();
    super.dispose();
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
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
    if (runningKilometersController.text.trim().isNotEmpty) return true;

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

  /// Validates client details and continues to next step if valid
  void _validateAndContinue() {
    setState(() {
      _clientNameError = null;
      _phoneError = null;
      _staffNameError = null;
    });

    // Get the selected staff from cubit
    final staffState = context.read<StaffSearchCubit>().state;
    final selectedStaff = staffState.selectedStaff;

    final validationResult = BookingValidationHelper.validateClientDetailsPanel(
      clientName: clientNameController.text,
      phone1: clientPhone1Controller.text,
      phone2: clientPhone2Controller.text,
      address: clientAddressController.text,
      documentsCount: documentsNotifier.value.length,
      selectedStaffId: selectedStaff?.id,
      staffName: staffNameController.text,
    );

    if (validationResult.isValid) {
      // Move to next step
      setState(() => _bookingStep = 1);
    } else {
      // Show validation errors
      setState(() {
        _clientNameError = validationResult.fieldErrors['clientName'];
        _phoneError = validationResult.fieldErrors['phone1'];
        _staffNameError = validationResult.fieldErrors['staff'];
      });
      BookingValidationHelper.showValidationErrors(context, validationResult);
    }
  }

  /// Show product filter bottom sheet
  void _showProductFilterBottomSheet() {
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

    // Get services for filter
    final servicesState = context.read<ServiceBloc>().state;
    List<ServicesModel> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    // Setup local state for dialog
    final TextEditingController maxPriceController = TextEditingController();
    final isPriceFilterEnabledWidgetNotifier =
        ValueNotifier(_isPriceFilterEnabled.value);
    final tempSelectedServiceId = ValueNotifier<int?>(selectedServiceId);
    final tempSelectedSearchTypeIndex =
        ValueNotifier<int>(_selectedSearchTypeIndex.value);
    final tempPriceRange = ValueNotifier<RangeValues>(_priceRange.value);

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 700,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6132E4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Color(0xFF6132E4),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Search & Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Selection Section
                      const Text(
                        'Category (Service)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<int?>(
                          valueListenable: tempSelectedServiceId,
                          builder: (context, selectedId, _) {
                            // Combine "All Services" (-1) and actual services
                            final allOptions = [
                              {'id': -1, 'name': 'All Services'},
                              ...services
                                  .map((s) => {'id': s.id, 'name': s.name})
                            ];

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: allOptions.map((option) {
                                final id = option['id'] as int;
                                final name = option['name'] as String;
                                // Map -1 to "null" or keep logic consistent.
                                // Here selectedServiceId stores -1 for "All" or null.
                                // Let's assume -1 for "All".
                                final isSelected = selectedId == id ||
                                    (selectedId == null && id == -1);

                                return InkWell(
                                  onTap: () {
                                    tempSelectedServiceId.value = id;
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF6132E4)
                                            : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Search Type Section
                      const Text(
                        'Search Type',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<int>(
                        valueListenable: tempSelectedSearchTypeIndex,
                        builder: (context, selectedIndex, child) {
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _searchTypes.asMap().entries.map((entry) {
                              final index = entry.key;
                              final type = entry.value;
                              final isSelected = selectedIndex == index;
                              return InkWell(
                                onTap: () =>
                                    tempSelectedSearchTypeIndex.value = index,
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF6132E4)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF6132E4)
                                                  .withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isSelected)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      Text(
                                        type,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Price Filter Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price Range',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                              fontFamily: 'Inter',
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: isPriceFilterEnabledWidgetNotifier,
                            builder: (context, isEnabled, child) =>
                                Transform.scale(
                              scale: 0.85,
                              child: Switch(
                                value: isEnabled,
                                onChanged: (value) {
                                  isPriceFilterEnabledWidgetNotifier.value =
                                      value;
                                },
                                activeThumbColor: const Color(0xFF6132E4),
                                activeTrackColor:
                                    const Color(0xFF6132E4).withOpacity(0.3),
                                inactiveThumbColor: Colors.grey.shade400,
                                inactiveTrackColor: Colors.grey.shade200,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Price Range Content
                      ValueListenableBuilder<bool>(
                        valueListenable: isPriceFilterEnabledWidgetNotifier,
                        builder: (context, isEnabled, child) => AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: isEnabled
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    // Max Price Editor
                                    Row(
                                      children: [
                                        const Text(
                                          'Maximum Price',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6B6B6B),
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        const Spacer(),
                                        ValueListenableBuilder<double>(
                                          valueListenable: _maxPriceNotifier,
                                          builder: (context, currentMaxPrice,
                                              child) {
                                            maxPriceController.text =
                                                currentMaxPrice
                                                    .toInt()
                                                    .toString();
                                            return Container(
                                              width: 130,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF8F9FA),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width: 1,
                                                ),
                                              ),
                                              child: TextField(
                                                controller: maxPriceController,
                                                keyboardType:
                                                    TextInputType.number,
                                                onTapOutside: (_) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Inter',
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  isDense: true,
                                                  prefixText: '₹ ',
                                                  prefixStyle: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF6132E4),
                                                  ),
                                                ),
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    final newMaxPrice =
                                                        double.tryParse(
                                                                value) ??
                                                            currentMaxPrice;
                                                    _maxPriceNotifier.value =
                                                        newMaxPrice;
                                                    if (tempPriceRange
                                                            .value.end >
                                                        newMaxPrice) {
                                                      tempPriceRange.value =
                                                          RangeValues(
                                                              tempPriceRange
                                                                          .value
                                                                          .start >
                                                                      newMaxPrice
                                                                  ? 0
                                                                  : tempPriceRange
                                                                      .value
                                                                      .start,
                                                              newMaxPrice);
                                                    }
                                                  }
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // Price Range Display
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.start.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.end.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Price Range Slider
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) =>
                                          ValueListenableBuilder<double>(
                                        valueListenable: _maxPriceNotifier,
                                        builder:
                                            (context, currentMaxPrice, child) =>
                                                SliderTheme(
                                          data: SliderThemeData(
                                            activeTrackColor:
                                                const Color(0xFF6132E4),
                                            inactiveTrackColor:
                                                Colors.grey.shade200,
                                            thumbColor: const Color(0xFF6132E4),
                                            overlayColor:
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.2),
                                            trackHeight: 4,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                              enabledThumbRadius: 8,
                                            ),
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                              overlayRadius: 16,
                                            ),
                                          ),
                                          child: RangeSlider(
                                            values: range,
                                            min: 0,
                                            max: currentMaxPrice,
                                            divisions: 20,
                                            onChanged: (RangeValues newRange) {
                                              tempPriceRange.value = newRange;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Quick Filters
                                    const Text(
                                      'Quick Filters',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D2D2D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    ValueListenableBuilder<double>(
                                      valueListenable: _maxPriceNotifier,
                                      builder:
                                          (context, currentMaxPrice, child) {
                                        final quickFilters =
                                            _generateQuickFilters(
                                          0,
                                          currentMaxPrice,
                                        );

                                        return Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: quickFilters
                                              .map((filter) =>
                                                  _buildQuickFilterChip(
                                                    filter['label'],
                                                    filter['range'],
                                                    tempPriceRange,
                                                    (val) => tempPriceRange
                                                        .value = val,
                                                  ))
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          tempSelectedSearchTypeIndex.value = 0;
                          tempSelectedServiceId.value = -1;
                          tempPriceRange.value =
                              RangeValues(0, _maxPriceNotifier.value);
                          isPriceFilterEnabledWidgetNotifier.value = false;
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          // Apply changes
                          setState(() {
                            selectedServiceId = tempSelectedServiceId.value;
                            _selectedSearchTypeIndex.value =
                                tempSelectedSearchTypeIndex.value;
                            _priceRange.value = tempPriceRange.value;
                            _isPriceFilterEnabled.value =
                                isPriceFilterEnabledWidgetNotifier.value;
                          });

                          Navigator.of(context).pop();

                          // Trigger Application
                          _applyProductFilters(
                            _selectedSearchTypeIndex.value,
                            _priceRange.value,
                            _isPriceFilterEnabled.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF6132E4),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: const Color(0xFF6132E4).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Apply Filters',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
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

  // Helper function to round numbers to meaningful values
  double _roundToMeaningfulNumber(double value) {
    if (value < 100) {
      return (value / 10).round() * 10.0;
    } else if (value < 1000) {
      return (value / 100).round() * 100.0;
    } else if (value < 10000) {
      return (value / 1000).round() * 1000.0;
    } else {
      return (value / 5000).round() * 5000.0;
    }
  }

  // Helper function to generate dynamic quick filters based on max price
  List<Map<String, dynamic>> _generateQuickFilters(
      double minPrice, double maxPrice) {
    final List<Map<String, dynamic>> filters = [];

    // Calculate dynamic ranges based on maxPrice
    double range1 = maxPrice * 0.1; // 10% of max
    double range2 = maxPrice * 0.25; // 25% of max
    double range3 = maxPrice * 0.5; // 50% of max
    double range4 = maxPrice * 0.75; // 75% of max

    // Round to nearest meaningful number
    range1 = _roundToMeaningfulNumber(range1);
    range2 = _roundToMeaningfulNumber(range2);
    range3 = _roundToMeaningfulNumber(range3);
    range4 = _roundToMeaningfulNumber(range4);

    // Ensure ranges are distinct and meaningful
    if (range1 > minPrice && range1 < maxPrice) {
      filters.add({
        'label': 'Under ${range1.toCurrency()}',
        'range': RangeValues(minPrice, range1),
      });
    }

    if (range2 > range1 && range2 < maxPrice) {
      filters.add({
        'label': '${range1.toCurrency()} - ${range2.toCurrency()}',
        'range': RangeValues(range1, range2),
      });
    }

    if (range3 > range2 && range3 < maxPrice) {
      filters.add({
        'label': '${range2.toCurrency()} - ${range3.toCurrency()}',
        'range': RangeValues(range2, range3),
      });
    }

    if (range4 > range3 && range4 < maxPrice) {
      filters.add({
        'label': '${range3.toCurrency()} - ${range4.toCurrency()}',
        'range': RangeValues(range3, range4),
      });
    }

    // Always add "Above X" filter
    if (range4 < maxPrice) {
      filters.add({
        'label': 'Above ${range4.toCurrency()}',
        'range': RangeValues(range4, maxPrice),
      });
    }

    // Fallback: if no meaningful ranges, create simple divisions
    if (filters.isEmpty) {
      final quarter = (maxPrice - minPrice) / 4;
      filters.addAll([
        {
          'label': 'Under ${(minPrice + quarter).toCurrency()}',
          'range': RangeValues(minPrice, minPrice + quarter),
        },
        {
          'label':
              '${(minPrice + quarter).toCurrency()} - ${(minPrice + 2 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + quarter, minPrice + 2 * quarter),
        },
        {
          'label':
              '${(minPrice + 2 * quarter).toCurrency()} - ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 2 * quarter, minPrice + 3 * quarter),
        },
        {
          'label': 'Above ${(minPrice + 3 * quarter).toCurrency()}',
          'range': RangeValues(minPrice + 3 * quarter, maxPrice),
        },
      ]);
    }

    return filters;
  }

  Widget _buildQuickFilterChip(
    String label,
    RangeValues range,
    ValueNotifier<RangeValues> currentRange,
    void Function(RangeValues) onChanged,
  ) =>
      ValueListenableBuilder<RangeValues>(
        valueListenable: currentRange,
        builder: (context, current, child) {
          final isSelected =
              current.start == range.start && current.end == range.end;

          return GestureDetector(
            onTap: () {
              currentRange.value = range;
              onChanged(range);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF6132E4) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF6132E4)
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      );

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

  void _onSearchChanged() {
    // Allow search even if selectedServiceId is null (All Services)
    final query = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
            ? null
            : selectedServiceId;

    final hasFilters =
        _isPriceFilterEnabled.value || _selectedSearchTypeIndex.value != 0;

    if (query.isEmpty && !hasFilters) {
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
          serviceId: serviceIdToUse,
          query: query.isEmpty ? null : query,
          type: searchType,
          startPrice: _isPriceFilterEnabled.value
              ? _priceRange.value.start.toInt()
              : null,
          endPrice: _isPriceFilterEnabled.value
              ? _priceRange.value.end.toInt()
              : null,
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
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: Container(
          height: screenHeight,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Edit booking app bar
                EditBookingAppBar(
                  onSave: _handleSaveBooking,
                  bookingId: widget.bookingId ??
                      widget.bookingDetails?.id ??
                      widget.saleDetails?.id ??
                      0,
                  bookingType: selectedBookingType.name,
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
      ),
    );
  }

  BookingTabType _convertBookingTypeToTabType(BookingType type) {
    switch (type) {
      case BookingType.booking:
        return BookingTabType.booking;
      case BookingType.sales:
        return BookingTabType.sales;
      case BookingType.customWork:
        return BookingTabType.customWork;
    }
  }

  BookingType _convertTabTypeToBookingType(BookingTabType tabType) {
    switch (tabType) {
      case BookingTabType.booking:
        return BookingType.booking;
      case BookingTabType.sales:
        return BookingType.sales;
      case BookingTabType.customWork:
        return BookingType.customWork;
    }
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
            onTap: _handleBackNavigation,
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
      case BookingType.customWork:
        return 'Custom Work';
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
      onTap: () => _handleTabSwitch(type),
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
            fontSize: 13,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    if (selectedBookingType == BookingType.customWork) {
      return Container(
        child: Center(
          child: Text('Custom Work - Coming Soon'),
        ),
      );
    }
    // Same UI for both booking and sales
    return _buildBookingContent();
  }

// BOOKING & SALES - Same UI with conditional fields
  Widget _buildBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Side: Dates + Products OR Customization
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateSelectionSection(),
              const SizedBox(height: 16),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeInOut,
                  switchOutCurve: Curves.easeInOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    // Product search slides left, customization slides in from right
                    final offsetAnimation = Tween<Offset>(
                      begin: child.key == const ValueKey('customization')
                          ? const Offset(1.0, 0.0) // Slide from right
                          : const Offset(-1.0, 0.0), // Slide to left
                      end: Offset.zero,
                    ).animate(animation);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                  child: showCustomization
                      ? ProductCustomizationWidget(
                          key: const ValueKey('customization'),
                          onBack: () {
                            setState(() {
                              showCustomization = false;
                            });
                          },
                          onSaveForProduct: (product, measurements) {
                            setState(() {
                              // Find and update the specific product with measurements
                              final index =
                                  selectedProductsNotifier.value.indexWhere(
                                (p) =>
                                    p.variant.variantId ==
                                    product.variant.variantId,
                              );
                              if (index != -1) {
                                final updatedProducts =
                                    List<ProductSelectedModel>.from(
                                  selectedProductsNotifier.value,
                                );
                                updatedProducts[index] = product.copyWith(
                                  measurements: measurements,
                                );
                                selectedProductsNotifier.value =
                                    updatedProducts;
                              }
                            });
                          },
                          selectedProducts: selectedProductsNotifier.value,
                        )
                      : Container(
                          key: const ValueKey('products'),
                          child: _buildServiceSelectionSection(),
                        ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // Right panel: Client, Docs, Staff
        SizedBox(
          width: 340,
          child: _buildRightSidePanel(),
        ),
      ],
    );
  }

  /// Shows a confirmation dialog specifically for shop switching
  Future<bool?> _showShopSwitchConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 450,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 40,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.store_rounded,
                        color: Color(0xFF1976D2),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch Shop?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                              fontFamily: 'Inter',
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Current progress will be lost',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1565C0),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Are you sure you want to switch your shop? All selected products, measurements, and started booking details will be discarded.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF4A4A4A),
                        fontFamily: 'Inter',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context, false),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                  color: Colors.grey.shade300, width: 1.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: const Color(0xFF2196F3),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text(
                              'Switch & Discard',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
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
      // 🔄 Reload available products for the new date range
      _loadAvailableProducts();
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
      // 🔄 Reload available products for the new time
      _loadAvailableProducts();
    }
  }

  /// Load available products using the check-availability API.
  /// Called on screen entry and whenever pickup/return date or time changes.
  void _loadAvailableProducts() {
    final isSales = selectedBookingType == BookingType.sales;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
            ? null
            : selectedServiceId;
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

  Widget _buildSalesDateSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          // Single date field for sales
          InkWell(
            onTap: () => _selectDate(isPickup: true),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    pickupDate.format(),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
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

  Widget _buildLeftTopSection() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: _bookingStep == 0 ? _buildStepOne() : _buildStepTwo(),
    );
  }

  Widget _buildStepOne() {
    return SizedBox(
      key: const ValueKey(0),
      child: Column(
        children: [
          // Calendar + date time (already compact)
          SizedBox(
            height: selectedBookingType == BookingType.sales ? 460 : 490,
            child: BookingCalendarWidget(
              staffNameController: staffNameController,
              clientNameController: clientNameController,
              clientPhone1Controller: clientPhone1Controller,
              clientPhone2Controller: clientPhone2Controller,
              clientAddressController: clientAddressController,
              descriptionController: descriptionController,
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
              coolingPeriodTime: coolingPeriodTime,
              onPickupDateChanged: (d) => setState(() => pickupDate = d),
              onReturnDateChanged: (d) => setState(() => returnDate = d),
              onCoolingPeriodDateChanged: (d) =>
                  setState(() => coolingPeriodDate = d),
              onPickupTimeChanged: (t) => setState(() => pickupTime = t),
              onReturnTimeChanged: (t) => setState(() => returnTime = t),
              onCoolingPeriodTimeChanged: (t) =>
                  setState(() => coolingPeriodTime = t),
              isSalesMode: selectedBookingType == BookingType.sales,
              clientNameError: _clientNameError,
              staffNameError: _staffNameError,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _clientNameError = clientNameController.text.trim().isEmpty
                      ? 'Client name is required'
                      : null;
                  _staffNameError = staffNameController.text.trim().isEmpty
                      ? 'Staff is required'
                      : null;
                });

                final isFormValid = _formKey.currentState?.validate() ?? false;
                if (isFormValid &&
                    _clientNameError == null &&
                    _staffNameError == null) {
                  setState(() => _bookingStep = 1);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6132E4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text('Continue',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepTwo() {
    return Container(
      key: const ValueKey(1),
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
          // Back Button + Header
          Row(
            children: [
              InkWell(
                onTap: () => setState(() => _bookingStep = 0),
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.arrow_back,
                      size: 20, color: Colors.grey.shade700),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Complete Booking',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Locations (Optional) - Only for Vehicles
          ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              final hasVehicles = products.any(
                (p) => p.variant.mainServiceType?.isVehicle ?? false,
              );
              if (!hasVehicles) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStepSectionHeader('Locations', optional: true),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildSimpleTextField(
                      startLocationController, 'Start location'),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildSimpleTextField(
                      pickupLocationController, 'Pickup location'),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildSimpleTextField(
                      destinationLocationController, 'Destination'),
                  const SizedBox(height: _fieldSpacing),
                ],
              );
            },
          ),

          // Payment details (Optional)
          _buildStepSectionHeader('Payment details', optional: true),
          const SizedBox(height: 12),
          BookingTextFieldBuilder.buildSimpleTextField(
              advanceAmountController, 'Advance amount',
              isNumber: true),
          const SizedBox(height: 12),
          BookingTextFieldBuilder.buildSimpleTextField(
              securityAmountController, 'Security amount',
              isNumber: true),
          const SizedBox(height: 12),
          BookingTextFieldBuilder.buildSimpleTextField(
              discountAmountController, 'Discount amount',
              isNumber: true),

          const SizedBox(height: 24),
          _buildStepSectionHeader('Payment Method'),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildPaymentMethodOption(PaymentMethod.cash, Icons.money),
              const SizedBox(width: 12),
              _buildPaymentMethodOption(PaymentMethod.gPay, Icons.qr_code),
            ],
          ),

          const SizedBox(height: 24),

          // Additional Charges
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Additional charges',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              InkWell(
                onTap: _addAdditionalCharge,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6132E4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child:
                      const Icon(Icons.add, size: 16, color: Color(0xFF6132E4)),
                ),
              ),
            ],
          ),
          // Additional charges list (if any)
          ValueListenableBuilder<List<AdditionalChargesModel>>(
            valueListenable: additionalChargesNotifier,
            builder: (context, charges, _) {
              if (charges.isEmpty) return const SizedBox();
              return Column(
                children: charges
                    .map((c) => Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Row(
                            children: [
                              Text(c.name ?? '',
                                  style: const TextStyle(fontSize: 12)),
                              const Spacer(),
                              Text('₹${c.amount}',
                                  style: const TextStyle(fontSize: 12)),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _removeCharge(c),
                                child: Icon(Icons.close,
                                    size: 14, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),

          // const SizedBox(height: 7),

          // Summary Section
          _buildFinalSummary(),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showCustomization = true;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Add customization',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleSaveBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6132E4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepSectionHeader(String title, {bool optional = false}) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        if (optional) ...[
          const SizedBox(width: 4),
          Text(
            '(optional)',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStepTwoSummary() {
    return ValueListenableBuilder<List<ProductSelectedModel>>(
      valueListenable: selectedProductsNotifier,
      builder: (context, products, _) {
        final productTotal = products.fold<int>(
            0, (sum, item) => sum + (item.amount * item.quantity));
        final additional = additionalChargesNotifier.value.fold<double>(
            0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

        final advance = double.tryParse(advanceAmountController.text) ?? 0;
        final discount = double.tryParse(discountAmountController.text) ?? 0;

        final totalPayable = productTotal + additional - advance - discount;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F4FF), // Light purple bg
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFEBE5FF)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Product total',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2D2D2D),
                          fontWeight: FontWeight.w500)),
                  Text('₹${productTotal.toCurrency()}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A))),
                ],
              ),
              if (additional > 0) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Additional charges',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2D2D2D),
                            fontWeight: FontWeight.w500)),
                    Text('₹${additional.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A))),
                  ],
                ),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: Color(0xFFE0D9FF)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Paid',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF2D2D2D),
                          fontWeight: FontWeight.w500)),
                  Text('₹${advance.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF27AE60))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total payable',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF1A1A1A),
                          fontWeight: FontWeight.w600)),
                  Text('₹${totalPayable.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFEB5757))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildServiceSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to left
        children: [
          ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              return Text('Select Products (${products.length})',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800));
            },
          ),
          const SizedBox(height: 5),
          _buildProductSearchBar(),
          const SizedBox(height: 5),
          Expanded(child: _buildSelectedProductsTable()),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(PaymentMethod method, IconData icon) {
    final isSelected = _selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = method),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? const Color(0xFF6132E4).withOpacity(0.05)
                : Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color:
                    isSelected ? const Color(0xFF6132E4) : Colors.grey.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                method.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected
                      ? const Color(0xFF6132E4)
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
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
            _buildPaymentMethodOption(PaymentMethod.gPay, Icons.qr_code),
            const SizedBox(width: 8),
            _buildPaymentMethodOption(PaymentMethod.cash, Icons.money),
          ],
        ),
      ],
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
                  // Search TextField
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
                      onPressed: () {
                        _removeSearchOverlay();
                        _showProductFilterBottomSheet();
                      },
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

  void _showSearchOverlay(List<ProductModel> products) {
    _removeSearchOverlay();

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 1000,
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
          stock: variant.stock,
          remainingStock: variant.remainingStock,
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
                        return variantChip(variant);
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

        // Find the selected variant to get stock info
        final selectedVariant = variants.firstWhere(
          (v) => v.id == id,
          orElse: () => variants.first,
        );

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
              stock: selectedVariant.stock,
              remainingStock: selectedVariant.remainingStock,
            ),
            quantity: quantity,
            amount: amount.toInt(),
          ));
        }

        selectedProductsNotifier.value = products;
      },
    );
  }

  /// Check if any selected product has variant attributes to display
  bool _hasAnyProductWithVariants() {
    final products = selectedProductsNotifier.value;
    return products.any((product) {
      final mainServiceType = product.variant.mainServiceType;
      // Only show variants column if product is multi-variant type and has variant attribute
      return mainServiceType.isMultiVariantProductType &&
          (product.variant.variantAttribute?.isNotEmpty ?? false);
    });
  }

  /// Calculate rental days between booking and return dates
  int _calculateRentalDays() {
    if (pickupDate == returnDate) return 1;
    final difference = returnDate.difference(pickupDate).inDays;
    return difference > 0 ? difference : 1;
  }

  Widget _buildProductListHeader() {
    final isSales = selectedBookingType == BookingType.sales;
    final hasVariants = _hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildHeaderCell('items', alignLeft: true),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: _buildHeaderCell('Specifications'),
          ),
          const SizedBox(width: 4),
          if (hasVariants) ...[
            Expanded(child: _buildHeaderCell('Variants')),
            const SizedBox(width: 4),
          ],
          if (!isSales) ...[
            Expanded(child: _buildHeaderCell('Days')),
            const SizedBox(width: 4),
          ],
          Expanded(child: _buildHeaderCell('Available')),
          const SizedBox(width: 4),
          Expanded(child: _buildHeaderCell('Quantity')),
          const SizedBox(width: 4),
          Expanded(child: _buildHeaderCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(child: _buildHeaderCell('Total')),
          const SizedBox(width: 50), // Matches row close button area
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, {bool alignLeft = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9), // Very light grey from image
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
      ),
      alignment: alignLeft ? Alignment.centerLeft : Alignment.center,
      child: Padding(
        padding: alignLeft
            ? const EdgeInsets.only(left: 12)
            : const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3436),
          ),
          overflow: TextOverflow.ellipsis,
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
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 48, color: Colors.grey.shade200),
                  const SizedBox(height: 16),
                  Text(
                    'No items selected',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select a service and click on products to add them',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) => _buildProductRow(products[index]),
        );
      },
    );
  }

  Widget _buildProductRow(ProductSelectedModel product) {
    final isSales = selectedBookingType == BookingType.sales;
    final rentalDays = !isSales ? _calculateRentalDays() : 0;
    final hasVariants = _hasAnyProductWithVariants();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          // Item Name & Image
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Image
                Container(
                  width: 48,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    image: product.variant.image != null &&
                            product.variant.image!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.variant.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.variant.image == null ||
                          product.variant.image!.isEmpty
                      ? const Icon(Icons.image_not_supported,
                          size: 20, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
                // Product Name only
                Expanded(
                  child: Text(
                    product.variant.name ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3436),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // Specifications (color, category, model)
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                [
                  product.variant.color,
                  product.variant.category,
                  product.variant.model,
                ].where((e) => e != null && e.isNotEmpty).take(2).join(', '),
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Variants - Only shown if any product has variants
          if (hasVariants) ...[
            Expanded(
              child: Center(
                child: Text(
                  (product.variant.variantAttribute?.isNotEmpty ?? false)
                      ? product.variant.variantAttribute!
                      : '-',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          // Days - Only for rentals (not sales)
          if (!isSales) ...[
            Expanded(
              child: Center(
                child: Text(
                  '$rentalDays',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          // Available Badge
          Expanded(
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1C1FD300),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27AE60),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${product.variant.remainingStock ?? product.variant.stock} left',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF27AE60),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Quantity Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuantityBtn(
                    icon: Icons.remove,
                    onTap: () => _decrementQuantity(product)),
                const SizedBox(width: 6),
                Text(
                  '${product.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 6),
                _buildQuantityBtn(
                    icon: Icons.add, onTap: () => _incrementQuantity(product)),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // Price / item
          Expanded(
            child: _editingVariantId == product.variant.variantId
                ? Center(
                    child: Container(
                      width: 80,
                      height: 32,
                      child: TextField(
                        controller: _inlinePriceController,
                        focusNode: _inlinePriceFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xFF6132E4)),
                          ),
                        ),
                        onSubmitted: (_) => _saveEditingPrice(product),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => _startEditingPrice(product),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.amount}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2D3436),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.edit_outlined,
                            size: 16, color: const Color(0xFF6132E4)),
                      ],
                    ),
                  ),
          ),
          const SizedBox(width: 4),
          // Total
          Expanded(
            child: Center(
              child: Text(
                '${product.amount * product.quantity}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3436),
                ),
              ),
            ),
          ),
          // Remove
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.close, size: 20, color: Colors.black87),
              onPressed: () => _removeProduct(product),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 27,
        height: 22,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF), // Light purple bg
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF6132E4)),
      ),
    );
  }

  /// Increment quantity of a product with stock validation
  void _incrementQuantity(ProductSelectedModel product) {
    // Check available stock using remainingStock with fallback to stock
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 0;
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

  void _startEditingPrice(ProductSelectedModel product) {
    setState(() {
      _editingVariantId = product.variant.variantId;
      _inlinePriceController.text = product.amount.toString();
      // Schedule focus request for next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _inlinePriceFocusNode.requestFocus();
      });
    });
  }

  void _saveEditingPrice(ProductSelectedModel product) {
    if (_editingVariantId == null) return;

    final newPrice = int.tryParse(_inlinePriceController.text);
    if (newPrice != null) {
      _updateProductPrice(product, newPrice);
    }

    setState(() {
      _editingVariantId = null;
      _inlinePriceController.clear();
      _inlinePriceFocusNode.unfocus();
    });
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
                  // Hide advance amount in edit mode
                  // if (!isSalesMode) ...[
                  //   BookingTextFieldBuilder.buildCompactAmountField(
                  //     controller: advanceAmountController,
                  //     label: 'Advance Amount (optional)',
                  //   ),
                  //   const SizedBox(height: 8),
                  // ],
                  if (!isSalesMode) ...[
                    BookingTextFieldBuilder.buildCompactAmountField(
                      controller: securityAmountController,
                      label: 'Security Amount (optional)',
                    ),
                    const SizedBox(height: 8),
                  ],
                  BookingTextFieldBuilder.buildCompactAmountField(
                    controller: discountAmountController,
                    label: 'Discount Amount (optional)',
                  ),
                  const SizedBox(height: 10),
                  // Additional charges - hide in sales mode
                  if (!isSalesMode) ...[
                    _buildAdditionalChargesSection(),
                    const SizedBox(height: 10),
                  ],
                  // Payment method - Hidden in edit mode
                  // _buildPaymentMethodSection(),
                  // const SizedBox(height: 3),
                  // Delivery status
                  if (!isSalesMode) _buildDeliveryStatusSection(),
                  const SizedBox(height: 3),
                  // _buildPaymentMethodSection(),
                  const SizedBox(height: 3),
                  if (!isSalesMode) ...[
                    BookingDocumentUploadSection(
                      documentsNotifier: documentsNotifier,
                    ),
                    // const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Summary section
        // Row(
        //   children: [
        //     const SizedBox(width: 6),
        //     const Text(
        //       'Summary',
        //       style: TextStyle(
        //         fontSize: 14,
        //         fontFamily: 'Inter',
        //         fontWeight: FontWeight.w500,
        //         color: Color(0xFF3E3E3E),
        //       ),
        //     ),
        //   ],
        // ),
        _buildSummarySection(),
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

  Widget _buildDeliveryStatusSection() {
    // Check if booking is completed or cancelled - disable editing
    final isBookingFinalized = bookingStatus == BookingStatus.completed ||
        bookingStatus == BookingStatus.cancelled;

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
            color: isBookingFinalized ? Colors.grey.shade100 : Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DeliveryStatus>(
              value: deliveryStatus,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  size: 18,
                  color: isBookingFinalized
                      ? Colors.grey.shade400
                      : Colors.grey.shade600),
              style: TextStyle(
                fontSize: 13,
                color:
                    isBookingFinalized ? Colors.grey.shade500 : Colors.black87,
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
              onChanged: isBookingFinalized
                  ? null
                  : (value) {
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
        color: Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
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
                ],
              );
            },
          ),
          // const SizedBox(height: 3),

          // const SizedBox(height: 3),
          // Add/Edit customization button - Only for Dresses
          ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              final hasDresses = products.any(
                (p) => p.variant.mainServiceType?.isDress ?? false,
              );
              if (!hasDresses) return const SizedBox.shrink();

              // Check if any dress product already has measurements (customizations)
              final hasCustomizations = products.any(
                (p) =>
                    (p.variant.mainServiceType?.isDress ?? false) &&
                    p.measurements.isNotEmpty,
              );

              return SizedBox(
                width: double.infinity,
                height: 39,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      showCustomization = true;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: hasCustomizations
                        ? const Color(0xFFF3F0FF)
                        : Colors.transparent,
                    foregroundColor: hasCustomizations
                        ? const Color(0xFF6132E4)
                        : Colors.grey.shade700,
                    side: BorderSide(
                      color: hasCustomizations
                          ? const Color(0xFF6132E4)
                          : Colors.grey.shade600,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        hasCustomizations ? Icons.edit_outlined : Icons.add,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        hasCustomizations
                            ? 'Edit customisation'
                            : 'Add customization (Optional)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          // Show completed/cancelled status info
          if (bookingStatus == BookingStatus.completed &&
              bookingCompletedDate != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF4CAF50)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Color(0xFF4CAF50), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Booking Completed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                        Text(
                          'Completed on: $bookingCompletedDate',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else if (bookingStatus == BookingStatus.cancelled)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFF44336)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cancel, color: Color(0xFFF44336), size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Booking Cancelled',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFC62828),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            // Confirm button - Only show for non-completed/cancelled bookings
            SizedBox(
              width: double.infinity,
              height: 39,
              child: ElevatedButton(
                onPressed: _handleSaveBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6132E4),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Changes',
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

  /// Handle save booking for edit mode
  Future<void> _handleSaveBooking() async {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    // Show loading
    GlobalLoadingOverlay.show(context);

    try {
      final repository = getIt<BookingRepository>();

      if (widget.bookingDetails != null) {
        // Update existing booking with incremental changes only
        final partialUpdate = _buildPartialUpdateRequest();
        
        // Detect document changes
        final currentDocs = documentsNotifier.value;
        final originalDocPaths = _originalDocuments?.map((d) => d.path).toSet() ?? {};
        final currentDocPaths = currentDocs.map((d) => d.path).toSet();
        
        // Find removed documents (were in original but not in current)
        final removedUrls = originalDocPaths.difference(currentDocPaths).toList();
        
        // Find new documents (have bytes = newly uploaded)
        final newDocs = currentDocs.where((d) => d.bytes != null).toList();
        
        log('📄 Document changes - New: ${newDocs.length}, Removed: ${removedUrls.length}');
        
        await repository.updateBookingPartial(
          widget.bookingDetails!.id,
          partialUpdate,
          newDocuments: newDocs.isNotEmpty ? newDocs : null,
          removedDocumentUrls: removedUrls.isNotEmpty ? removedUrls : null,
        );
        GlobalLoadingOverlay.hide();
        if (mounted) {
          context.showSnackBar('Booking updated successfully!');
          if (widget.onClose != null) {
            widget.onClose!();
          } else {
            Navigator.of(context).pop();
          }
        }
      } else if (widget.saleDetails != null) {
        // Update existing sale
        final salesRequest = _buildSalesRequest();
        await getIt<SalesRepository>().updateSale(salesRequest);
        GlobalLoadingOverlay.hide();
        if (mounted) {
          context.showSnackBar('Sale updated successfully!');
          if (widget.onClose != null) {
            widget.onClose!();
          } else {
            Navigator.of(context).pop();
          }
        }
      }
    } catch (e) {
      GlobalLoadingOverlay.hide();
      if (mounted) {
        context.showSnackBar('Failed to save: ${e.toString()}', isError: true);
      }
      log('Error saving: $e');
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
        final saleId = await repository.createSale(salesRequest.toJson());

        // Close loading dialog
        if (mounted) Navigator.of(context).pop();

        // Show success message or dialog
        if (mounted) {
          if (saleId != 0) {
            _showSuccessDialog(saleId, BookingType.sales);
          } else {
            context.showSnackBar('Sale created successfully!');
            // Navigate back or close
            if (widget.onClose != null) {
              widget.onClose!();
            } else {
              Navigator.of(context).pop();
            }
          }
        }
      } else {
        // Build booking request
        final bookingRequest = _buildBookingRequest();
        log('Booking Request: ${bookingRequest.toJson()}');

        // Call the API to create booking
        final bookingId = await repository.addBooking(bookingRequest);

        // Close loading dialog
        if (mounted) Navigator.of(context).pop();

        // Show success message or dialog
        if (mounted) {
          if (bookingId != 0) {
            _showSuccessDialog(bookingId, BookingType.booking);
          } else {
            context.showSnackBar('Booking created successfully!');
            // Navigate back or close
            if (widget.onClose != null) {
              widget.onClose!();
            } else {
              Navigator.of(context).pop();
            }
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
      // Calculate cooling period date from return date + days
      coolingPeriodDate: returnDate
          .add(Duration(days: coolingPeriodDays))
          .format()
          .appendTimeToDate(time: returnTime),
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
      otherDetails: BookingOtherDetailsModel(
        locationStart: startLocationController.text.trim().nullIfEmpty,
        locationFrom: pickupLocationController.text.trim().nullIfEmpty,
        locationTo: destinationLocationController.text.trim().nullIfEmpty,
        end: runningKilometersController.text.trim().nullIfEmpty,
      ),
    );
  }

  /// Build sales request for creating/updating a sale
  SalesRequestModel _buildSalesRequest() {
    final products = selectedProductsNotifier.value;

    // Use phone1 as client_phone
    final clientPhone = clientPhone1Controller.text.trim();

    return SalesRequestModel(
      id: widget.saleDetails?.id,
      staffId: selectedStaffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      address: clientAddressController.text.trim().isEmpty
          ? null
          : clientAddressController.text.trim(),
      saleDate: pickupDate.format(), // Use pickup date as sale date
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      products: products,
      paidAmount: advanceAmountController.text.trim().toIntOrNull() ?? 0,
      paymentMethod: paymentMethod,
      discountAmount: discountAmountController.text.trim().toIntOrNull() ?? 0,
      stockCountDecrease: false,
    );
  }

  Widget _buildDateSelectionSection() {
    final isSales = selectedBookingType == BookingType.sales;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isSales ? 'Sale date' : 'Select dates',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 7),
          if (isSales)
            // Sales mode - single date only
            SizedBox(
              width: 400,
              child: _buildNewDateField(
                label: 'Sale date',
                value: pickupDate.format(),
                onTap: () => _selectDate(isPickup: true),
              ),
            )
          else
            // Booking mode - pickup and return dates
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Pickup Date
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: () => _selectDate(isPickup: true),
                  ),
                ),
                const SizedBox(width: 12),
                // Pickup Time
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    label: 'time',
                    value: pickupTime?.format(context) ?? '--:--',
                    onTap: () => _selectTime(isPickup: true),
                  ),
                ),
                const SizedBox(width: 24),

                // Return Date
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                  ),
                ),
                const SizedBox(width: 12),
                // Return Time
                Expanded(
                  flex: 2,
                  child: _buildNewTimeField(
                    label: 'time',
                    value: returnTime?.format(context) ?? '--:--',
                    onTap: () => _selectTime(isPickup: false),
                  ),
                ),

                const SizedBox(width: 24),

                // Cooling Period (Days)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cooling period',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: coolingPeriodDays,
                            isExpanded: true,
                            icon:
                                const Icon(Icons.keyboard_arrow_down, size: 18),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                            items: List.generate(10, (index) {
                              final days = index + 1;
                              return DropdownMenuItem(
                                value: days,
                                child: Text('$days day${days > 1 ? 's' : ''}'),
                              );
                            }),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => coolingPeriodDays = val);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNewDateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FC),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: const Color(0xFF9A76E8)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTimeField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9FC),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightSidePanel() {
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
                  const SizedBox(height: _fieldSpacing),

                  // Name
                  // ClientName with Search
                  BlocListener<ClientCubit, ClientState>(
                    listener: (context, state) {
                      if (state.selectedClient != null) {
                        final client = state.selectedClient!;
                        // Auto-fill fields
                        clientNameController.text = client.name;
                        clientPhone1Controller.text = client.phone1.toString();
                        if (client.phone2 != null) {
                          clientPhone2Controller.text =
                              client.phone2.toString();
                        }
                        // Store selected client ID
                        selectedClientId = client.id;
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: clientNameController,
                      focusNode: _clientNameFocusNode,
                      hitText: 'Search client by name',
                      onClear: () {
                        // Clear all client fields when search is cleared
                        clientNameController.clear();
                        clientPhone1Controller.clear();
                        clientPhone2Controller.clear();
                        clientAddressController.clear();
                        selectedClientId = null;
                      },
                      errorText: _clientNameError,
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Phone - Disabled if client is selected
                  BlocBuilder<ClientCubit, ClientState>(
                    builder: (context, state) {
                      final isClientSelected = state.selectedClient != null;
                      return BookingTextFieldBuilder.buildRightPanelTextField(
                        controller: clientPhone1Controller,
                        hint: 'Phone',
                        isNumber: true,
                        focusNode: _clientPhone1FocusNode,
                        nextFocusNode: _clientPhone2FocusNode,
                        enabled: !isClientSelected,
                        errorText: _phoneError,
                      );
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Phone 2 - Disabled if client is selected
                  BlocBuilder<ClientCubit, ClientState>(
                    builder: (context, state) {
                      final isClientSelected = state.selectedClient != null;
                      return BookingTextFieldBuilder.buildRightPanelTextField(
                        controller: clientPhone2Controller,
                        hint: 'Phone 2',
                        isNumber: true,
                        focusNode: _clientPhone2FocusNode,
                        nextFocusNode: _clientAddressFocusNode,
                        enabled: !isClientSelected,
                      );
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: null, // Last field
                  ),

                  const SizedBox(height: _fieldSpacing),
                  const SizedBox(height: 16),
                  // WhatsApp Checkbox - Hidden in edit mode
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 24,
                  //       height: 24,
                  //       child: Checkbox(
                  //         value: sendPdfToWhatsApp,
                  //         onChanged: (v) =>
                  //             setState(() => sendPdfToWhatsApp = v ?? false),
                  //         activeColor: Colors.black87,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(4)),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 8),
                  //     Text(
                  //       'Send invoice to whatsapp',
                  //       style: TextStyle(
                  //         fontSize: 13,
                  //         color: Colors.grey.shade600,
                  //         fontFamily: 'Inter',
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // const SizedBox(height: 7),

                  // Upload documents - Only for Booking mode
                  if (selectedBookingType == BookingType.booking) ...[
                    const SizedBox(height: 8),
                    BookingDocumentUploadSection(
                      documentsNotifier: documentsNotifier,
                    ),
                    const SizedBox(height: 7),
                  ],

                  // Staff Details
                  const Text(
                    'Staff details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 7),

                  StaffSearchNameField(
                    nameController: staffNameController,
                    errorText: _staffNameError,
                  ),

                  const SizedBox(height: 7),

                  // Notes
                  Container(
                    height: 80,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: null,
                      expands: true,
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
                  ValueListenableBuilder<List<ProductSelectedModel>>(
                    valueListenable: selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return Column(
                        children: [
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: runningKilometersController,
                            hint: 'Running Kilometers',
                            isNumber: true,
                          ),
                          const SizedBox(height: 7),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Button - Continue
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _validateAndContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6132E4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
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

  void _showSuccessDialog(int id, BookingType type) {
    final isSale = type == BookingType.sales;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_rounded,
                color: Colors.green, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Successful!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSale
                  ? 'Sale has been successfully created.'
                  : 'Booking has been successfully created.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close dialog
                      if (widget.onClose != null) {
                        widget.onClose!();
                      } else {
                        Navigator.of(context).pop(); // Close screen
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        GlobalLoadingOverlay.show(context);
                        final userShop =
                            context.read<UserCubit>().state?.shopDetails;

                        if (userShop == null) {
                          throw 'Shop details not found';
                        }

                        if (isSale) {
                          final repo = getIt<SalesRepository>();
                          final sale = await repo.getSaleDetails(id);

                          // Close loading before showing dialog
                          GlobalLoadingOverlay.hide();

                          if (mounted) {
                            await GenerateSaleDetailsPdf.shareInvoice(
                              context: context,
                              saleDetails: sale,
                              shopDetails: userShop,
                            );
                          }
                        } else {
                          final repo = getIt<BookingRepository>();
                          final booking = await repo.getBooking(id);

                          // Close loading before showing dialog
                          GlobalLoadingOverlay.hide();

                          if (mounted) {
                            await GenerateBookingPdf.printInvoice(
                              context: context,
                              bookingDetails: booking,
                              shopDetails: userShop,
                            );
                          }
                        }

                        // Close dialog and screen
                        if (mounted) {
                          Navigator.of(dialogContext).pop();
                          if (widget.onClose != null) {
                            widget.onClose!();
                          } else {
                            Navigator.of(context).pop();
                          }
                        }
                      } catch (e) {
                        GlobalLoadingOverlay.hide();
                        log('Error generating PDF: $e');
                        if (mounted) {
                          context.showSnackBar('Failed to generate invoice: $e',
                              isError: true);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      isSale ? 'View Sale' : 'View Invoice',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
                    onTap: () => setState(() => _bookingStep = 0),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,
                            size: 20, color: Colors.grey.shade700),
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
                  ValueListenableBuilder<List<ProductSelectedModel>>(
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
                              optional: true),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                              controller: startLocationController,
                              hint: 'Start location'),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                              controller: pickupLocationController,
                              hint: 'Pickup location'),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                              controller: destinationLocationController,
                              hint: 'Destination'),
                          const SizedBox(height: 14),
                        ],
                      );
                    },
                  ),

                  // Payment details
                  BookingTextFieldBuilder.buildSectionHeader('Payment details',
                      optional: true),
                  const SizedBox(height: _fieldSpacing),
                  // Hide advance amount in edit mode
                  // BookingTextFieldBuilder.buildRightPanelTextField(
                  //     controller: advanceAmountController,
                  //     hint: 'Advance amount',
                  //     isNumber: true),
                  // const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                      controller: securityAmountController,
                      hint: 'Security amount',
                      isNumber: true),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                      controller: discountAmountController,
                      hint: 'Discount amount',
                      isNumber: true),

                  const SizedBox(height: 14),
                  // Payment Method Selection - Hidden in edit mode
                  // _buildPaymentMethodSection(),
                  // const SizedBox(height: 14),

                  // Additional Charges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Additional charges',
                        style: TextStyle(
                            fontSize: 13, color: Colors.grey.shade600),
                      ),
                      InkWell(
                        onTap: _addAdditionalCharge,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6132E4).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add,
                              size: 16, color: Color(0xFF6132E4)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Additional charges list
                  ValueListenableBuilder<List<AdditionalChargesModel>>(
                    valueListenable: additionalChargesNotifier,
                    builder: (context, charges, _) {
                      if (charges.isEmpty) return const SizedBox();
                      return Column(
                        children: charges
                            .map((c) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(c.name ?? '',
                                            style:
                                                const TextStyle(fontSize: 13)),
                                      ),
                                      Text('₹${c.amount}',
                                          style: const TextStyle(fontSize: 13)),
                                      const SizedBox(width: 8),
                                      GestureDetector(
                                        onTap: () => _removeCharge(c),
                                        child: Icon(Icons.close,
                                            size: 14,
                                            color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
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

  // Helper methods replaced - Using BookingTextFieldBuilder

  Widget _buildFinalSummary() {
    return ValueListenableBuilder<List<ProductSelectedModel>>(
      valueListenable: selectedProductsNotifier,
      builder: (context, products, _) {
        final productTotal = products.fold<int>(
            0, (sum, item) => sum + (item.amount * item.quantity));
        final additional = additionalChargesNotifier.value.fold<double>(
            0, (sum, item) => sum + (item.amount?.toDouble() ?? 0));

        final advance = double.tryParse(advanceAmountController.text) ?? 0;
        final discount = double.tryParse(discountAmountController.text) ?? 0;

        final totalPayable = productTotal + additional - advance - discount;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text('Product total',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_down,
                          size: 16, color: Colors.grey.shade600),
                    ],
                  ),
                  Text('₹${productTotal.toCurrency()}',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
              if (additional > 0) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Additional charges',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500)),
                    Text('₹${additional.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Divider(height: 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Paid',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  Text('₹${advance.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF27AE60))),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total payable',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  Text('₹${totalPayable.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFEB5757))),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildSimpleTextField(
  //     {required TextEditingController controller,
  //     required String hint,
  //     bool isNumber = false}) {
  //   return Container(
  //     height: 42,
  //     padding: const EdgeInsets.symmetric(horizontal: 12),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(8),
  //       color: Colors.white,
  //     ),
  //     child: TextField(
  //       controller: controller,
  //       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
  //       decoration: InputDecoration(
  //         border: InputBorder.none,
  //         hintText: hint,
  //         hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
  //         contentPadding: const EdgeInsets.only(bottom: 8),
  //       ),
  //       style: const TextStyle(fontSize: 13, color: Colors.black87),
  //     ),
  //   );
  // }
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
