import 'dart:developer';
import 'dart:io';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_form_validator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_request_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/additional_charges_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_search_rules.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/new_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_list_search_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_list_table_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_search_overlay_popup.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/sales/data/models/request_sales_model/request_sales_model.dart';
import 'package:bookie_buddy_web/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab_web.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

// Conditional import for web-specific code
import '../helpers/web_helper_stub.dart'
    if (dart.library.html) '../helpers/web_helper_web.dart'
    as web_helper;
import 'package:url_launcher/url_launcher.dart';

part '../helpers/booking_phone_helper.dart';
part '../widgets/booking_content_widget.dart';
part '../widgets/sales_content_widget.dart';
part '../widgets/old_booking_content_widget.dart';
part '../widgets/product_search_helper.dart';
part '../widgets/product_filter_dialog.dart';
part '../widgets/booking_date_section_widget.dart';
part '../widgets/booking_success_dialog.dart';
// import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_product_helpers.dart';
// import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/product_mapper.dart';
// import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/product_stock_validator.dart';
// import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/selected_products_manager.dart';

class OldNewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const OldNewBookingScreen({super.key, this.onClose});

  @override
  State<OldNewBookingScreen> createState() => OldNewBookingScreenState();
}

class OldNewBookingScreenState extends State<OldNewBookingScreen> {
  // Current selected tab
  BookingType selectedBookingType = BookingType.booking;

  bool get _hasSalesFeature =>
      context.read<UserCubit>().hasFeature(AppPremiumFeatures.sales);

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
  AccountEntity? selectedAdvanceAccount;
  AccountEntity? selectedSecurityAccount;
  DeliveryStatus deliveryStatus = DeliveryStatus.booked;
  bool sendPdfToWhatsApp = false;
  bool decreaseStockForPastDate = false;
  bool isDiscountPercentage = false;
  final _discountTypeNotifier = ValueNotifier<bool>(false);

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
  bool _showAllProductsOnSearchFocus = false;
  final ScrollController _searchResultsScrollController = ScrollController();
  // Reactive overlay state — updated without rebuilding the OverlayEntry
  final _overlayProducts = ValueNotifier<List<ProductEntity>>([]);
  final _overlayIsLoading = ValueNotifier<bool>(false);

