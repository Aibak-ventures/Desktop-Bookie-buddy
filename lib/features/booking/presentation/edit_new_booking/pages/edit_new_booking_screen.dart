import 'dart:developer';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';

import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_partial_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/check_variant_availability_usecase.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';

import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';

import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/select_date_failure_dialog.dart';

import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_search_product_field_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/search_overlay_result_widget.dart';

class EditNewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;
  final BookingDetailsEntity? bookingDetails;
  final SaleDetailsEntity? saleDetails;
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

class EditNewBookingScreenState extends State<EditNewBookingScreen>
    with BookingFormMixin<EditNewBookingScreen> {
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

  // ── Shared: controllers, notifiers, overlay, product bloc ─────────────────
  final _form = BookingFormControllers();

  @override
  BookingFormControllers get form => _form;

  // ── Payment status (edit-only fields) ─────────────────────────────────────
  BookingStatus? bookingStatus;
  String? bookingCompletedDate;
  bool sendPdfToWhatsApp = true;

  int? selectedServiceId = -1;

  // ── Step state ─────────────────────────────────────────────────────────────
  int coolingPeriodDays = 0;
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;

  // ── Search filter (edit screen uses fixed list, not dynamic) ───────────────
  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Original values for change tracking (incremental updates)
  BookingDetailsEntity? _originalBooking;
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
  List<AdditionalChargesEntity>? _originalAdditionalCharges;
  List<DocumentFileEntity>?
  _originalDocuments; // Track original documents for removal detection
  String? _originalRunningKm; // Track original running kilometers
  DeliveryStatus? _originalDeliveryStatus; // Track original delivery status

  // Customization state
  bool showCustomization = false;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    // Pre-fill data if editing
    if (widget.bookingDetails != null) {
      _initializeFromBooking(widget.bookingDetails!);
    } else if (widget.saleDetails != null) {
      _initializeFromSale(widget.saleDetails!);
    }

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      // Load staffs for staff search dropdown - pre-select existing staff if editing
      final bookingStaffId = widget.bookingDetails?.staffId;
      final bookingStaffName = widget.bookingDetails?.staffName;
      final saleStaffId = widget.saleDetails?.staffId;
      final saleStaffName = widget.saleDetails?.staffName;
      if (bookingStaffId != null) {
        final existingStaff = StaffEntity(
          id: bookingStaffId,
          name: bookingStaffName ?? 'Staff',
          phoneNumber: '',
        );
        context.read<StaffSearchCubit>().getAllStaffs(
          bookingStaffId,
          existingStaff,
        );
      } else if (saleStaffId != null) {
        final existingStaff = StaffEntity(
          id: saleStaffId,
          name: saleStaffName ?? 'Staff',
          phoneNumber: '',
        );
        context.read<StaffSearchCubit>().getAllStaffs(
          saleStaffId,
          existingStaff,
        );
      } else {
        context.read<StaffSearchCubit>().getAllStaffs();
      }

      // 🔄 Load available products immediately using check-availability API
      // This ensures only products available for the booking dates are shown
      _loadAvailableProducts();
    });
  }

  /// Initialize form from existing booking
  void _initializeFromBooking(BookingDetailsEntity booking) {
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
      // Calculate cooling period days from the dates
      final coolingDate = booking.coolingPeriodDate!.parseToDateTime();
      coolingPeriodDays = coolingDate.difference(returnDate).inDays.abs();
      log(
        '🔧 Cooling period: $coolingPeriodDays days (Return: $returnDate, Cooling: $coolingDate)',
      );
    } else {
      // No cooling period set
      coolingPeriodDays = 0;
      coolingPeriodDate = null;
    }

    // Set client details
    _form.clientNameController.text = booking.client.name;
    _form.clientPhone1Controller.text = booking.client.phone1.toString();
    if (booking.client.phone2 != null) {
      _form.clientPhone2Controller.text = booking.client.phone2.toString();
    }
    if (booking.address != null) {
      _form.clientAddressController.text = booking.address!;
    }
    _form.selectedClientId = booking.client.id;

    // Set staff details
    if (booking.staffName != null) {
      _form.staffNameController.text = booking.staffName!;
    }
    if (booking.staffId != null) {
      _form.selectedStaffId = booking.staffId;
    }

    // Set payment details
    _form.advanceAmountController.text = booking.paidAmount.toString();
    if (booking.securityAmount != null) {
      _form.securityAmountController.text = booking.securityAmount.toString();
    }
    if (booking.discountAmount != null) {
      _form.discountAmountController.text = booking.discountAmount.toString();
    }
    _form.deliveryStatus = booking.deliveryStatus;
    bookingStatus = booking.bookingStatus; // Load booking status
    bookingCompletedDate = booking.bookingCompletedDate; // Load completed date

    // Set description
    if (booking.description != null) {
      _form.descriptionController.text = booking.description!;
    }

    // Set other details (locations & running kilometers)
    if (booking.otherDetails.locationStart != null) {
      _form.startLocationController.text = booking.otherDetails.locationStart!;
    }
    if (booking.otherDetails.locationFrom != null) {
      _form.pickupLocationController.text = booking.otherDetails.locationFrom!;
    }
    if (booking.otherDetails.locationTo != null) {
      _form.destinationLocationController.text =
          booking.otherDetails.locationTo!;
    }
    if (booking.otherDetails.end != null) {
      _form.runningKilometersController.text = booking.otherDetails.end!;
    }

    // Store original delivery status
    _form.deliveryStatus = booking.deliveryStatus;

    // Set products
    log('🔧 Loading ${booking.bookedItems.length} products from booking');
    final products = booking.bookedItems.map((item) {
      log(
        '📦 Product: ${item.name}, Measurements: ${item.measurements.length}',
      );
      return ProductSelectedEntity(
        variant: ProductInfoEntity(
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
            .measurements, // CRITICAL: Copy measurements to ProductSelectedEntity
        quantity: item.quantity,
        amount: item.amount,
      );
    }).toList();
    log(
      '✅ Loaded ${products.length} products. Products with measurements: ${products.where((p) => p.measurements.isNotEmpty).length}',
    );
    _form.selectedProductsNotifier.value = products;

    // Set additional charges
    _form.additionalChargesNotifier.value = booking.additionalCharges;

    // Load existing documents for preview
    log(
      '📄 Loading documents from booking. Total documents: ${booking.documents.length}',
    );
    if (booking.documents.isNotEmpty) {
      log('📄 Raw documents data: ${booking.documents}');
      final docs = booking.documents
          .map((doc) {
            if (doc is Map<String, dynamic>) {
              final url = doc['url'] ?? doc['file'] ?? '';
              final name = doc['name'] ?? _extractFilenameFromUrl(url);
              log('📄 Parsed document - Name: $name, URL: $url');
              return DocumentFileEntity(name: name, path: url);
            } else if (doc is String) {
              log('📄 Simple string document: $doc');
              final filename = _extractFilenameFromUrl(doc);
              log('📄 Extracted filename: $filename');
              return DocumentFileEntity(name: filename, path: doc);
            }
            log('⚠️ Unknown document format: $doc');
            return null;
          })
          .whereType<DocumentFileEntity>()
          .toList();
      log('✅ Loaded ${docs.length} documents for preview');
      _form.documentsNotifier.value = docs;
    } else {
      log('ℹ️ No documents found in booking');
    }

    // Store original values for change tracking (incremental updates)
    _storeOriginalValues(booking);
  }

  /// Store original values to track changes for incremental updates
  void _storeOriginalValues(BookingDetailsEntity booking) {
    _originalBooking = booking;
    _originalPickupDate = booking.pickupDate?.parseToDateTime();
    _originalReturnDate = booking.returnDate.parseToDateTime();
    _originalPickupTime = booking.pickupDate != null
        ? TimeOfDay.fromDateTime(booking.pickupDate!.parseToDateTime())
        : null;
    _originalReturnTime = TimeOfDay.fromDateTime(
      booking.returnDate.parseToDateTime(),
    );

    _originalClientName = booking.client.name;
    _originalClientPhone1 = booking.client.phone1.toString();
    _originalClientPhone2 = booking.client.phone2?.toString();
    _originalClientAddress = booking.address;

    _originalStaffId = booking.staffId;

    _originalAdvanceAmount = booking.paidAmount;
    _originalSecurityAmount = booking.securityAmount;
    _originalDiscountAmount = booking.discountAmount;

    // Store deep copy of additional charges
    _originalAdditionalCharges = _form.additionalChargesNotifier.value
        .map(
          (c) =>
              AdditionalChargesEntity(id: c.id, name: c.name, amount: c.amount),
        )
        .toList();

    // Store deep copy of documents
    _originalDocuments = _form.documentsNotifier.value
        .map(
          (d) => DocumentFileEntity(
            name: d.name,
            path: d.path,
            bytes: d.bytes != null ? List<int>.from(d.bytes!) : null,
          ),
        )
        .toList();

    // Store original running kilometers and delivery status
    _originalRunningKm = booking.otherDetails.end;
    _originalDeliveryStatus = booking.deliveryStatus;

    log('✅ Original values stored for incremental update tracking');
  }

  /// Check if dates have changed
  bool _haveDatesChanged() {
    if (_originalBooking == null) return true; // New booking, send all

    final currentPickupDate = pickupDate.format().appendTimeToDate(
      time: pickupTime,
    );
    final currentReturnDate = returnDate.format().appendTimeToDate(
      time: returnTime,
    );
    final originalPickupDateStr = _originalPickupDate
        ?.format()
        .appendTimeToDate(time: _originalPickupTime);
    final originalReturnDateStr = _originalReturnDate
        ?.format()
        .appendTimeToDate(time: _originalReturnTime);

    return currentPickupDate != originalPickupDateStr ||
        currentReturnDate != originalReturnDateStr;
  }

  /// Check if client details have changed
  bool _hasClientChanged() {
    if (_originalBooking == null) return true;

    final currentClientName = _form.clientNameController.text.trim();
    final currentClientPhone1 = _form.clientPhone1Controller.text.trim();
    final currentClientPhone2 = _form.clientPhone2Controller.text.trim();
    final currentClientAddress = _form.clientAddressController.text.trim();

    return currentClientName != (_originalClientName ?? '') ||
        currentClientPhone1 != (_originalClientPhone1 ?? '') ||
        currentClientPhone2 != (_originalClientPhone2 ?? '') ||
        currentClientAddress != (_originalClientAddress ?? '');
  }

  /// Check if staff has changed (reads directly from cubit to avoid timing issues)
  bool _hasStaffChanged() {
    if (_originalBooking == null) return true;
    final currentStaffId = context
        .read<StaffSearchCubit>()
        .state
        .selectedStaff
        ?.id;
    return currentStaffId != _originalStaffId;
  }

  /// Check if amounts have changed
  bool _haveAmountsChanged() {
    if (_originalBooking == null) return true;

    final currentAdvance =
        _form.advanceAmountController.text.trim().toIntOrNull() ?? 0;
    final currentSecurity =
        _form.securityAmountController.text.trim().toIntOrNull() ?? 0;
    final currentDiscount =
        _form.discountAmountController.text.trim().toIntOrNull() ?? 0;

    return currentAdvance != (_originalAdvanceAmount ?? 0) ||
        currentSecurity != (_originalSecurityAmount ?? 0) ||
        currentDiscount != (_originalDiscountAmount ?? 0);
  }

  /// Check if running kilometers have changed
  bool _hasRunningKmChanged() {
    final currentKm = _form.runningKilometersController.text.trim();
    return currentKm != (_originalRunningKm ?? '');
  }

  /// Check if delivery status has changed
  bool _hasDeliveryStatusChanged() {
    return _form.deliveryStatus != _originalDeliveryStatus;
  }

  /// Check if additional charges have changed
  bool _haveAdditionalChargesChanged() {
    if (_originalBooking == null) return true;
    if (_originalAdditionalCharges == null) return true;

    final currentCharges = _form.additionalChargesNotifier.value;

    // Check if count changed
    if (currentCharges.length != _originalAdditionalCharges!.length)
      return true;

    // Check if any charge changed
    for (int i = 0; i < currentCharges.length; i++) {
      final current = currentCharges[i];
      final original = _originalAdditionalCharges![i];

      if (current.name != original.name || current.amount != original.amount) {
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
      updates['pickup_date'] = pickupDate.format().appendTimeToDate(
        time: pickupTime,
      );
      updates['return_date'] = returnDate.format().appendTimeToDate(
        time: returnTime,
      );
      // If coolingPeriodDays is 0 (None), use exact return date and time
      updates['cooling_period_date'] = coolingPeriodDays == 0
          ? returnDate.format().appendTimeToDate(time: returnTime)
          : returnDate
                .add(Duration(days: coolingPeriodDays))
                .format()
                .appendTimeToDate(time: returnTime);
    }

    // Include client entirely if any client field changed
    if (_hasClientChanged()) {
      final phone1 = _form.clientPhone1Controller.text.trim().toIntOrNull();
      final phone2 = _form.clientPhone2Controller.text.trim().toIntOrNull();
      final clientName = _form.clientNameController.text.trim().nullIfEmpty;
      if (_form.selectedClientId != null) {
        // Existing client: send the id so server updates that client record
        updates['client_id'] = _form.selectedClientId;
        updates['client'] = {
          'id': _form.selectedClientId,
          'name': clientName,
          'phone1': phone1,
          'phone2': phone2,
        };
      } else {
        // New client
        updates['client'] = {
          'name': clientName,
          'phone1': phone1,
          'phone2': phone2,
        };
      }
      updates['address'] = _form.clientAddressController.text.trim();
    }

    // Include staff if changed (read directly from cubit — reliable, no listener timing issues)
    final currentStaffId = context
        .read<StaffSearchCubit>()
        .state
        .selectedStaff
        ?.id;
    if (_hasStaffChanged()) {
      updates['staff_id'] = currentStaffId;
    }

    // Include amounts if changed
    if (_haveAmountsChanged()) {
      updates['advance_amount'] = _form.advanceAmountController.text
          .trim()
          .toIntOrNull();
      updates['security_amount'] = _form.securityAmountController.text
          .trim()
          .toIntOrNull();
      updates['discount_amount'] = _form.discountAmountController.text
          .trim()
          .toIntOrNull();
    }

    // Always include products (variants) to ensure server state matches current selection.
    // IMPORTANT: The server uses 'id' as the variant identifier (product_variant id).
    //   - Products loaded from booked_items have p.variant.id = booked_item row id (WRONG)
    //     and p.variant.variantId = actual product variant id (CORRECT).
    //   - Products added from search have p.variant.id = variant.id = actual variant id.
    // Solution: use (p.variant.variantId ?? p.variant.id) so we always send the correct
    //   product variant id. 'variant_id' as a separate key is ignored by the server.
    {
      final products = _form.selectedProductsNotifier.value;
      updates['variants'] = products.map((p) {
        // Use variantId (actual product variant) if present, fallback to id (from search)
        final variantId = p.variant.variantId ?? p.variant.id;
        final variantData = <String, dynamic>{
          'id': variantId,
          'quantity': p.quantity,
          'amount': p.amount * p.quantity,
        };
        // Include measurements if present
        if (p.measurements.isNotEmpty) {
          variantData['measurements'] = p.measurements;
        }
        return variantData;
      }).toList();
    }

    // Include additional charges if changed
    if (_haveAdditionalChargesChanged()) {
      final charges = _form.additionalChargesNotifier.value;
      updates['additional_charges'] = charges.map((c) {
        final chargeData = <String, dynamic>{
          'name': c.name,
          'amount': c.amount,
        };
        if (c.id != null) {
          chargeData['id'] = c.id;
        }
        return chargeData;
      }).toList();
    }

    // Include purchase_mode only if needed (minimal metadata)
    updates['purchase_mode'] = 'normal';

    // Include delivery_status only if changed
    if (_hasDeliveryStatusChanged()) {
      updates['delivery_status'] = _form.deliveryStatus.toValue();
    }

    // Include description if present and changed
    final description = _form.descriptionController.text.trim();
    if (description.isNotEmpty) {
      updates['description'] = description;
    }

    // Include running kilometers if changed (even if cleared to null/empty)
    if (_hasRunningKmChanged()) {
      final runningKm = _form.runningKilometersController.text
          .trim()
          .nullIfEmpty;
      // Send as both flat field and nested other_details for API compatibility
      if (runningKm != null) {
        updates['running_km'] = runningKm;
      }
      updates['other_details'] = {'end': runningKm ?? ''};
    }

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
  void _initializeFromSale(SaleDetailsEntity sale) {
    selectedBookingType = BookingType.sales;

    // Set sale date
    pickupDate = sale.saleDate.parseToDateTime();

    // Set client details
    _form.clientPhone1Controller.text = sale.clientPhone.toString();
    if (sale.address.isNotEmpty) {
      _form.clientAddressController.text = sale.address;
    }

    // Set staff details
    if (sale.staffName != null) {
      _form.staffNameController.text = sale.staffName!;
    }

    // Set payment details
    _form.advanceAmountController.text = sale.paidAmount.toString();
    _form.discountAmountController.text = sale.discountAmount.toString();
    _form.paymentMethod = sale.paymentMethod;

    // Set description
    if (sale.description.isNotEmpty) {
      _form.descriptionController.text = sale.description;
    }

    // Set products
    final products = sale.products.map((item) {
      return ProductSelectedEntity(
        variant: ProductInfoEntity(
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
    _form.selectedProductsNotifier.value = products;
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  /// Check if there are any unsaved changes
  bool hasUnsavedChanges() {
    // Check if products are selected
    if (_form.selectedProductsNotifier.value.isNotEmpty) return true;

    // Check if client details are filled
    if (_form.clientNameController.text.trim().isNotEmpty) return true;
    if (_form.clientPhone1Controller.text.trim().isNotEmpty) return true;
    if (_form.clientPhone2Controller.text.trim().isNotEmpty) return true;
    if (_form.clientAddressController.text.trim().isNotEmpty) return true;

    // Check if payment details are filled
    if (_form.advanceAmountController.text.trim().isNotEmpty) return true;
    if (_form.securityAmountController.text.trim().isNotEmpty) return true;
    if (_form.discountAmountController.text.trim().isNotEmpty) return true;

    // Check if additional charges exist
    if (_form.additionalChargesNotifier.value.isNotEmpty) return true;

    // Check if documents are uploaded
    if (_form.documentsNotifier.value.isNotEmpty) return true;

    // Check if description is filled
    if (_form.descriptionController.text.trim().isNotEmpty) return true;
    if (_hasRunningKmChanged()) return true;
    if (_hasDeliveryStatusChanged()) return true;

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
      clientName: _form.clientNameController.text,
      phone1: _form.clientPhone1Controller.text,
      phone2: _form.clientPhone2Controller.text,
      address: _form.clientAddressController.text,
      documentsCount: _form.documentsNotifier.value.length,
      selectedStaffId: selectedStaff?.id,
      staffName: _form.staffNameController.text,
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
    final currentProducts = _form.selectProductBloc.state.maybeWhen(
      loaded:
          (
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
          ) => products,
      orElse: () => <ProductEntity>[],
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
      if (maxProductPrice > _form.maxPriceNotifier.value) {
        _form.maxPriceNotifier.value = maxProductPrice;
        _form.priceRange.value = RangeValues(0, maxProductPrice);
      }
    }

    // Get services for filter
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => ProductFilterDialog(
        services: services,
        searchTypes: _searchTypes,
        initialServiceId: selectedServiceId,
        initialSearchTypeIndex: _form.selectedSearchTypeIndex.value,
        initialPriceRange: _form.priceRange.value,
        initialMaxPrice: _form.maxPriceNotifier.value,
        initialIsPriceFilterEnabled: _form.isPriceFilterEnabled.value,
        onApply:
            ({
              required serviceId,
              required searchTypeIndex,
              required priceRange,
              required maxPrice,
              required isPriceFilterEnabled,
            }) {
              setState(() {
                selectedServiceId = serviceId;
                _form.selectedSearchTypeIndex.value = searchTypeIndex;
                _form.priceRange.value = priceRange;
                _form.maxPriceNotifier.value = maxPrice;
                _form.isPriceFilterEnabled.value = isPriceFilterEnabled;
              });
              _applyProductFilters(
                searchTypeIndex,
                priceRange,
                isPriceFilterEnabled,
              );
            },
      ),
    );
  }

  /// Apply product filters based on selection
  void _applyProductFilters(
    int searchTypeIndex,
    RangeValues priceRange,
    bool isPriceEnabled,
  ) {
    _form.isPriceFilterEnabled.value = isPriceEnabled;
    final searchTerm = _form.serviceSearchController.text.trim();
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
      _form.selectProductBloc.add(
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
      _form.selectProductBloc.add(
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
    final query = _form.serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final hasFilters =
        _form.isPriceFilterEnabled.value ||
        _form.selectedSearchTypeIndex.value != 0;

    if (query.isEmpty && !hasFilters) {
      _form.selectProductBloc.add(
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
      switch (_form.selectedSearchTypeIndex.value) {
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

      _form.selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: query.isEmpty ? null : query,
          type: searchType,
          startPrice: _form.isPriceFilterEnabled.value
              ? _form.priceRange.value.start.toInt()
              : null,
          endPrice: _form.isPriceFilterEnabled.value
              ? _form.priceRange.value.end.toInt()
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
                  bookingId:
                      widget.bookingId ??
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

  Widget _buildMainContent() {
    if (selectedBookingType == BookingType.customWork) {
      return Container(child: Center(child: Text('Custom Work - Coming Soon')));
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
                  transitionBuilder: (Widget child, Animation<double> animation) {
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
                              final index = _form.selectedProductsNotifier.value
                                  .indexWhere(
                                    (p) =>
                                        p.variant.variantId ==
                                        product.variant.variantId,
                                  );
                              if (index != -1) {
                                final updatedProducts =
                                    List<ProductSelectedEntity>.from(
                                      _form.selectedProductsNotifier.value,
                                    );
                                updatedProducts[index] = product.copyWith(
                                  measurements: measurements,
                                );
                                _form.selectedProductsNotifier.value =
                                    updatedProducts;
                              }
                            });
                          },
                          selectedProducts:
                              _form.selectedProductsNotifier.value,
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
        SizedBox(width: 340, child: _buildRightSidePanel()),
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

    // Extract variant IDs from currently selected products for edit mode
    final currentVariantIds = _form.selectedProductsNotifier.value
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();

    _form.selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: pickupDate.format(),
        returnDate: returnDate.format(),
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
        bookingId: widget.bookingId, // Pass booking ID for edit mode
        variantIds: currentVariantIds.isNotEmpty
            ? currentVariantIds
            : null, // Pass current variants
      ),
    );

    // After reloading products, check if selected products are still available
    _checkSelectedProductsAvailability();
  }

  /// Check if already-selected products are still available for the current
  /// date range. Uses booking_id to exclude the current booking from conflict
  /// checks (edit mode). Shows [showUnavailableProductsDialog] if any are not.
  Future<void> _checkSelectedProductsAvailability() async {
    final isSales = selectedBookingType == BookingType.sales;
    if (isSales) return;

    final selected = _form.selectedProductsNotifier.value;
    if (selected.isEmpty) return;

    final variantIds = selected
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    if (variantIds.isEmpty) return;

    try {
      final notFoundIds = await getIt<CheckVariantAvailabilityUseCase>()(
        pickupDate: pickupDate.format(),
        returnDate: returnDate.format(),
        variantIds: variantIds,
        bookingId: widget.bookingId, // Pass booking_id in edit mode
        pickupTime: pickupTime,
        returnTime: returnTime,
      );

      if (notFoundIds.isNotEmpty && mounted) {
        await showUnavailableProductsDialog(
          context: context,
          unavailableDateFrom: pickupDate.format(),
          unavailableDateTo: returnDate.format(),
          unavailableProducts: notFoundIds,
          selectedProductsNotifier: _form.selectedProductsNotifier,
        );
      }
    } catch (e) {
      log('Error checking selected product availability: $e');
    }
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
          ValueListenableBuilder<List<ProductSelectedEntity>>(
            valueListenable: _form.selectedProductsNotifier,
            builder: (context, products, _) {
              return Text(
                'Select Products (${products.length})',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              );
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
          bloc: _form.selectProductBloc,
          listener: (context, state) {
            //Update existing products' stock from availability API
            state.maybeWhen(
              loaded:
                  (
                    products,
                    p1,
                    p2,
                    p3,
                    p4,
                    p5,
                    isSearching,
                    p7,
                    p8,
                    p9,
                    p10,
                    p11,
                    p12,
                    p13,
                    p14,
                  ) {
                    // Update stock for already selected products from fresh availability data
                    if (widget.bookingId != null && products.isNotEmpty) {
                      final currentProducts =
                          _form.selectedProductsNotifier.value;
                      final updatedProducts = currentProducts.map((
                        selectedProduct,
                      ) {
                        for (final freshProduct in products) {
                          final matchingVariant = freshProduct.variants
                              .firstWhere(
                                (v) =>
                                    v.id == selectedProduct.variant.variantId,
                                orElse: () => ProductVariantEntity(
                                  id: 0,
                                  attribute: '',
                                  price: null,
                                  stock: 0,
                                  remainingStock: null,
                                ),
                              );
                          if (matchingVariant.id != 0) {
                            return selectedProduct.copyWith(
                              variant: selectedProduct.variant.copyWith(
                                stock: matchingVariant.stock,
                                remainingStock: matchingVariant.remainingStock,
                              ),
                            );
                          }
                        }
                        return selectedProduct;
                      }).toList();
                      if (updatedProducts.toString() !=
                          currentProducts.toString()) {
                        _form.selectedProductsNotifier.value = updatedProducts;
                        log(
                          '✅ Updated stock values for ${updatedProducts.length} selected products',
                        );
                      }
                    }

                    // Reactive overlay update — show/hide overlay based on search state
                    final hasSearchText =
                        _form.serviceSearchController.text.isNotEmpty;
                    final hasFilters =
                        _form.isPriceFilterEnabled.value ||
                        _form.selectedSearchTypeIndex.value != 0;
                    final hasAnyFilter = hasSearchText || hasFilters;

                    if (hasAnyFilter || (products.isNotEmpty && isSearching)) {
                      _form.overlayIsLoading.value = false;
                      _form.overlayProducts.value = products;
                      if (_form.searchOverlayEntry == null)
                        _showSearchOverlay();
                    } else {
                      _form.removeSearchOverlay();
                    }
                  },
              loading: () {
                final hasQuery = _form.serviceSearchController.text.isNotEmpty;
                final hasFilters =
                    _form.isPriceFilterEnabled.value ||
                    _form.selectedSearchTypeIndex.value != 0;
                if (hasQuery || hasFilters) {
                  _form.overlayIsLoading.value = true;
                  if (_form.searchOverlayEntry == null) _showSearchOverlay();
                }
              },
              orElse: () {
                final hasQuery = _form.serviceSearchController.text.isNotEmpty;
                if (!hasQuery) _form.removeSearchOverlay();
              },
            );
          },
          child: BookingSearchProductFieldWidget(
            form: form,
            onSearchChanged: _onSearchChanged,
            showProductFilterDialog: _showProductFilterBottomSheet,
          ),
        );
      },
    );
  }

  void _showSearchOverlay() {
    if (_form.searchOverlayEntry != null) return;

    _form.searchOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _form.serviceSearchController.clear();
                _form.removeSearchOverlay();
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            width: 1000,
            child: CompositedTransformFollower(
              link: _form.searchLayerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _form.overlayIsLoading,
                  builder: (context, isLoading, _) {
                    return ValueListenableBuilder<List<ProductEntity>>(
                      valueListenable: _form.overlayProducts,
                      builder: (context, productList, _) {
                        return Container(
                          constraints: const BoxConstraints(maxHeight: 450),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Header
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (isLoading)
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1.5,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Searching...',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      Text(
                                        'Search Results (${productList.length})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    GestureDetector(
                                      onTap: () {
                                        _form.serviceSearchController.clear();
                                        _form.removeSearchOverlay();
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
                              // Body
                              if (isLoading)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 36,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Color(0xFF6132E4),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Loading products...',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else if (productList.isEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 32,
                                    horizontal: 16,
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.search_off_rounded,
                                        size: 48,
                                        color: Colors.grey.shade300,
                                      ),
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
                              else
                                Flexible(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    itemCount: productList.length,
                                    separatorBuilder: (_, __) => Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    itemBuilder: (_, i) =>
                                        _buildOverlaySearchItem(productList[i]),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_form.searchOverlayEntry!);
  }

  /// Builds search item for the overlay - requires variant selection before adding
  Widget _buildOverlaySearchItem(ProductEntity product) {
    return OverlaySearchItem(
      product: product,
      onAddProduct: (selectedVariant) {
        _form.removeSearchOverlay();
        _form.serviceSearchController.clear();
        _addProductFromSearchWithVariant(product, selectedVariant);
      },
    );
  }

  /// Add product from search with specific variant
  void _addProductFromSearchWithVariant(
    ProductEntity product,
    ProductVariantEntity variant,
  ) {
    log(
      '_addProductFromSearchWithVariant called for: ${product.name}, variant: ${variant.attribute}',
    );

    // For sales mode, use sale_price if available, otherwise fall back to rent price
    final isSales = selectedBookingType == BookingType.sales;
    // Parse product-level sale_price (String?) to int
    final productSalePriceInt = isSales && product.salePrice != null
        ? (double.tryParse(product.salePrice!)?.toInt())
        : null;
    final price = isSales
        ? (variant.salePrice ??
              productSalePriceInt ??
              variant.price ??
              product.price ??
              0)
        : (variant.price ?? product.price ?? 0);
    log(
      'Adding variant: ${variant.attribute}, price: $price (isSales: $isSales)',
    );

    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );

    // Check if this variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      // Check stock before incrementing quantity
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;
      final availableStock = variant.remainingStock ?? variant.stock;
      if (availableStock > 0 && newQuantity > availableStock) {
        context.showSnackBar(
          'Cannot add more. Only $availableStock items available in stock',
          isError: true,
        );
        return;
      }
      products[existingIndex] = existing.copyWith(quantity: newQuantity);
    } else {
      // Check stock before adding a new entry
      final availableStock = variant.remainingStock ?? variant.stock;
      if (availableStock == 0) {
        context.showSnackBar('This item is out of stock', isError: true);
        return;
      }
      // Add new product with selected variant
      final attribute = variant.attribute.isEmpty
          ? (product.model ?? '')
          : variant.attribute;

      products.add(
        ProductSelectedEntity(
          variant: ProductInfoEntity(
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
        ),
      );
    }

    _form.selectedProductsNotifier.value = products;
    log('Product added. Total selected: ${products.length}');
    setState(() {}); // Refresh to update UI
  }

  /// Calculate rental days between booking and return dates
  /// Below 24 hours = 1 day, Above 24 hours = 2 days, etc.
  /// Considers the actual time component for accurate 24-hour period calculation
  int _calculateRentalDays() {
    if (pickupDate == returnDate && pickupTime == returnTime) return 1;

    // Create DateTime objects with time component
    final pickupDateTime = DateTime(
      pickupDate.year,
      pickupDate.month,
      pickupDate.day,
      pickupTime?.hour ?? 0,
      pickupTime?.minute ?? 0,
    );

    final returnDateTime = DateTime(
      returnDate.year,
      returnDate.month,
      returnDate.day,
      returnTime?.hour ?? 23,
      returnTime?.minute ?? 59,
    );

    final difference = returnDateTime.difference(pickupDateTime);
    final hours = difference.inHours;

    // Below 24 hours = 1 day, above = days based on hours
    if (hours < 24) {
      return 1;
    } else {
      // Calculate days based on hours: 24-48 hours = 2 days, etc.
      // Use ceil to count partial days as full days
      return (hours / 24).ceil();
    }
  }

  Widget _buildProductListHeader() {
    final isSales = selectedBookingType == BookingType.sales;
    final hasVariants = hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: buildHeaderCell('items', alignLeft: true)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: buildHeaderCell('Specifications')),
          const SizedBox(width: 4),
          if (hasVariants) ...[
            Expanded(child: buildHeaderCell('Variants')),
            const SizedBox(width: 4),
          ],
          if (!isSales) ...[
            Expanded(child: buildHeaderCell('Days')),
            const SizedBox(width: 4),
          ],
          Expanded(child: buildHeaderCell('Available')),
          const SizedBox(width: 4),
          Expanded(child: buildHeaderCell('Quantity')),
          const SizedBox(width: 4),
          Expanded(child: buildHeaderCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(child: buildHeaderCell('Total')),
          const SizedBox(width: 50), // Matches row close button area
        ],
      ),
    );
  }

  Widget _buildSelectedProductsList() {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
      valueListenable: _form.selectedProductsNotifier,
      builder: (context, products, _) {
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 48,
                    color: Colors.grey.shade200,
                  ),
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
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
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

  Widget _buildProductRow(ProductSelectedEntity product) {
    final isSales = selectedBookingType == BookingType.sales;
    final rentalDays = !isSales ? _calculateRentalDays() : 0;
    // Only multiply price by days for qualifying service types
    final effectiveDaysMultiplier =
        (!isSales && shouldMultiplyByDays(product.variant.mainServiceType))
        ? (rentalDays > 0 ? rentalDays : 1)
        : 1;
    final hasVariants = hasAnyProductWithVariants();

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
                    image:
                        product.variant.image != null &&
                            product.variant.image!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.variant.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      product.variant.image == null ||
                          product.variant.image!.isEmpty
                      ? const Icon(
                          Icons.image_not_supported,
                          size: 20,
                          color: Colors.grey,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Product Name only
                Expanded(
                  child: Text(
                    product.variant.name,
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
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 4,
                ),
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
                      '${product.variant.remainingStock ?? product.variant.stock ?? 0} left',
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
                  onTap: () => _decrementQuantity(product),
                ),
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
                  icon: Icons.add,
                  onTap: () => _incrementQuantity(product),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // Price / item
          Expanded(
            child: _form.editingVariantId == product.variant.variantId
                ? Center(
                    child: Container(
                      width: 80,
                      height: 32,
                      child: TextField(
                        controller: _form.inlinePriceController,
                        focusNode: _form.inlinePriceFocusNode,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xFF6132E4),
                            ),
                          ),
                        ),
                        onSubmitted: (_) => _saveEditingPrice(product),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => startEditingPrice(product),
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
                        Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: const Color(0xFF6132E4),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(width: 4),
          // Total
          Expanded(
            child: Center(
              child: Text(
                '${product.amount * product.quantity * effectiveDaysMultiplier}',
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

  Widget _buildQuantityBtn({
    required IconData icon,
    required VoidCallback onTap,
  }) {
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
  void _incrementQuantity(ProductSelectedEntity product) {
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

    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );
      _form.selectedProductsNotifier.value = products;
    }
  }

  /// Decrement quantity of a product
  void _decrementQuantity(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );
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
      _form.selectedProductsNotifier.value = products;
    }
  }

  void _saveEditingPrice(ProductSelectedEntity product) {
    if (_form.editingVariantId == null) return;

    final newPrice = int.tryParse(_form.inlinePriceController.text);
    if (newPrice != null) {
      updateProductPrice(product, newPrice);
    }

    setState(() {
      _form.editingVariantId = null;
      _form.inlinePriceController.clear();
      _form.inlinePriceFocusNode.unfocus();
    });
  }

  /// Remove a product from the selected list
  void _removeProduct(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    _form.selectedProductsNotifier.value = products;
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
              _form.selectedProductsNotifier,
              _form.additionalChargesNotifier,
              _form.advanceAmountController,
              _form.discountAmountController,
            ]),
            builder: (context, _) {
              final products = _form.selectedProductsNotifier.value;
              final additionalCharges = _form.additionalChargesNotifier.value;
              final advanceAmount =
                  _form.advanceAmountController.text.trim().toIntOrNull() ?? 0;
              final discountAmount =
                  _form.discountAmountController.text.trim().toIntOrNull() ?? 0;

              final isSaleType = selectedBookingType == BookingType.sales;
              final summaryRentalDays = !isSaleType
                  ? _calculateRentalDays()
                  : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                // Only multiply by days for qualifying service types
                final daysMultiplier =
                    (!isSaleType &&
                        shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
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

              return Column(
                children: [
                  buildSummaryRow('Product total', productTotal),
                  if (additionalTotal > 0)
                    buildSummaryRow('Additional charges', additionalTotal),
                  if (discountAmount > 0)
                    buildSummaryRow(
                      '- Discount',
                      discountAmount,
                      isNegative: true,
                    ),
                  const Divider(height: 6),
                  buildSummaryRow(
                    'Paid',
                    advanceAmount,
                    valueColor: const Color(0xFF1AB000),
                  ),
                  buildSummaryRow(
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
          ValueListenableBuilder<List<ProductSelectedEntity>>(
            valueListenable: _form.selectedProductsNotifier,
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
                            ? 'Edit customization'
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
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4CAF50),
                    size: 20,
                  ),
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

  /// Handle save booking for edit mode
  Future<void> _handleSaveBooking() async {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = _form.selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    // Show loading
    GlobalLoadingOverlay.show(context);

    try {
      if (widget.bookingDetails != null) {
        // Update existing booking with incremental changes only
        final partialUpdate = _buildPartialUpdateRequest();

        // Detect document changes
        final currentDocs = _form.documentsNotifier.value;
        final originalDocPaths =
            _originalDocuments?.map((d) => d.path).toSet() ?? {};
        final currentDocPaths = currentDocs.map((d) => d.path).toSet();

        // Find removed documents (were in original but not in current)
        final removedUrls = originalDocPaths
            .difference(currentDocPaths)
            .toList();

        // Find new documents (have bytes = newly uploaded)
        final newDocs = currentDocs.where((d) => d.bytes != null).toList();

        log(
          '📄 Document changes - New: ${newDocs.length}, Removed: ${removedUrls.length}',
        );

        await getIt<UpdateBookingPartialUseCase>()(
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
            Navigator.of(context).pop(true); // true → caller refreshes list
          }
        }
      } else if (widget.saleDetails != null) {
        // Update existing sale
        final salesRequest = _buildSalesRequest();
        await getIt<ISalesRepository>().updateSale(salesRequest);
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

  /// Build sales request for creating/updating a sale
  SalesRequestEntity _buildSalesRequest() {
    final products = _form.selectedProductsNotifier.value;

    // Use phone1 as client_phone
    final clientPhone = _form.clientPhone1Controller.text.trim();

    return SalesRequestEntity(
      id: widget.saleDetails?.id,
      staffId: _form.selectedStaffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      address: _form.clientAddressController.text.trim().isEmpty
          ? null
          : _form.clientAddressController.text.trim(),
      saleDate: pickupDate.format(), // Use pickup date as sale date
      description: _form.descriptionController.text.trim().isEmpty
          ? null
          : _form.descriptionController.text.trim(),
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      products: products,
      paidAmount: _form.advanceAmountController.text.trim().toIntOrNull() ?? 0,
      paymentMethod: _form.paymentMethod,
      discountAmount:
          _form.discountAmountController.text.trim().toIntOrNull() ?? 0,
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
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                            items: [
                              // Add \"None\" option
                              const DropdownMenuItem(
                                value: 0,
                                child: Text('None'),
                              ),
                              // Generate 1-10 days
                              ...List.generate(10, (index) {
                                final days = index + 1;
                                return DropdownMenuItem(
                                  value: days,
                                  child: Text(
                                    '$days day${days > 1 ? 's' : ''}',
                                  ),
                                );
                              }),
                            ],
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
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: const Color(0xFF9A76E8),
                ),
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
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
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
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
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
                        _form.clientNameController.text = client.name;
                        _form.clientPhone1Controller.text = client.phone1
                            .toString();
                        if (client.phone2 != null) {
                          _form.clientPhone2Controller.text = client.phone2
                              .toString();
                        }
                        // Store selected client ID
                        _form.selectedClientId = client.id;
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: _form.clientNameController,
                      focusNode: _form.clientNameFocusNode,
                      hitText: 'Search client by name',
                      onClear: () {
                        // Clear all client fields when search is cleared
                        _form.clientNameController.clear();
                        _form.clientPhone1Controller.clear();
                        _form.clientPhone2Controller.clear();
                        _form.clientAddressController.clear();
                        _form.selectedClientId = null;
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
                        controller: _form.clientPhone1Controller,
                        hint: 'Phone',
                        isNumber: true,
                        focusNode: _form.clientPhone1FocusNode,
                        nextFocusNode: _form.clientPhone2FocusNode,
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
                        controller: _form.clientPhone2Controller,
                        hint: 'Phone 2',
                        isNumber: true,
                        focusNode: _form.clientPhone2FocusNode,
                        nextFocusNode: _form.clientAddressFocusNode,
                        enabled: !isClientSelected,
                      );
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientAddressController,
                    hint: 'place',
                    focusNode: _form.clientAddressFocusNode,
                    nextFocusNode: null, // Last field
                  ),

                  const SizedBox(height: _fieldSpacing),
                  const SizedBox(height: 16),

                  // Upload documents - Only for Booking mode
                  if (selectedBookingType == BookingType.booking) ...[
                    const SizedBox(height: 8),
                    BookingDocumentUploadSection(
                      documentsNotifier: _form.documentsNotifier,
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
                    nameController: _form.staffNameController,
                    errorText: _staffNameError,
                  ),

                  const SizedBox(height: 7),

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
                      controller: _form.descriptionController,
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
                  ValueListenableBuilder<List<ProductSelectedEntity>>(
                    valueListenable: _form.selectedProductsNotifier,
                    builder: (context, products, _) {
                      final hasVehicles = products.any(
                        (p) => p.variant.mainServiceType?.isVehicle ?? false,
                      );
                      if (!hasVehicles) return const SizedBox.shrink();
                      return Column(
                        children: [
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: _form.runningKilometersController,
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
                    valueListenable: _form.selectedProductsNotifier,
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
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: _form.startLocationController,
                            hint: 'Start location',
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: _form.pickupLocationController,
                            hint: 'Pickup location',
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: _form.destinationLocationController,
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
                  const SizedBox(height: _fieldSpacing),

                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.securityAmountController,
                    hint: 'Security amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.discountAmountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),

                  const SizedBox(height: 14),

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
                        onTap: addAdditionalCharge,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6132E4).withOpacity(0.1),
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
                    valueListenable: _form.additionalChargesNotifier,
                    builder: (context, charges, _) {
                      if (charges.isEmpty) return const SizedBox();
                      return Column(
                        children: charges
                            .map(
                              (c) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        c.name ?? '',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                    Text(
                                      '₹${c.amount}',
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => removeCharge(c),
                                      child: Icon(
                                        Icons.close,
                                        size: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
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
}
