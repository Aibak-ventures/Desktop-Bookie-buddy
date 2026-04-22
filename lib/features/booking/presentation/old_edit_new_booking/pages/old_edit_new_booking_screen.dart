import 'dart:developer';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_edit_new_booking/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/data/repositories/product_repository_impl.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

class OldEditNewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;
  final BookingDetailsEntity? bookingDetails;
  final SaleDetailsEntity? saleDetails;
  final int? bookingId;

  const OldEditNewBookingScreen({
    super.key,
    this.onClose,
    this.bookingDetails,
    this.saleDetails,
    this.bookingId,
  });

  @override
  State<OldEditNewBookingScreen> createState() =>
      OldEditNewBookingScreenState();
}

class OldEditNewBookingScreenState extends State<OldEditNewBookingScreen> {
  static const _defaultUnselectedTime = TimeOfDay(hour: 23, minute: 59);

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
  late final PhoneController _clientPhone1FieldController;
  late final PhoneController _clientPhone2FieldController;
  final clientAddressController = TextEditingController();
  final staffNameController = TextEditingController();
  int? selectedStaffId;
  int? selectedClientId;
  bool isSearchClientEnabled = false;
  // Payment controllers
  final advanceAmountController = TextEditingController();
  final securityAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  AccountEntity? selectedSecurityAccount;
  DeliveryStatus deliveryStatus = DeliveryStatus.booked;
  bool isDiscountPercentage = false;
  BookingStatus? bookingStatus; // Track booking status
  String? bookingCompletedDate; // Store completed date
  bool sendPdfToWhatsApp = true;

  // Products/Services
  final selectedProductsNotifier = ValueNotifier<List<ProductSelectedEntity>>(
    [],
  );

  // Additional charges
  final additionalChargesNotifier =
      ValueNotifier<List<AdditionalChargesEntity>>([]);

  // Documents
  final documentsNotifier = ValueNotifier<List<DocumentFileEntity>>([]);

  // Description
  final descriptionController = TextEditingController();

  int? selectedServiceId = -1; // Initialize to -1 for "All Services" as default
  final serviceSearchController = TextEditingController();

  // SelectProductBloc for inline search
  late SelectProductBloc _selectProductBloc;

  // Search overlay management
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;
  // Reactive overlay state — updated without recreating the OverlayEntry
  final _overlayProducts = ValueNotifier<List<ProductEntity>>([]);
  final _overlayIsLoading = ValueNotifier<bool>(false);