  // Product search filter state
  List<String> _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  MainServiceType? _currentServiceType;
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);

  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  // New Fields for Redesign
  int coolingPeriodDays = 0; // Default to None (0 = same as return date)
  CoolingPeriodMode coolingPeriodMode =
      CoolingPeriodMode.after; // User-selected cooling period mode
  DateTime? _bookedDate; // Optional for old booking entries
  int _manualExtraRentalDays = 0; // Optional extra days added by user
  final runningKilometersController = TextEditingController();

  // Step state
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;
  String? _phone2Error;
  final startLocationController = TextEditingController();
  final pickupLocationController = TextEditingController();
  final destinationLocationController = TextEditingController();

  // Inline editing state (managed by ProductListTableWidget)
  final Map<int, FocusNode> _overlayItemFocusNodes = {};
  // final Map<int, FocusNode> _overlayItemFocusNodes = {};

  // (payment method state removed — now handled by AccountSelectionField)

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Focus nodes for client details navigation
  final _clientNameFocusNode = FocusNode();
  final _productSearchFocusNode = FocusNode();
  final _pickupDateFocusNode = FocusNode();
  final _pickupTimeFocusNode = FocusNode();
  final _returnDateFocusNode = FocusNode();
  final _returnTimeFocusNode = FocusNode();
  final _coolingPeriodFocusNode = FocusNode();
  final _clientPhone1FocusNode = FocusNode();
  final _clientPhone2FocusNode = FocusNode();
  final _clientAddressFocusNode = FocusNode();
  final _staffNameFocusNode = FocusNode();
  final _notesFocusNode = FocusNode();
  final _advanceAmountFocusNode = FocusNode();
  final _securityAmountFocusNode = FocusNode();
  final _discountAmountFocusNode = FocusNode();

  // Customization state
  bool showCustomization = false;
  final _loadProductsDebouncer = Debouncer(
    delay: const Duration(milliseconds: 300),
  );

  // Summary expansion state
  bool _isSummaryExpanded = false;

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

    // Add listener to client name controller to detect manual changes
    clientNameController.addListener(_onClientNameChanged);
    clientPhone1Controller.addListener(_onClientPhoneChanged);
    clientPhone2Controller.addListener(_onClientPhoneChanged);
    _searchResultsScrollController.addListener(_handleSearchOverlayScroll);

    // Set up web before unload listener to prevent accidental browser close
    if (kIsWeb) {
      web_helper.setupBeforeUnloadListener(() => hasUnsavedChanges());
    }

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      // Load staffs for staff search dropdown
      context.read<StaffSearchCubit>().clearSelectedStaff();
      staffNameController.clear();
      context.read<StaffSearchCubit>().getAllStaffs();

      // Initialize cooling period based on shop settings (TC-01-03)
      _initializeCoolingPeriod();

      // Load available products after cooling period is set (use next frame to ensure state is updated)
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _loadProductsForService(selectedServiceId);
        }
      });
    });
  }

  @override
  void dispose() {
    // Remove web before unload listener
    if (kIsWeb) {
      web_helper.removeBeforeUnloadListener();
    }

    _removeSearchOverlay();
    clientNameController.removeListener(_onClientNameChanged);
    clientPhone1Controller.removeListener(_onClientPhoneChanged);
    clientPhone2Controller.removeListener(_onClientPhoneChanged);
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    _clientPhone1FieldController.dispose();
    _clientPhone2FieldController.dispose();
    clientAddressController.dispose();
    startLocationController.dispose();
    pickupLocationController.dispose();
    destinationLocationController.dispose();
    for (final focusNode in _overlayItemFocusNodes.values) {
      focusNode.dispose();
    }
    _clientNameFocusNode.dispose();
    _productSearchFocusNode.dispose();
    _pickupDateFocusNode.dispose();
    _pickupTimeFocusNode.dispose();
    _returnDateFocusNode.dispose();
    _returnTimeFocusNode.dispose();
    _coolingPeriodFocusNode.dispose();
    _clientPhone1FocusNode.dispose();
    _clientPhone2FocusNode.dispose();
    _clientAddressFocusNode.dispose();
    _staffNameFocusNode.dispose();
    _notesFocusNode.dispose();
    _advanceAmountFocusNode.dispose();
    _securityAmountFocusNode.dispose();
    _discountAmountFocusNode.dispose();
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
    _discountTypeNotifier.dispose();
    _searchResultsScrollController.removeListener(_handleSearchOverlayScroll);
    _searchResultsScrollController.dispose();
    super.dispose();
  }

  String? _buildDescriptionWithPaymentSummary() {
    final description = descriptionController.text.trim();
    return description.isEmpty ? null : description;
  }

  /// Check if there are any unsaved changes
  bool hasUnsavedChanges() {
    // Check if products are selected
    if (selectedProductsNotifier.value.isNotEmpty) return true;
    if (_manualExtraRentalDays > 0) return true;

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
    // Close search overlay if open to prevent UI conflict
    _removeSearchOverlay();

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

    // Close search overlay if open to prevent UI conflict
    _removeSearchOverlay();

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
    _bookedDate = null;
    _manualExtraRentalDays = 0;
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

  /// Listener for client name changes to detect manual editing
  void _onClientNameChanged() {
    // Clear validation error when user types
    if (_clientNameError != null &&
        clientNameController.text.trim().isNotEmpty) {
      setState(() {
        _clientNameError = null;
      });
    }

    // Get the current selected client from the cubit
    final selectedClient = context.read<ClientCubit>().state.selectedClient;

    // If a client is selected but the name has been manually changed
    if (selectedClient != null && selectedClientId != null) {
      final currentName = clientNameController.text.trim();
      final selectedClientName = selectedClient.name.trim();

      // If the names don't match, user has manually edited - treat as new client
      if (currentName != selectedClientName) {
        setState(() {
          selectedClientId = null;
        });
        // Clear the selected client in the cubit
        context.read<ClientCubit>().clearSelected();
      }
    }
  }

  /// Listener for phone changes to detect manual editing
  void _onClientPhoneChanged() {
    // Clear validation errors when user types
    if (_phoneError != null && clientPhone1Controller.text.trim().isNotEmpty) {
      setState(() {
        _phoneError = null;
      });
    }
    if (_phone2Error != null) {
      setState(() {
        _phone2Error = null;
      });
    }

    // Get the current selected client from the cubit
    final selectedClient = context.read<ClientCubit>().state.selectedClient;

    // If a client is selected but phone has been manually changed
    if (selectedClient != null && selectedClientId != null) {
      final currentPhone1 = clientPhone1Controller.text.trim();
      final currentPhone2 = clientPhone2Controller.text.trim();
      final selectedPhone1 = selectedClient.phone1 > 0
          ? selectedClient.phone1.toString().trim()
          : extractPhoneFromE164(selectedClient.phone1E164);
      final selectedPhone2 = (selectedClient.phone2 ?? 0) > 0
          ? selectedClient.phone2.toString().trim()
          : extractPhoneFromE164(selectedClient.phone2E164);

      // If phones don't match, user has manually edited - treat as new client
      if (currentPhone1 != selectedPhone1 || currentPhone2 != selectedPhone2) {
        setState(() {
          selectedClientId = null;
        });
        // Clear the selected client in the cubit
        context.read<ClientCubit>().clearSelected();
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

    final productResult = BookingFormValidator.validateProductSelection(
      selectedProductsNotifier.value,
    );
    if (!productResult.isValid) {
      context.showSnackBar(productResult.errors.first, isError: true);
      return;
    }

    final staffState = context.read<StaffSearchCubit>().state;
    final selectedStaff = staffState.selectedStaff;

    final clientResult = BookingFormValidator.validateClientDetails(
      clientName: clientNameController.text,
      phone1: clientPhone1Controller.text,
      phone2: clientPhone2Controller.text,
      address: clientAddressController.text,
      documentsCount: documentsNotifier.value.length,
      selectedStaffId: selectedStaff?.id,
      staffName: staffNameController.text,
      isSalesMode: selectedBookingType == BookingType.sales,
    );

    if (clientResult.isValid) {
      _removeSearchOverlay();
      setState(() => _bookingStep = 1);
    } else {
      setState(() {
        _clientNameError = clientResult.fieldErrors['clientName'];
        _phoneError = clientResult.fieldErrors['phone1'];
        _phone2Error = clientResult.fieldErrors['phone2'];
        _staffNameError = clientResult.fieldErrors['staff'];
      });
      context.showSnackBar(
        clientResult.errors.join(', '),
        isError: true,
        title: 'Validation Error',
      );
    }
  }




  int _calculateRentalDays() => PaymentCalculator.calculateRentalDays(
    pickupDate: pickupDate,
    returnDate: returnDate,
    pickupTime: pickupTime,
    returnTime: returnTime,
  );

  int _getEffectiveRentalDays() {
    final baseDays = _calculateRentalDays();
    final totalDays = baseDays + _manualExtraRentalDays;
    return totalDays > 0 ? totalDays : 1;
  }

  int _getDaysMultiplierForProduct(ProductSelectedEntity product) {
    if (selectedBookingType == BookingType.sales) return 1;
    if (!_shouldMultiplyByDays(product.variant.mainServiceType)) return 1;
    return _getEffectiveRentalDays();
  }

  void _incrementRentalDays() {
    setState(() {
      _manualExtraRentalDays += 1;
    });
  }

  void _decrementRentalDays() {
    if (_manualExtraRentalDays == 0) return;
    setState(() {
      _manualExtraRentalDays -= 1;
    });
  }

  int _calculateBookingTotalPayable() {
    final discountInput = discountAmountController.text.trim().toIntOrNull() ?? 0;
    return PaymentCalculator.calculateBookingTotalPayable(
      selectedProducts: selectedProductsNotifier.value,
      additionalCharges: additionalChargesNotifier.value,
      discountAmount: discountInput,
      isDiscountPercentage: isDiscountPercentage,
      bookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
    );
  }

  int _getDiscountProductBase() {
    return PaymentCalculator.getDiscountProductBase(
      selectedProducts: selectedProductsNotifier.value,
      additionalCharges: additionalChargesNotifier.value,
      bookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
    );
  }


  void _loadProductsForService(int? serviceId) {
    _loadProductsDebouncer.run(() {
      _loadProductsInternal(serviceId);
    });
  }

  void _loadProductsInternal(int? serviceId) {
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    // If "All Services" is selected (-1), pass null to API
    final serviceIdToUse = (serviceId == null || serviceId == -1)
        ? null
        : serviceId;

    final effectivePickupDate = BookingDateCalculator.effectivePickupDate(
      pickupDate: pickupDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectiveReturnDate = BookingDateCalculator.effectiveReturnDateStr(
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );

    log(
      '📦 Loading products - pickupDate: ${pickupDate.format()}, effectivePickupDate: ${effectivePickupDate.format()}, returnDate: $effectiveReturnDate, coolingPeriodDays: $coolingPeriodDays, coolingMode: ${coolingPeriodMode.value}, isBooking: $isBooking',
    );

    // Include selected variant IDs so the single API call also checks their availability.
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
        useAvailableProductsApi: isBooking,
        isSales: isSales,
        variantIds: currentVariantIds.isNotEmpty ? currentVariantIds : null,
      ),
    );
  }

  /// Helper method to check if current pickup date (sale date) is in the past
  bool _isPastDate() {
    final today = DateTime.now().dateOnly;
    return pickupDate.dateOnly.isBefore(today);
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
              // New app bar with tabs and shop selector
              NewBookingAppBar(
                selectedTab: _convertBookingTypeToTabType(selectedBookingType),
                onTabChanged: (tabType) {
                  _handleTabSwitch(_convertTabTypeToBookingType(tabType));
                },
                onBack: _handleBackNavigation,
                showSalesTab: _hasSalesFeature,
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

  BookingTabType _convertBookingTypeToTabType(BookingType type) {
    switch (type) {
      case BookingType.booking:
        return BookingTabType.booking;
      case BookingType.sales:
        return BookingTabType.sales;
      case BookingType.customWork:
        return BookingTabType.customWork;
      case BookingType.oldBooking:
        return BookingTabType.oldBooking;
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
      case BookingTabType.oldBooking:
        return BookingType.oldBooking;
    }
  }

  Widget _buildMainContent() {
    if (selectedBookingType == BookingType.customWork) {
      return Container(child: Center(child: Text('Custom Work - Coming Soon')));
    }
    if (selectedBookingType == BookingType.oldBooking) {
      return _buildOldBookingContent();
    }
    // Same UI for both booking and sales
    return _buildBookingContent();
  }

  void _showTimeError(String message) {
    context.showSnackBar(message, isError: true);
  }

  /// Helper: Initialize cooling period on first load based on shop settings
  /// Implements TC-01 through TC-03
  void _initializeCoolingPeriod() {
    final userCubit = context.read<UserCubit>();
    final coolingDuration =
        userCubit.state?.shopSettings.coolingPeriodDuration ?? 0;
    final coolingMode =
        userCubit.state?.shopSettings.coolingPeriodMode ??
        CoolingPeriodMode.after;

    setState(() {
      coolingPeriodDays = coolingDuration;
      coolingPeriodMode = coolingMode;
      _updateCoolingPeriod();
    });
  }

  void _updateCoolingPeriod() {
    coolingPeriodDate = BookingDateCalculator.coolingPeriodDate(
      pickupDate: pickupDate,
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
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
          Expanded(
            child: ProductListTableWidget(
              selectedProductsNotifier: selectedProductsNotifier,
              selectedBookingType: selectedBookingType,
              effectiveRentalDays: _getEffectiveRentalDays(),
              manualExtraRentalDays: _manualExtraRentalDays,
              clientNameFocusNode: _clientNameFocusNode,
              onIncrementRentalDays: _incrementRentalDays,
              onDecrementRentalDays: _decrementRentalDays,
            ),
          ),
        ],
      ),
    );
  }

  double get getAccountSelectionFieldWidth => context.screenWidth * 0.25;

  Widget _buildPaymentMethodSection({String label = 'Payment Option'}) {
    return AccountSelectionField(
      selectedAccount: selectedAdvanceAccount,
      onChanged: (account) => setState(() => selectedAdvanceAccount = account),
      label: label,
    );
  }

  Widget _buildSecurityPaymentMethodSelector() {
    return AccountSelectionField(
      selectedAccount: selectedSecurityAccount,
      onChanged: (account) => setState(() => selectedSecurityAccount = account),
      label: 'Security Payment Option',
    );
  }

  bool _shouldMultiplyByDays(MainServiceType? serviceType) =>
      PaymentCalculator.shouldMultiplyByDays(serviceType);

  Widget _buildSummarySection() {
    return BookingSummarySection(
      selectedProductsNotifier: selectedProductsNotifier,
      additionalChargesNotifier: additionalChargesNotifier,
      advanceAmountController: advanceAmountController,
      discountAmountController: discountAmountController,
      isDiscountPercentage: _discountTypeNotifier,
      securityAmountController: securityAmountController,
      securityMethodLabel: selectedSecurityAccount?.accountName ?? 'Cash',
      isSales: selectedBookingType == BookingType.sales,
      calculateRentalDays: _getEffectiveRentalDays,
      advanceLabel: 'Advance',
      onShowCustomization: () => setState(() => showCustomization = true),
      onConfirm: _handleConfirmBooking,
      confirmLabel: selectedBookingType == BookingType.sales
          ? 'Confirm Sales'
          : 'Confirm Booking',
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

  void _addAdditionalCharge() =>
      AdditionalChargesManager.showAddChargeDialog(
          context, additionalChargesNotifier);

  void _removeCharge(AdditionalChargesEntity charge) =>
      AdditionalChargesManager.removeCharge(charge, additionalChargesNotifier);

  void _handleConfirmBooking() async {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = selectedProductsNotifier.value;

    final productResult = BookingFormValidator.validateProductSelection(products);
    if (!productResult.isValid) {
      context.showSnackBar(productResult.errors.first, isError: true);
      return;
    }

    final paymentResult = BookingFormValidator.validatePayment(
      bookingType: selectedBookingType,
      advanceAmount: advanceAmountController.text.trim().toIntOrNull() ?? 0,
      securityAmount: securityAmountController.text.trim().toIntOrNull() ?? 0,
      totalPayable: _calculateBookingTotalPayable(),
      advanceAccount: selectedAdvanceAccount,
      securityAccount: selectedSecurityAccount,
    );
    if (!paymentResult.isValid) {
      context.showSnackBar(paymentResult.errors.first, isError: true);
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final repository = getIt<IBookingRepository>();

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
        log('Booking Request: ${bookingRequest.toString()}');

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

  BookingRequestEntity _buildBookingRequest() {
    final staffState = context.read<StaffSearchCubit>().state;
    return BookingRequestBuilder.buildBookingRequest(
      products: selectedProductsNotifier.value,
      additionalCharges: additionalChargesNotifier.value,
      bookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
      runningKm: runningKilometersController.text.trim(),
      discountInput: discountAmountController.text.trim().toIntOrNull() ?? 0,
      isDiscountPercentage: isDiscountPercentage,
      staffId: staffState.selectedStaff?.id,
      selectedClientId: selectedClientId,
      clientName: clientNameController.text.trim(),
      phone1Raw: clientPhone1Controller.text.trim(),
      phone2Raw: clientPhone2Controller.text.trim(),
      address: clientAddressController.text.trim(),
      locationStart: startLocationController.text.trim(),
      locationFrom: pickupLocationController.text.trim(),
      locationTo: destinationLocationController.text.trim(),
      coolingPeriodDays: coolingPeriodDays,
      coolingPeriodMode: coolingPeriodMode,
      pickupDate: pickupDate,
      returnDate: returnDate,
      advanceAmount: advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: securityAmountController.text.trim().toIntOrNull(),
      securityAccountId: selectedSecurityAccount?.id,
      advanceAccount: selectedAdvanceAccount,
      deliveryStatus: deliveryStatus,
      description: _buildDescriptionWithPaymentSummary(),
      pickupTime: pickupTime,
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
    );
  }

  RequestSalesModel _buildSalesRequest() {
    final staffState = context.read<StaffSearchCubit>().state;
    return BookingRequestBuilder.buildSalesRequest(
      products: selectedProductsNotifier.value,
      discountInput: discountAmountController.text.trim().toIntOrNull() ?? 0,
      isDiscountPercentage: isDiscountPercentage,
      staffId: staffState.selectedStaff?.id,
      clientPhone: clientPhone1Controller.text.trim(),
      clientAddress: clientAddressController.text.trim(),
      saleDate: pickupDate,
      description: _buildDescriptionWithPaymentSummary(),
      sendInvoice: sendPdfToWhatsApp,
      accountId: selectedAdvanceAccount?.id,
      decreaseStockForPastDate: decreaseStockForPastDate,
      isPastDate: _isPastDate(),
    );
  }

}