  // Product search filter state
  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);

  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  // New Fields for Redesign
  int coolingPeriodDays = 0; // Default to None (0 = same as return date)
  CoolingPeriodMode coolingPeriodMode = CoolingPeriodMode.after;
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

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Focus nodes for client details navigation
  final _clientNameFocusNode = FocusNode();
  final _clientPhone1FocusNode = FocusNode();
  final _clientPhone2FocusNode = FocusNode();
  final _clientAddressFocusNode = FocusNode();

  // Original values for change tracking (incremental updates)
  BookingDetailsEntity? _originalBooking;
  DateTime? _originalPickupDate;
  DateTime? _originalReturnDate;
  TimeOfDay? _originalPickupTime;
  TimeOfDay? _originalReturnTime;
  String? _originalClientName;
  String? _originalClientPhone1;
  String? _originalClientPhone2;
  String? _originalClientPhone1E164;
  String? _originalClientPhone2E164;
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
  int _originalCoolingPeriodDays = 0; // Track original cooling period
  bool _hasLoadedInitialProducts = false; // Prevent duplicate API calls on init
  final _loadProductsDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  // Customization state
  bool showCustomization = false;
  // ProductSelectedEntity? _selectedProductForCustomization;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));
    _clientPhone1FieldController = PhoneController(
      initialValue: PhoneNumber(isoCode: kDefaultPhoneIsoCode, nsn: ''),
    );
    _clientPhone2FieldController = PhoneController(
      initialValue: PhoneNumber(isoCode: kDefaultPhoneIsoCode, nsn: ''),
    );

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      getAvailableProducts: getIt(),
      getProducts: getIt(),
      searchAndFilterProducts: getIt(),
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
      if (!_hasLoadedInitialProducts) {
        _hasLoadedInitialProducts = true;
        _loadAvailableProducts();
      }
    });
  }

  void _setPhoneFieldValue(
    PhoneController phoneController,
    TextEditingController textController, {
    String? phoneNumber,
    String? e164,
  }) {
    final phone = phoneNumberFromData(phoneNumber: phoneNumber, e164: e164);
    phoneController.value =
        phone ?? PhoneNumber(isoCode: kDefaultPhoneIsoCode, nsn: '');
    final digits = normalizePhoneDigits(phone?.nsn ?? phoneNumber);
    cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
    textController.value = TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }

  void _populateClientPhones({
    required String? phone1,
    String? phone1E164,
    String? phone2,
    String? phone2E164,
  }) {
    _setPhoneFieldValue(
      _clientPhone1FieldController,
      clientPhone1Controller,
      phoneNumber: phone1,
      e164: phone1E164,
    );
    _setPhoneFieldValue(
      _clientPhone2FieldController,
      clientPhone2Controller,
      phoneNumber: phone2,
      e164: phone2E164,
    );
  }

  /// Initialize form from existing booking
  void _initializeFromBooking(BookingDetailsEntity booking) {
    selectedBookingType = BookingType.booking;

    // Set dates
    if (booking.pickupDate != null) {
      pickupDate = booking.pickupDate!.parseToDateTime();
    }
    returnDate = booking.returnDate.parseToDateTime();

    // Only show time if explicitly provided in dedicated fields
    // Don't extract from date string - if pickup_time is null, show empty
    if (booking.pickupTime != null && booking.pickupTime!.isNotEmpty) {
      pickupTime = _extractExplicitTime(booking.pickupTime);
    } else {
      pickupTime = null;
    }

    if (booking.returnTime != null && booking.returnTime!.isNotEmpty) {
      returnTime = _extractExplicitTime(booking.returnTime);
    } else {
      returnTime = null;
    }

    if (booking.coolingPeriodDate != null) {
      coolingPeriodDate = booking.coolingPeriodDate!.parseToDateTime();
      final coolingDate = booking.coolingPeriodDate!.parseToDateTime();
      // Use booking's cooling period type if available, otherwise use shop settings
      final bookingCoolingMode = booking.coolingPeriodType?.toLowerCase();
      if (bookingCoolingMode == 'before') {
        coolingPeriodMode = CoolingPeriodMode.before;
        coolingPeriodDays = pickupDate.difference(coolingDate).inDays.abs();
      } else if (bookingCoolingMode == 'after') {
        coolingPeriodMode = CoolingPeriodMode.after;
        coolingPeriodDays = coolingDate.difference(returnDate).inDays.abs();
      } else {
        // Fall back to shop settings
        final shopCoolingMode =
            context.read<UserCubit>().state?.shopSettings.coolingPeriodMode ??
            CoolingPeriodMode.after;
        coolingPeriodMode = shopCoolingMode;
        if (shopCoolingMode.isBefore) {
          coolingPeriodDays = pickupDate.difference(coolingDate).inDays.abs();
        } else {
          coolingPeriodDays = coolingDate.difference(returnDate).inDays.abs();
        }
      }
      log(
        '🔧 Cooling period: $coolingPeriodDays days (mode: ${coolingPeriodMode.value}, Return: $returnDate, Cooling: $coolingDate)',
      );
    } else {
      coolingPeriodDays = 0;
      coolingPeriodDate = null;
    }

    // Set client details
    clientNameController.text = booking.client.name;
    // phone1/phone2 are non-nullable ints in ClientEntity but the API may return null,
    // in which case the entity defaults to 0. Check > 0 before trusting the raw int,
    // and fall back to extracting from the E.164 string.
    _populateClientPhones(
      phone1: booking.client.phone1 > 0
          ? booking.client.phone1.toString()
          : null,
      phone1E164: booking.client.phone1E164,
      phone2: (booking.client.phone2 ?? 0) > 0
          ? booking.client.phone2.toString()
          : null,
      phone2E164: booking.client.phone2E164,
    );
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
    // selectedSecurityAccount is auto-selected via initialAccountId in AccountSelectionField
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
    // running_kilometers: read from vehicle product measurements (new format)
    // or fall back to otherDetails.end (old format).
    String? runningKmValue;
    outer:
    for (final item in booking.bookedItems) {
      if (item.mainServiceType?.isVehicle ?? false) {
        for (final m in item.measurements) {
          if (m.key == 'running_kilometers') {
            runningKmValue = m.value;
            break outer;
          }
        }
      }
    }
    runningKmValue ??= booking.otherDetails.end;
    if (runningKmValue != null && runningKmValue.isNotEmpty) {
      runningKilometersController.text = runningKmValue;
    }

    // Store original delivery status
    deliveryStatus = booking.deliveryStatus;

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
    selectedProductsNotifier.value = products;

    // Set additional charges
    additionalChargesNotifier.value = booking.additionalCharges;

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
      documentsNotifier.value = docs;
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

    // Only use dedicated time fields - don't extract from date string
    if (booking.pickupTime != null && booking.pickupTime!.isNotEmpty) {
      _originalPickupTime = _extractExplicitTime(booking.pickupTime);
    } else {
      _originalPickupTime = null;
    }

    if (booking.returnTime != null && booking.returnTime!.isNotEmpty) {
      _originalReturnTime = _extractExplicitTime(booking.returnTime);
    } else {
      _originalReturnTime = null;
    }

    _originalClientName = booking.client.name;
    // Mirror the same zero-guard used in _initializeFromBooking so that
    // original vs current comparisons are accurate.
    _originalClientPhone1 = (booking.client.phone1) > 0
        ? booking.client.phone1.toString()
        : (booking.client.phone1E164 != null &&
                  booking.client.phone1E164!.isNotEmpty
              ? _extractPhoneFromE164(booking.client.phone1E164!)
              : '');
    _originalClientPhone2 = (booking.client.phone2 ?? 0) > 0
        ? booking.client.phone2.toString()
        : (booking.client.phone2E164 != null &&
                  booking.client.phone2E164!.isNotEmpty
              ? _extractPhoneFromE164(booking.client.phone2E164!)
              : null);
    _originalClientPhone1E164 = booking.client.phone1E164;
    _originalClientPhone2E164 = booking.client.phone2E164;
    _originalClientAddress = booking.address;

    _originalStaffId = booking.staffId;

    _originalAdvanceAmount = booking.paidAmount;
    _originalSecurityAmount = booking.securityAmount;
    _originalDiscountAmount = booking.discountAmount;

    // Store deep copy of additional charges
    _originalAdditionalCharges = additionalChargesNotifier.value
        .map(
          (c) =>
              AdditionalChargesEntity(id: c.id, name: c.name, amount: c.amount),
        )
        .toList();

    // Store deep copy of documents
    _originalDocuments = documentsNotifier.value
        .map(
          (d) => DocumentFileEntity(
            name: d.name,
            path: d.path,
            bytes: d.bytes != null ? List<int>.from(d.bytes!) : null,
          ),
        )
        .toList();

    // Store original running kilometers (new: from vehicle measurements; old: from otherDetails.end)
    String? originalKm;
    outer:
    for (final item in booking.bookedItems) {
      if (item.mainServiceType?.isVehicle ?? false) {
        for (final m in item.measurements) {
          if (m.key == 'running_kilometers') {
            originalKm = m.value;
            break outer;
          }
        }
      }
    }
    _originalRunningKm = originalKm ?? booking.otherDetails.end;
    _originalDeliveryStatus = booking.deliveryStatus;
    _originalCoolingPeriodDays = coolingPeriodDays;

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

    final currentClientName = clientNameController.text.trim();
    final currentClientPhone1 = clientPhone1Controller.text.trim();
    final currentClientPhone2 = clientPhone2Controller.text.trim();
    final currentClientAddress = clientAddressController.text.trim();

    final currentPhone1E164 = currentClientPhone1.isNotEmpty
        ? toPhone1E164(currentClientPhone1)
        : null;
    final currentPhone2E164 = currentClientPhone2.isNotEmpty
        ? toPhone1E164(currentClientPhone2)
        : null;

    return currentClientName != (_originalClientName ?? '') ||
        currentClientPhone1 != (_originalClientPhone1 ?? '') ||
        (currentClientPhone2.isNotEmpty &&
            currentClientPhone2 != (_originalClientPhone2 ?? '')) ||
        currentPhone1E164 != _originalClientPhone1E164 ||
        currentPhone2E164 != _originalClientPhone2E164 ||
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

    final currentSecurity =
        securityAmountController.text.trim().toIntOrNull() ?? 0;
    final discountInput =
        discountAmountController.text.trim().toIntOrNull() ?? 0;
    final productBase = _getDiscountProductBase();
    final currentDiscount = isDiscountPercentage && productBase > 0
        ? (productBase * discountInput / 100).round()
        : discountInput;

    return currentSecurity != (_originalSecurityAmount ?? 0) ||
        currentDiscount != (_originalDiscountAmount ?? 0);
  }

  /// Check if running kilometers have changed
  bool _hasRunningKmChanged() {
    final currentKm = runningKilometersController.text.trim();
    return currentKm != (_originalRunningKm ?? '');
  }

  /// Check if delivery status has changed
  bool _hasDeliveryStatusChanged() {
    return deliveryStatus != _originalDeliveryStatus;
  }

  /// Check if additional charges have changed
  bool _haveAdditionalChargesChanged() {
    if (_originalBooking == null) return true;
    if (_originalAdditionalCharges == null) return true;

    final currentCharges = additionalChargesNotifier.value;

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
        time24HourAsString: pickupTime == null ? '00:00:00' : null,
      );
      updates['return_date'] = returnDate.format().appendTimeToDate(
        time: returnTime,
        time24HourAsString: returnTime == null ? '23:59:00' : null,
      );
      updates['pickup_time'] = _bookingTimeValue(pickupTime);
      updates['return_time'] = _bookingTimeValue(returnTime);

      // Calculate dates based on user-selected cooling period mode
      if (coolingPeriodDays > 0) {
        if (coolingPeriodMode.isAfter) {
          updates['cooling_period_end'] = returnDate
              .add(Duration(days: coolingPeriodDays))
              .format()
              .appendTimeToDate(
                time: returnTime,
                time24HourAsString: returnTime == null ? '23:59:00' : null,
              );
        } else {
          // Before mode: return_date stays as-is; cooling_period_end is before pickup
          updates['cooling_period_end'] = pickupDate
              .subtract(Duration(days: coolingPeriodDays))
              .format()
              .appendTimeToDate(
                time: returnTime,
                time24HourAsString: returnTime == null ? '23:59:00' : null,
              );
        }
        updates['cooling_period_type'] = coolingPeriodMode.value.toLowerCase();
      } else {
        updates['cooling_period_end'] = returnDate.format().appendTimeToDate(
          time: returnTime,
          time24HourAsString: returnTime == null ? '23:59:00' : null,
        );
      }
    } else if (coolingPeriodDays != _originalCoolingPeriodDays) {
      // Cooling period changed but dates didn't — send return_date + cooling_period_date
      updates['return_date'] = returnDate.format().appendTimeToDate(
        time: returnTime,
        time24HourAsString: returnTime == null ? '23:59:00' : null,
      );
      updates['pickup_time'] = _bookingTimeValue(pickupTime);
      updates['return_time'] = _bookingTimeValue(returnTime);

      // Calculate dates based on user-selected cooling period mode
      if (coolingPeriodDays > 0) {
        if (coolingPeriodMode.isAfter) {
          updates['cooling_period_end'] = returnDate
              .add(Duration(days: coolingPeriodDays))
              .format()
              .appendTimeToDate(
                time: returnTime,
                time24HourAsString: returnTime == null ? '23:59:00' : null,
              );
        } else {
          // Before mode: return_date stays as-is; cooling_period_end is before pickup
          updates['cooling_period_end'] = pickupDate
              .subtract(Duration(days: coolingPeriodDays))
              .format()
              .appendTimeToDate(
                time: returnTime,
                time24HourAsString: returnTime == null ? '23:59:00' : null,
              );
        }
        updates['cooling_period_type'] = coolingPeriodMode.value.toLowerCase();
      } else {
        updates['cooling_period_end'] = returnDate.format().appendTimeToDate(
          time: returnTime,
          time24HourAsString: returnTime == null ? '23:59:00' : null,
        );
      }
    }

    // Include client fields if any client detail changed
    // NOTE: Do NOT send client_id separately when updating client details
    if (_hasClientChanged()) {
      final phone1Str = clientPhone1Controller.text.trim();
      final phone2Str = clientPhone2Controller.text.trim();
      final phone1E164 = phone1Str.isEmpty ? null : toPhone1E164(phone1Str);
      final phone2E164 = phone2Str.isEmpty ? null : toPhone1E164(phone2Str);
      final clientName = clientNameController.text.trim().nullIfEmpty;

      final clientData = <String, dynamic>{
        'client_name': clientName,
        if (phone1E164 != null) 'phone_1_e164': phone1E164,
        if (phone2E164 != null) 'phone_2_e164': phone2E164,
      };

      // Include id inside client object, but do NOT send client_id separately
      if (selectedClientId != null) {
        clientData['id'] = selectedClientId;
      }
      updates['client'] = clientData;
      updates['client_address'] = clientAddressController.text.trim();
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
      updates['security_amount'] = securityAmountController.text
          .trim()
          .toIntOrNull();
      final discountInput =
          discountAmountController.text.trim().toIntOrNull() ?? 0;
      final productBase = _getDiscountProductBase();
      updates['discount_amount'] = isDiscountPercentage && productBase > 0
          ? (productBase * discountInput / 100).round()
          : discountInput;
    }
    // final advAmt = advanceAmountController.text.trim().toIntOrNull();
    // if (advAmt != null && advAmt > 0 && selectedAdvanceAccount?.id != null) {
    //   updates['account_id'] = selectedAdvanceAccount!.id;
    // }
    final secAmt = securityAmountController.text.trim().toIntOrNull();
    if (secAmt != null && secAmt > 0 && selectedSecurityAccount?.id != null) {
      updates['security_account_id'] = selectedSecurityAccount!.id;
    }

    // Always include products (variants) to ensure server state matches current selection.
    // IMPORTANT: The server uses 'id' as the variant identifier (product_variant id).
    //   - Products loaded from booked_items have p.variant.id = booked_item row id (WRONG)
    //     and p.variant.variantId = actual product variant id (CORRECT).
    //   - Products added from search have p.variant.id = variant.id = actual variant id.
    // Solution: use (p.variant.variantId ?? p.variant.id) so we always send the correct
    //   product variant id. 'variant_id' as a separate key is ignored by the server.
    {
      final products = selectedProductsNotifier.value;
      final runningKm = runningKilometersController.text.trim();
      updates['variants'] = products.map((p) {
        // Use variantId (actual product variant) if present, fallback to id (from search)
        final variantId = p.variant.variantId ?? p.variant.id;
        final variantData = <String, dynamic>{
          'id': variantId,
          'quantity': p.quantity,
          'amount': p.amount * p.quantity,
        };
        // Convert measurements entity list to a JSON-serialisable map.
        // Exclude running_kilometers here — it's re-added from the controller below.
        final measurementMap = <String, dynamic>{};
        for (final m in p.measurements) {
          if (m.key != 'running_kilometers') {
            // Use m.key (snake_case backend key) not m.name (display label)
            measurementMap[m.key] = m.value;
          }
        }
        // running_kilometers goes inside measurements — always include if non-empty.
        if (runningKm.isNotEmpty) {
          measurementMap['running_kilometers'] = runningKm;
        }
        if (measurementMap.isNotEmpty) {
          variantData['measurements'] = measurementMap;
        }
        return variantData;
      }).toList();
    }

    // Include additional charges if changed
    if (_haveAdditionalChargesChanged()) {
      final charges = additionalChargesNotifier.value;
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
      updates['delivery_status'] = deliveryStatus.toValue();
    }

    // Include description if present and changed
    final description = descriptionController.text.trim();
    if (description.isNotEmpty) {
      updates['description'] = description;
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
    // Use sale.client.phone1 if available, otherwise use sale.clientPhone or fallback to E.164
    final saleClient = sale.client;
    if (saleClient != null) {
      _populateClientPhones(
        phone1: saleClient.phone1 > 0 ? saleClient.phone1.toString() : null,
        phone1E164: saleClient.phone1E164,
      );
    } else if (sale.clientPhone != null) {
      final phoneStr = sale.clientPhone.toString();
      if (phoneStr.isNotEmpty) {
        _populateClientPhones(phone1: phoneStr);
      }
    }
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
    // selectedAdvanceAccount is auto-selected via initialAccountId in AccountSelectionField

    // Set description
    if (sale.description.isNotEmpty) {
      descriptionController.text = sale.description;
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
    selectedProductsNotifier.value = products;
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    _clientPhone1FieldController.dispose();
    _clientPhone2FieldController.dispose();
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
    _overlayProducts.dispose();
    _overlayIsLoading.dispose();
    super.dispose();
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
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
      if (maxProductPrice > _maxPriceNotifier.value) {
        _maxPriceNotifier.value = maxProductPrice;
        _priceRange.value = RangeValues(0, maxProductPrice);
      }
    }

    // Get services for filter
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    // Setup local state for dialog
    final TextEditingController maxPriceController = TextEditingController();
    final isPriceFilterEnabledWidgetNotifier = ValueNotifier(
      _isPriceFilterEnabled.value,
    );
    final tempSelectedServiceId = ValueNotifier<int?>(selectedServiceId);
    final tempSelectedSearchTypeIndex = ValueNotifier<int>(
      _selectedSearchTypeIndex.value,
    );
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
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
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
                            ...services.map(
                              (s) => {'id': s.id, 'name': s.name},
                            ),
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
                              final isSelected =
                                  selectedId == id ||
                                  (selectedId == null && id == -1);

                              return InkWell(
                                onTap: () {
                                  tempSelectedServiceId.value = id;
                                },
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
                                              color: const Color(
                                                0xFF6132E4,
                                              ).withOpacity(0.3),
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
                        },
                      ),

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
                                              color: const Color(
                                                0xFF6132E4,
                                              ).withOpacity(0.3),
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
                                    activeTrackColor: const Color(
                                      0xFF6132E4,
                                    ).withOpacity(0.3),
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
                                          builder:
                                              (
                                                context,
                                                currentMaxPrice,
                                                child,
                                              ) {
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
                                                    color: const Color(
                                                      0xFFF8F9FA,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: TextField(
                                                    controller:
                                                        maxPriceController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onTapOutside: (_) {
                                                      FocusScope.of(
                                                        context,
                                                      ).unfocus();
                                                    },
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'Inter',
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          isDense: true,
                                                          prefixText: '₹ ',
                                                          prefixStyle:
                                                              TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF6132E4,
                                                                ),
                                                              ),
                                                        ),
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        final newMaxPrice =
                                                            double.tryParse(
                                                              value,
                                                            ) ??
                                                            currentMaxPrice;
                                                        _maxPriceNotifier
                                                                .value =
                                                            newMaxPrice;
                                                        if (tempPriceRange
                                                                .value
                                                                .end >
                                                            newMaxPrice) {
                                                          tempPriceRange
                                                              .value = RangeValues(
                                                            tempPriceRange
                                                                        .value
                                                                        .start >
                                                                    newMaxPrice
                                                                ? 0
                                                                : tempPriceRange
                                                                      .value
                                                                      .start,
                                                            newMaxPrice,
                                                          );
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
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.1),
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF6132E4,
                                                ).withOpacity(0.3),
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
                                              horizontal: 12,
                                            ),
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
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.1),
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF6132E4,
                                                ).withOpacity(0.3),
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
                                                (
                                                  context,
                                                  currentMaxPrice,
                                                  child,
                                                ) => SliderTheme(
                                                  data: SliderThemeData(
                                                    activeTrackColor:
                                                        const Color(0xFF6132E4),
                                                    inactiveTrackColor:
                                                        Colors.grey.shade200,
                                                    thumbColor: const Color(
                                                      0xFF6132E4,
                                                    ),
                                                    overlayColor: const Color(
                                                      0xFF6132E4,
                                                    ).withOpacity(0.2),
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
                                                    onChanged:
                                                        (RangeValues newRange) {
                                                          tempPriceRange.value =
                                                              newRange;
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
                                                  .map(
                                                    (
                                                      filter,
                                                    ) => _buildQuickFilterChip(
                                                      filter['label'],
                                                      filter['range'],
                                                      tempPriceRange,
                                                      (val) =>
                                                          tempPriceRange.value =
                                                              val,
                                                    ),
                                                  )
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
                          tempPriceRange.value = RangeValues(
                            0,
                            _maxPriceNotifier.value,
                          );
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
    double minPrice,
    double maxPrice,
  ) {
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
  ) => ValueListenableBuilder<RangeValues>(
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
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade50,
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
    int searchTypeIndex,
    RangeValues priceRange,
    bool isPriceEnabled,
  ) {
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

    final isBooking = selectedBookingType == BookingType.booking;
    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

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
          returnDate: effectiveReturnDate,
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
          returnDate: effectiveReturnDate,
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
    final isBooking = selectedBookingType == BookingType.booking;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    // For booking+after mode only, extend return date by cooling period.
    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    final hasFilters =
        _isPriceFilterEnabled.value || _selectedSearchTypeIndex.value != 0;

    if (query.isEmpty && !hasFilters) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
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
          returnDate: effectiveReturnDate,
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
                  displayId:
                      widget.bookingDetails?.invoiceId ??
                      widget.saleDetails?.invoiceId ??
                      '${widget.bookingId ?? widget.bookingDetails?.id ?? widget.saleDetails?.id ?? 0}',
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
                              final index = selectedProductsNotifier.value
                                  .indexWhere(
                                    (p) =>
                                        p.variant.variantId ==
                                        product.variant.variantId,
                                  );
                              if (index != -1) {
                                final updatedProducts =
                                    List<ProductSelectedEntity>.from(
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
        SizedBox(width: 340, child: _buildRightSidePanel()),
      ],
    );
  }

  Future<void> _selectDate({required bool isPickup}) async {
    final initialDate = isPickup ? pickupDate : returnDate;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isPickup ? DateTime(now.year - 5) : pickupDate,
      lastDate: now.add(const Duration(days: 365 * 2)),
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
        return Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            const SingleActivator(LogicalKeyboardKey.enter):
                const ActivateIntent(),
            const SingleActivator(LogicalKeyboardKey.numpadEnter):
                const ActivateIntent(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (intent) {
                  final focusContext =
                      FocusManager.instance.primaryFocus?.context;
                  if (focusContext != null) {
                    return Actions.maybeInvoke<ActivateIntent>(
                      focusContext,
                      const ActivateIntent(),
                    );
                  }
                  return null;
                },
              ),
            },
            child: Focus(
              autofocus: true,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF6132E4),
                  ),
                ),
                child: child!,
              ),
            ),
          ),
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
    _loadProductsDebouncer.run(() {
      _loadAvailableProductsInternal();
    });
  }

  void _loadAvailableProductsInternal() {
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    // When cooling period mode is "before", adjust the effective pickup date for availability check
    final effectivePickupDate =
        isBooking && coolingPeriodMode.isBefore && coolingPeriodDays > 0
        ? pickupDate.subtract(Duration(days: coolingPeriodDays))
        : pickupDate;

    log(
      '📦 Loading products - pickupDate: ${pickupDate.format()}, effectivePickupDate: ${effectivePickupDate.format()}, returnDate: ${returnDate.format()}, coolingPeriodDays: $coolingPeriodDays, coolingMode: ${coolingPeriodMode.value}, isBooking: $isBooking',
    );

    // For booking+after mode only, extend return date by cooling period.
    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    log(
      '📦 Loading products - pickupDate: ${pickupDate.format()}, effectivePickupDate: ${effectivePickupDate.format()}, returnDate: $effectiveReturnDate, coolingPeriodDays: $coolingPeriodDays, coolingMode: ${coolingPeriodMode.value}, isBooking: $isBooking',
    );

    // Extract variant IDs from currently selected products for edit mode
    final currentVariantIds = selectedProductsNotifier.value
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();

    _selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: effectivePickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
        bookingId: widget.bookingId,
        variantIds: currentVariantIds.isNotEmpty ? currentVariantIds : null,
      ),
    );

    // Note: Removed duplicate _checkSelectedProductsAvailability() call
    // The loadProducts API already checks availability when bookingId is provided
  }

  /// Check if already-selected products are still available for the current
  /// date range. Uses booking_id to exclude the current booking from conflict
  /// checks (edit mode). Shows [showUnavailableProductsDialog] if any are not.
  Future<void> _checkSelectedProductsAvailability() async {
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    if (isSales) return;

    final selected = selectedProductsNotifier.value;
    if (selected.isEmpty) return;

    final variantIds = selected
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    if (variantIds.isEmpty) return;

    // When cooling period mode is "before", adjust the effective pickup date for availability check
    final effectivePickupDate =
        isBooking && coolingPeriodMode.isBefore && coolingPeriodDays > 0
        ? pickupDate.subtract(Duration(days: coolingPeriodDays))
        : pickupDate;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    try {
      final notFoundIds = await getIt<ProductRepositoryImpl>()
          .checkVariantAvailability(
            pickupDate: effectivePickupDate.format(),
            returnDate: effectiveReturnDate,
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
          selectedProductsNotifier: selectedProductsNotifier,
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
            valueListenable: selectedProductsNotifier,
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
          bloc: _selectProductBloc,
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
                      final currentProducts = selectedProductsNotifier.value;
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

                          Widget _buildCoolingModeOption({
                            required String label,
                            required bool isSelected,
                            required VoidCallback onTap,
                          }) {
                            return Expanded(
                              child: InkWell(
                                onTap: onTap,
                                borderRadius: BorderRadius.circular(6),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(
                                            0xFF6132E4,
                                          ).withOpacity(0.1)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.check_circle
                                            : Icons.circle_outlined,
                                        size: 16,
                                        color: isSelected
                                            ? const Color(0xFF6132E4)
                                            : Colors.grey,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        label,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
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
                        }
                        return selectedProduct;
                      }).toList();
                      if (updatedProducts.toString() !=
                          currentProducts.toString()) {
                        selectedProductsNotifier.value = updatedProducts;
                        log(
                          '✅ Updated stock values for ${updatedProducts.length} selected products',
                        );
                      }
                    }

                    // Reactive overlay update — show/hide overlay based on search state
                    final hasSearchText =
                        serviceSearchController.text.isNotEmpty;
                    final hasFilters =
                        _isPriceFilterEnabled.value ||
                        _selectedSearchTypeIndex.value != 0;
                    final hasAnyFilter = hasSearchText || hasFilters;

                    if (hasAnyFilter || (products.isNotEmpty && isSearching)) {
                      _overlayIsLoading.value = false;
                      _overlayProducts.value = products;
                      if (_searchOverlayEntry == null) _showSearchOverlay();
                    } else {
                      _removeSearchOverlay();
                    }
                  },
              loading: () {
                final hasQuery = serviceSearchController.text.isNotEmpty;
                final hasFilters =
                    _isPriceFilterEnabled.value ||
                    _selectedSearchTypeIndex.value != 0;
                if (hasQuery || hasFilters) {
                  _overlayIsLoading.value = true;
                  if (_searchOverlayEntry == null) _showSearchOverlay();
                }
              },
              orElse: () {
                final hasQuery = serviceSearchController.text.isNotEmpty;
                if (!hasQuery) _removeSearchOverlay();
              },
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
                            horizontal: 12,
                            vertical: 14,
                          ),
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

  void _showSearchOverlay() {
    if (_searchOverlayEntry != null) return;

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                serviceSearchController.clear();
                _removeSearchOverlay();
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            width: 1000,
            child: CompositedTransformFollower(
              link: _searchLayerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _overlayIsLoading,
                  builder: (context, isLoading, _) {
                    return ValueListenableBuilder<List<ProductEntity>>(
                      valueListenable: _overlayProducts,
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

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  /// Builds search item for the overlay - requires variant selection before adding
  Widget _buildOverlaySearchItem(ProductEntity product) {
    return _OverlaySearchItem(
      product: product,
      onAddProduct: (selectedVariant) {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _addProductFromSearchWithVariant(product, selectedVariant);
      },
      onImageTap: (imageUrl, title) {
        _removeSearchOverlay();
        ZoomableImageDialog.show(context, imageUrl: imageUrl, title: title);
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
      selectedProductsNotifier.value,
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

    selectedProductsNotifier.value = products;
    log('Product added. Total selected: ${products.length}');
    setState(() {}); // Refresh to update UI
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
    final hasVariants = _hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildHeaderCell('items', alignLeft: true)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: _buildHeaderCell('Specifications')),
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
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
      valueListenable: selectedProductsNotifier,
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
          itemCount: products.length,
          itemBuilder: (context, index) => _buildProductRow(products[index]),
        );
      },
    );
  }

  /// Returns true only for service types where the total price
  /// should be multiplied by rental days (vehicle, gadgets, equipment, costume).
  bool _shouldMultiplyByDays(MainServiceType? serviceType) {
    return serviceType == MainServiceType.vehicle ||
        serviceType == MainServiceType.gadgets ||
        serviceType == MainServiceType.equipment ||
        serviceType == MainServiceType.costume;
  }

  TimeOfDay? _extractSelectedTime(String? rawDateTime) {
    if (rawDateTime == null || rawDateTime.trim().isEmpty) return null;

    final normalized = rawDateTime.trim();
    final hasExplicitTime =
        normalized.contains('T') ||
        normalized.contains(RegExp(r'\s\d{1,2}:\d{2}'));
    if (!hasExplicitTime) return null;

    final parsedTime = normalized.parseToDateTime().toTimeOfDay;
    if (parsedTime.hour == _defaultUnselectedTime.hour &&
        parsedTime.minute == _defaultUnselectedTime.minute) {
      return null;
    }

    return parsedTime;
  }

  TimeOfDay? _extractExplicitTime(String? timeString) {
    if (timeString == null || timeString.trim().isEmpty) return null;

    final trimmed = timeString.trim();
    final parts = trimmed.split(':');
    if (parts.length < 2) return null;

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;

    return TimeOfDay(hour: hour, minute: minute);
  }

  String _bookingTimeValue(TimeOfDay? time) =>
      time?.formatToTime() ?? _defaultUnselectedTime.formatToTime();

  String _extractPhoneFromE164(String e164) => extractPhoneFromE164(e164);

  void _updateCoolingPeriod() {
    if (coolingPeriodDays <= 0) {
      coolingPeriodDate = null;
      return;
    }

    if (coolingPeriodMode.isAfter) {
      coolingPeriodDate = returnDate.add(Duration(days: coolingPeriodDays));
    } else {
      coolingPeriodDate = pickupDate.subtract(
        Duration(days: coolingPeriodDays),
      );
    }
  }

  int _getDiscountProductBase() {
    final rentalDays = _calculateRentalDays();
    final isSales = selectedBookingType == BookingType.sales;
    final productTotal = selectedProductsNotifier.value.fold<int>(0, (sum, p) {
      final daysMultiplier =
          (!isSales && _shouldMultiplyByDays(p.variant.mainServiceType))
          ? (rentalDays > 0 ? rentalDays : 1)
          : 1;
      return sum + (p.amount * p.quantity * daysMultiplier);
    });
    final additionalTotal = additionalChargesNotifier.value.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );
    return productTotal + additionalTotal;
  }

  Widget _buildProductRow(ProductSelectedEntity product) {
    final isSales = selectedBookingType == BookingType.sales;
    final rentalDays = !isSales ? _calculateRentalDays() : 0;
    final imageUrl = product.variant.thumbnailImage ?? product.variant.image;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    // Only multiply price by days for qualifying service types
    final effectiveDaysMultiplier =
        (!isSales && _shouldMultiplyByDays(product.variant.mainServiceType))
        ? (rentalDays > 0 ? rentalDays : 1)
        : 1;
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
                MouseRegion(
                  cursor: hasImage
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  child: GestureDetector(
                    onTap: hasImage
                        ? () => ZoomableImageDialog.show(
                            context,
                            imageUrl: imageUrl,
                            title: product.variant.name,
                          )
                        : null,
                    child: Container(
                      width: 48,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade200),
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: !hasImage
                          ? const Icon(
                              Icons.image_not_supported,
                              size: 20,
                              color: Colors.grey,
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.zoom_in,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
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
      selectedProductsNotifier.value,
    );
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
  void _decrementQuantity(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      selectedProductsNotifier.value,
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
      selectedProductsNotifier.value = products;
    }
  }

  void _startEditingPrice(ProductSelectedEntity product) {
    setState(() {
      _editingVariantId = product.variant.variantId;
      _inlinePriceController.text = product.amount.toString();
      // Schedule focus request for next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _inlinePriceFocusNode.requestFocus();
      });
    });
  }

  void _saveEditingPrice(ProductSelectedEntity product) {
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
  void _removeProduct(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      selectedProductsNotifier.value,
    );
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    selectedProductsNotifier.value = products;
  }

  /// Update the price of a product
  void _updateProductPrice(ProductSelectedEntity product, int newPrice) {
    final products = List<ProductSelectedEntity>.from(
      selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      selectedProductsNotifier.value = products;
    }
  }

  Widget _buildSummaryBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: ListenableBuilder(
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

          final isSaleType = selectedBookingType == BookingType.sales;
          final summaryRentalDays = !isSaleType ? _calculateRentalDays() : 1;
          final productTotal = products.fold<int>(0, (sum, product) {
            final daysMultiplier =
                (!isSaleType &&
                    _shouldMultiplyByDays(product.variant.mainServiceType))
                ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
                : 1;
            return sum + (product.amount * product.quantity * daysMultiplier);
          });
          final additionalTotal = additionalCharges.fold<int>(
            0,
            (sum, charge) => sum + (charge.amount ?? 0),
          );
          final actualDiscount = isDiscountPercentage
              ? ((productTotal + additionalTotal) * discountAmount / 100)
                    .round()
              : discountAmount;
          final totalPayable = productTotal + additionalTotal - actualDiscount;
          final remainingAmount = totalPayable - advanceAmount;

          return Column(
            children: [
              if (isSaleType)
                _buildSummaryRow(
                  'Total amount',
                  remainingAmount > 0 ? remainingAmount : 0,
                  valueColor: const Color(0xFF6132E4),
                  isBold: true,
                )
              else ...[
                _buildSummaryRow('Product total', productTotal),
                if (additionalTotal > 0)
                  _buildSummaryRow('Additional charges', additionalTotal),
                if (actualDiscount > 0)
                  _buildSummaryRow(
                    '- Discount',
                    actualDiscount,
                    isNegative: true,
                  ),
                const Divider(height: 6),
                _buildSummaryRow(
                  'Paid',
                  advanceAmount,
                  valueColor: const Color(0xFF1AB000),
                ),
                _buildSummaryRow(
                  'Total payable',
                  remainingAmount > 0 ? remainingAmount : 0,
                  valueColor: const Color(0xFFD30000),
                  isBold: true,
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummarySection() {
    return Column(
      children: [
        _buildSummaryBreakdownCard(),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 242, 254),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            children: [
              // const SizedBox(height: 3),

              // const SizedBox(height: 3),
              // Add/Edit customization button - Only for Dresses
              ValueListenableBuilder<List<ProductSelectedEntity>>(
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
                      const Icon(
                        Icons.cancel,
                        color: Color(0xFFF44336),
                        size: 20,
                      ),
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
                      'Save Change',
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

  void _addAdditionalCharge() async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final result = await showDialog<AdditionalChargesEntity>(
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
                  AdditionalChargesEntity(name: name, amount: amount),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result != null) {
      final charges = List<AdditionalChargesEntity>.from(
        additionalChargesNotifier.value,
      );
      charges.add(result);
      additionalChargesNotifier.value = charges;
    }
  }

  void _removeCharge(AdditionalChargesEntity charge) {
    final charges = List<AdditionalChargesEntity>.from(
      additionalChargesNotifier.value,
    );
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

    // Validate paid amount doesn't exceed total payable (for both bookings and sales)
    {
      final paidAmount = advanceAmountController.text.trim().toIntOrNull() ?? 0;
      final discountInput =
          discountAmountController.text.trim().toIntOrNull() ?? 0;
      final additionalCharges = additionalChargesNotifier.value;
      final additionalTotal = additionalCharges.fold<int>(
        0,
        (sum, charge) => sum + (charge.amount ?? 0),
      );
      final isSaleType = selectedBookingType == BookingType.sales;
      final summaryRentalDays = !isSaleType ? _calculateRentalDays() : 1;
      final productTotal = products.fold<int>(0, (sum, product) {
        final daysMultiplier =
            (!isSaleType &&
                _shouldMultiplyByDays(product.variant.mainServiceType))
            ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
            : 1;
        return sum + (product.amount * product.quantity * daysMultiplier);
      });
      final actualDiscount = isDiscountPercentage
          ? ((productTotal + additionalTotal) * discountInput / 100).round()
          : discountInput;
      final totalPayable = productTotal + additionalTotal - actualDiscount;
      if (paidAmount > totalPayable) {
        context.showSnackBar(
          'Paid amount ($paidAmount) cannot be greater than total payable amount ($totalPayable)',
          isError: true,
        );
        return;
      }
    }

    // Validate account selection when amounts are present
    final isSaleType = selectedBookingType == BookingType.sales;
    // final advAmt = advanceAmountController.text.trim().toIntOrNull() ?? 0;
    final secAmt = securityAmountController.text.trim().toIntOrNull() ?? 0;
    if (!isSaleType && secAmt > 0 && selectedSecurityAccount == null) {
      context.showSnackBar(
        'Please select a payment option for security amount',
        isError: true,
      );
      return;
    }

    // Show loading
    GlobalLoadingOverlay.show(context);

    try {
      final repository = getIt<BookingRepositoryImpl>();

      if (widget.bookingDetails != null) {
        // Update existing booking with incremental changes only
        final partialUpdate = _buildPartialUpdateRequest();

        // Detect document changes
        final currentDocs = documentsNotifier.value;
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
            Navigator.of(context).pop(true); // true → caller refreshes list
          }
        }
      } else if (widget.saleDetails != null) {
        // Update existing sale
        final salesRequest = _buildSalesRequest();
        await getIt<SalesRepositoryImpl>().updateSale(salesRequest);
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
        final formattedError = _formatBookingError(e.toString());
        context.showSnackBar(formattedError, isError: true);
      }
      log('Error saving: $e');
    }
  }

  /// Formats backend error messages into clean, user-readable text
  String _formatBookingError(String rawError) {
    // Handle "Insufficient stock for ProductName (VariantName). Not available from X to Y."
    // → "Not enough stock: ProductName (VariantName) is unavailable from X to Y."
    final insufficientStockRegex = RegExp(
      r'Insufficient stock for "(.+?)"\s*\((.+?)\)"\. Not available from (.+?) to (.+?)\.',
      caseSensitive: false,
    );
    final match = insufficientStockRegex.firstMatch(rawError);
    if (match != null) {
      final productName = match.group(1)?.trim() ?? 'product';
      final attribute = match.group(2)?.trim() ?? '';
      final fromDate = match.group(3)?.trim() ?? '';
      final toDate = match.group(4)?.trim() ?? '';
      final fullProductName = attribute.isNotEmpty
          ? '"$productName ($attribute)"'
          : '"$productName"';
      return 'Not enough stock for $fullProductName. Not available from $fromDate to $toDate.';
    }

    // Handle simpler insufficient stock error: "Insufficient stock for ProductName"
    final simpleInsufficientRegex = RegExp(
      r'Insufficient stock for "(.+?)"',
      caseSensitive: false,
    );
    final simpleMatch = simpleInsufficientRegex.firstMatch(rawError);
    if (simpleMatch != null) {
      final productName = simpleMatch.group(1)?.trim() ?? 'product';
      return 'Not enough stock for "$productName". Please remove it from the booking or reduce the quantity.';
    }

    // Fall back to cleaning up generic error prefix
    return rawError.replaceFirst(
      RegExp(r'^Exception:\s*', caseSensitive: false),
      '',
    );
  }

  /// Build sales request for creating/updating a sale
  SalesRequestEntity _buildSalesRequest() {
    final products = selectedProductsNotifier.value;

    // Use phone1 as client_phone
    final clientPhone = clientPhone1Controller.text.trim();

    return SalesRequestEntity(
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
      // accountId: selectedAdvanceAccount?.id,
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
                    value: pickupTime?.format(context) ?? '',
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
                    value: returnTime?.format(context) ?? '',
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
                      Row(
                        children: [
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              coolingPeriodMode.isAfter
                                  ? 'After cooling'
                                  : 'Before cooling',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                coolingPeriodMode = coolingPeriodMode.isAfter
                                    ? CoolingPeriodMode.before
                                    : CoolingPeriodMode.after;
                              });
                              _updateCoolingPeriod();
                              _loadAvailableProducts();
                              _checkSelectedProductsAvailability();
                            },
                            child: Text(
                              coolingPeriodMode.isAfter ? "After" : "Before",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors
                                    .black, // change if background is dark
                              ),
                            ),
                          ),
                        ],
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
                          child: Builder(
                            builder: (context) {
                              final currentDays = coolingPeriodDays;
                              final standardValues = {
                                0,
                                1,
                                2,
                                3,
                                4,
                                5,
                                6,
                                7,
                                8,
                                9,
                                10,
                              };
                              final hasCustomValue = !standardValues.contains(
                                currentDays,
                              );
                              return DropdownButton<int>(
                                value: currentDays,
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
                                  const DropdownMenuItem(
                                    value: 0,
                                    child: Text('None'),
                                  ),
                                  if (hasCustomValue)
                                    DropdownMenuItem(
                                      value: currentDays,
                                      child: Text('$currentDays days'),
                                    ),
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
                                    _updateCoolingPeriod();
                                    _loadAvailableProducts();
                                    _checkSelectedProductsAvailability();
                                  }
                                },
                              );
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
                        // phone1 is non-nullable int — defaults to 0 when API returns null.
                        clientNameController.text = client.name;
                        _populateClientPhones(
                          phone1: client.phone1 > 0
                              ? client.phone1.toString()
                              : null,
                          phone1E164: client.phone1E164,
                          phone2: (client.phone2 ?? 0) > 0
                              ? client.phone2.toString()
                              : null,
                          phone2E164: client.phone2E164,
                        );
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
                        _populateClientPhones(phone1: null, phone2: null);
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
                      return CustomPhoneNumberField(
                        controller: _clientPhone1FieldController,
                        hintText: 'Phone',
                        readOnly: isClientSelected,
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
                      );
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Phone 2 - Disabled if client is selected
                  BlocBuilder<ClientCubit, ClientState>(
                    builder: (context, state) {
                      final isClientSelected = state.selectedClient != null;
                      return CustomPhoneNumberField(
                        controller: _clientPhone2FieldController,
                        hintText: 'Phone 2',
                        readOnly: isClientSelected,
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
                        hintText: 'Notes',
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
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
                _buildSummaryBreakdownCard(),
                const SizedBox(height: 12),
                SizedBox(
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
              ],
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
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: startLocationController,
                            hint: 'Start location',
                          ),
                          const SizedBox(height: _fieldSpacing),
                          BookingTextFieldBuilder.buildRightPanelTextField(
                            controller: pickupLocationController,
                            hint: 'Pickup location',
                          ),
                          const SizedBox(height: _fieldSpacing),
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
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: securityAmountController,
                    hint: 'Security amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: 8),
                  // Security Payment Method - show when security amount has value
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: securityAmountController,
                    builder: (context, value, child) {
                      final hasSecurityAmount =
                          value.text.trim().isNotEmpty &&
                          (int.tryParse(value.text.trim()) ?? 0) > 0;
                      if (hasSecurityAmount) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            _buildSecurityPaymentMethodSelector(),
                            const SizedBox(height: 8),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: BookingTextFieldBuilder.buildRightPanelTextField(
                          controller: discountAmountController,
                          hint: isDiscountPercentage
                              ? 'Discount %'
                              : 'Discount amount',
                          isNumber: true,
                          suffix: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: discountAmountController,
                            builder: (context, val, _) {
                              final input = val.text.trim().toIntOrNull() ?? 0;
                              final total = _getDiscountProductBase();
                              if (input <= 0 || total <= 0) {
                                return const SizedBox.shrink();
                              }
                              final String equiv;
                              if (isDiscountPercentage) {
                                final amount = (total * input / 100).round();
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
                          setState(() {
                            final switchToPercent = value == 'percentage';
                            if (switchToPercent != isDiscountPercentage) {
                              final input =
                                  discountAmountController.text
                                      .trim()
                                      .toIntOrNull() ??
                                  0;
                              final total = _getDiscountProductBase();
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
                                  final amount = (total * input / 100).round();
                                  discountAmountController.text = amount
                                      .toString();
                                }
                              }
                              isDiscountPercentage = switchToPercent;
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
                        onTap: _addAdditionalCharge,
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
                    valueListenable: additionalChargesNotifier,
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
                                      onTap: () => _removeCharge(c),
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

  Widget _buildSecurityPaymentMethodSelector() {
    return AccountSelectionField(
      selectedAccount: selectedSecurityAccount,
      initialAccountId: widget.bookingDetails?.securityAccountId,
      onChanged: (account) => setState(() => selectedSecurityAccount = account),
      label: 'Security Payment Option',
    );
  }

  Widget _buildCoolingModeOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6132E4) : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}

// Stateful widget for overlay search item with variant selection
class _OverlaySearchItem extends StatefulWidget {
  final ProductEntity product;
  final Function(ProductVariantEntity) onAddProduct;
  final Function(String imageUrl, String? title)? onImageTap;

  const _OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
    this.onImageTap,
  });

  @override
  State<_OverlaySearchItem> createState() => _OverlaySearchItemState();
}

class _OverlaySearchItemState extends State<_OverlaySearchItem> {
  ProductVariantEntity? selectedVariant;
  bool _isImageHovered = false;

  @override
  void initState() {
    super.initState();
    // Auto-select first variant for non-multi-variant products (vehicle, equipment, etc.)
    // Multi-variant products (dress, costume, gadgets) require explicit user selection
    if (!widget.product.mainServiceType.isMultiVariantProductType &&
        widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    } else {
      // Also auto-select when all variants have empty attribute (single unnamed variant)
      // — no chip will render so we must pre-select to allow adding
      final hasVisibleChip = widget.product.variants.any(
        (v) => v.attribute.isNotEmpty,
      );
      if (!hasVisibleChip && widget.product.variants.isNotEmpty) {
        selectedVariant = widget.product.variants.first;
      } else {
        selectedVariant = null;
      }
    }
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
            child: MouseRegion(
              cursor:
                  widget.product.image != null &&
                      widget.product.image!.isNotEmpty
                  ? SystemMouseCursors.click
                  : MouseCursor.defer,
              onEnter: (_) {
                if (widget.product.image != null &&
                    widget.product.image!.isNotEmpty) {
                  setState(() => _isImageHovered = true);
                }
              },
              onExit: (_) => setState(() => _isImageHovered = false),
              child: GestureDetector(
                onTap:
                    widget.product.image != null &&
                        widget.product.image!.isNotEmpty
                    ? () => widget.onImageTap?.call(
                        widget.product.image!,
                        widget.product.name,
                      )
                    : null,
                child: Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 40,
                      color: Colors.grey.shade100,
                      child: (() {
                        final thumb = widget.product.thumbnailImage;
                        final full = widget.product.image;
                        final url = (thumb != null && thumb.isNotEmpty)
                            ? thumb
                            : (full != null && full.isNotEmpty ? full : null);
                        return url != null
                            ? Image.network(
                                url,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.image_outlined,
                                  size: 20,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            : Icon(
                                Icons.image_outlined,
                                size: 20,
                                color: Colors.grey.shade400,
                              );
                      })(),
                    ),
                    if (_isImageHovered)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black45,
                          child: const Icon(
                            Icons.zoom_in,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Product Info - Fixed width
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: widget.product.name,
                  waitDuration: const Duration(milliseconds: 250),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.product.color ?? 'color',
                  style: const TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          // Divider
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
          const SizedBox(width: 12),

          // Variants or Details Section
          if (widget.product.mainServiceType.isMultiVariantProductType)
            Expanded(
              child: SizedBox(
                height: 40,
                child: variants.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // Skip chips for variants with empty attribute
                          children: variants
                              .where((v) => v.attribute.isNotEmpty)
                              .map((variant) {
                                final isSelected =
                                    selectedVariant?.id == variant.id;
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
                              })
                              .toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            )
          else
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.product.category != null &&
                      widget.product.category!.isNotEmpty)
                    Text(
                      '${widget.product.mainServiceType.categoryFieldLabel}: ${widget.product.category}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (widget.product.model != null &&
                      widget.product.model!.isNotEmpty)
                    Text(
                      '${widget.product.mainServiceType.secondaryAttributeLabel ?? "Model"}: ${widget.product.model}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if ((widget.product.category == null ||
                          widget.product.category!.isEmpty) &&
                      (widget.product.model == null ||
                          widget.product.model!.isEmpty))
                    Text(
                      widget.product.color ?? '-',
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

          const SizedBox(width: 12),
          // Divider
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
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
                    color: Colors.grey.shade600,
                  ),
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
          // Divider
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
          const SizedBox(width: 12),
          // Available Quantity section
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'avl qty',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  selectedVariant != null
                      ? '${selectedVariant!.remainingStock ?? selectedVariant!.stock}'
                      : (variants.isNotEmpty
                            ? '${variants.first.remainingStock ?? variants.first.stock}'
                            : '0'),
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
        padding: isShortText
            ? null
            : const EdgeInsets.symmetric(horizontal: 12),
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
