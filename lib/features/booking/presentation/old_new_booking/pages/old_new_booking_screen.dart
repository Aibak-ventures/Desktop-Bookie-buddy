import 'dart:developer';
import 'dart:io';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/utils/debouncer.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_other_details_entity/booking_other_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/new_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/data/repositories/product_repository_impl.dart';
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
  PaymentMethod paymentMethod = PaymentMethod.cash;
  PaymentMethod securityPaymentMethod = PaymentMethod.cash;
  DeliveryStatus deliveryStatus = DeliveryStatus.booked;
  bool sendPdfToWhatsApp = false;
  bool decreaseStockForPastDate = false;
  bool isDiscountPercentage = false;

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

  // Update search types based on service type
  void _updateSearchTypesForService(int? serviceId) {
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    // Find the service and get its main service type
    if (serviceId == null || serviceId == -1) {
      _currentServiceType = null;
      _searchTypes = ['Name', 'Category', 'Model', 'Color'];
    } else {
      final service = services.firstWhere(
        (s) => s.id == serviceId,
        orElse: () => services.first,
      );
      _currentServiceType = MainServiceType.fromString(service.mainServiceName);

      // Update search types based on service-specific field labels
      final categoryLabel = _currentServiceType
          .categoryFieldLabel; // e.g., "Brand" for vehicle, "Fabric Type" for material
      final secondaryLabel =
          _currentServiceType.secondaryAttributeLabel ??
          'Color'; // e.g., "Model" for vehicle, "Color" for dress

      if (_currentServiceType.isMultiVariantProductType) {
        // For multi-variant types (Dress, Costume, Gadgets): show variant-specific label
        final variantLabel = _currentServiceType.variantAttributeLabel;
        _searchTypes = ['Name', categoryLabel, secondaryLabel, variantLabel];
      } else {
        // For non-multi-variant types (Vehicle, Jewellery, etc.): use service-specific labels
        _searchTypes = ['Name', categoryLabel, secondaryLabel, 'Color'];
      }
    }
  }

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

  // Inline editing state
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();
  final Map<int, TextEditingController> _quantityControllers = {};
  final Map<int, FocusNode> _quantityFocusNodes = {};
  final Map<int, FocusNode> _overlayItemFocusNodes = {};

  // State variables for payment methods
  List<PaymentMethod> _selectedPaymentMethods = [PaymentMethod.cash];

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

    // Set up web beforeunload listener to prevent accidental browser close
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
    // Remove web beforeunload listener
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
    _inlinePriceController.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _quantityFocusNodes.values) {
      focusNode.dispose();
    }
    for (final focusNode in _overlayItemFocusNodes.values) {
      focusNode.dispose();
    }
    _inlinePriceFocusNode.dispose();
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
    _searchResultsScrollController.removeListener(_handleSearchOverlayScroll);
    _searchResultsScrollController.dispose();
    super.dispose();
  }

  void _togglePaymentMethodSelection(PaymentMethod method) {
    setState(() {
      _selectedPaymentMethods = [method];
      paymentMethod = method;
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

  String? _currentPhoneE164(
    TextEditingController textController,
    PhoneController phoneController,
  ) {
    final rawPhone = textController.text.trim();
    if (rawPhone.isEmpty) return null;

    return toPhone1E164(
      rawPhone,
      fallbackE164: phoneNumberToE164(phoneController.value),
    );
  }

  String? _buildDescriptionWithPaymentSummary() {
    final description = descriptionController.text.trim();
    if (_selectedPaymentMethods.length <= 1) {
      return description.isEmpty ? null : description;
    }

    final paymentSummary =
        'Payment methods: ${_selectedPaymentMethods.map((method) => method.name).join(', ')}';
    if (description.isEmpty) {
      return paymentSummary;
    }

    return '$description\n$paymentSummary';
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _showAllProductsOnSearchFocus = false;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
  }

  void _handleSearchOverlayScroll() {
    if (!_searchResultsScrollController.hasClients) return;
    final position = _searchResultsScrollController.position;
    if (position.pixels < position.maxScrollExtent - 180) return;
    _selectProductBloc.state.maybeWhen(
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
          ) {
            if (isPaginating || nextPageUrl == null) return;
            if (isSearching) {
              _selectProductBloc.add(
                const SelectProductEvent.loadNextSearchResults(),
              );
            } else {
              _selectProductBloc.add(
                const SelectProductEvent.loadNextPageProducts(),
              );
            }
          },
      orElse: () {},
    );
  }

  void _searchAllProductsForOverlay() {
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    _showAllProductsOnSearchFocus = true;
    _overlayIsLoading.value = true;
    if (_searchOverlayEntry == null) {
      _showSearchOverlay();
    }

    _selectProductBloc.add(
      SelectProductEvent.searchProducts(
        serviceId: serviceIdToUse,
        query: '',
        type: 'name',
        startPrice: _isPriceFilterEnabled.value
            ? _priceRange.value.start.round()
            : null,
        endPrice: _isPriceFilterEnabled.value
            ? _priceRange.value.end.round()
            : null,
        pickupDate: pickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: isBooking,
        isSales: isSales,
      ),
    );
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

    // Validate at least one product is selected
    final selectedProducts = selectedProductsNotifier.value;
    if (selectedProducts.isEmpty) {
      context.showSnackBar(
        'Please select at least one product to continue',
        isError: true,
      );
      return;
    }

    // Validate at least one product has price > 0
    final hasProductWithPrice = selectedProducts.any((p) => p.amount > 0);
    if (!hasProductWithPrice) {
      context.showSnackBar(
        'At least one product must have a price greater than 0',
        isError: true,
      );
      return;
    }

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
      isSalesMode: selectedBookingType == BookingType.sales,
    );

    if (validationResult.isValid) {
      // Close search overlay before changing steps to prevent UI conflict
      _removeSearchOverlay();
      // Move to next step
      setState(() => _bookingStep = 1);
    } else {
      setState(() {
        _clientNameError = validationResult.fieldErrors['clientName'];
        _phoneError = validationResult.fieldErrors['phone1'];
        _phone2Error = validationResult.fieldErrors['phone2'];
        _staffNameError = validationResult.fieldErrors['staff'];
      });
      // Show the first error as a snackbar so the user knows what to fix
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

    // Filter out material services for booking/sales (only show in stock listing)
    services = services
        .where((s) => !s.mainServiceName.toLowerCase().contains('material'))
        .toList();

    // Setup local state for dialog
    final isPriceFilterEnabledWidgetNotifier = ValueNotifier(
      _isPriceFilterEnabled.value,
    );
    final tempSelectedServiceId = ValueNotifier<int?>(selectedServiceId);
    final tempSelectedSearchTypeIndex = ValueNotifier<int>(
      _selectedSearchTypeIndex.value,
    );
    final tempPriceRange = ValueNotifier<RangeValues>(_priceRange.value);
    final tempMaxPriceNotifier = ValueNotifier<double>(_maxPriceNotifier.value);
    final maxPriceController = TextEditingController(
      text: _maxPriceNotifier.value.toInt().toString(),
    );

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
                                  // Update search types when service changes
                                  if (id == -1) {
                                    _currentServiceType = null;
                                    _searchTypes = [
                                      'Name',
                                      'Category',
                                      'Model',
                                      'Color',
                                    ];
                                  } else {
                                    final service = services.firstWhere(
                                      (s) => s.id == id,
                                      orElse: () => services.first,
                                    );
                                    _currentServiceType =
                                        MainServiceType.fromString(
                                          service.mainServiceName,
                                        );

                                    // Update search types based on service-specific field labels
                                    final categoryLabel = _currentServiceType
                                        .categoryFieldLabel; // e.g., "Brand" for vehicle, "Fabric Type" for material
                                    final secondaryLabel =
                                        _currentServiceType
                                            .secondaryAttributeLabel ??
                                        'Color'; // e.g., "Model" for vehicle, "Color" for dress

                                    // Update search types based on whether the service has variants
                                    if (_currentServiceType
                                        .isMultiVariantProductType) {
                                      // For multi-variant types: show variant-specific label
                                      final variantLabel = _currentServiceType
                                          .variantAttributeLabel;
                                      _searchTypes = [
                                        'Name',
                                        categoryLabel,
                                        secondaryLabel,
                                        variantLabel,
                                      ];
                                    } else {
                                      // For non-multi-variant types: use service-specific labels
                                      _searchTypes = [
                                        'Name',
                                        categoryLabel,
                                        secondaryLabel,
                                        'Color',
                                      ];
                                    }
                                  }
                                  // Reset search type index if current selection is out of bounds
                                  if (tempSelectedSearchTypeIndex.value >=
                                      _searchTypes.length) {
                                    tempSelectedSearchTypeIndex.value = 0;
                                  }
                                  // Force UI rebuild by notifying the ValueNotifier
                                  final currentIndex =
                                      tempSelectedSearchTypeIndex.value;
                                  tempSelectedSearchTypeIndex.value = -1;
                                  tempSelectedSearchTypeIndex.value =
                                      currentIndex;
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
                                        Container(
                                          width: 130,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: maxPriceController,
                                            keyboardType: TextInputType.number,
                                            onTapOutside: (_) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Inter',
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
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
                                                    double.tryParse(value);
                                                if (newMaxPrice != null) {
                                                  tempMaxPriceNotifier.value =
                                                      newMaxPrice;
                                                  if (tempPriceRange.value.end >
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
                                                          newMaxPrice,
                                                        );
                                                  }
                                                }
                                              }
                                            },
                                          ),
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
                                            valueListenable:
                                                tempMaxPriceNotifier,
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
                                      valueListenable: tempMaxPriceNotifier,
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
                          tempMaxPriceNotifier.value = _maxPriceNotifier.value;
                          maxPriceController.text = _maxPriceNotifier.value
                              .toInt()
                              .toString();
                          tempPriceRange.value = RangeValues(
                            0,
                            tempMaxPriceNotifier.value,
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
                            _maxPriceNotifier.value =
                                tempMaxPriceNotifier.value;
                            _isPriceFilterEnabled.value =
                                isPriceFilterEnabledWidgetNotifier.value;
                            // Update search types based on the selected service
                            _updateSearchTypesForService(selectedServiceId);
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
    final searchTerm = serviceSearchController.text.trim().toLowerCase();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

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
        // Dynamic search type based on service
        if (_currentServiceType != null) {
          if (_currentServiceType.isMultiVariantProductType) {
            // For multi-variant: use size or serial_number
            if (_currentServiceType == MainServiceType.dress ||
                _currentServiceType == MainServiceType.costume) {
              searchType = 'size';
            } else if (_currentServiceType == MainServiceType.gadgets) {
              searchType = 'serial_number';
            } else {
              searchType = 'variant';
            }
          } else {
            // For non-multi-variant: use color
            searchType = 'color';
          }
        } else {
          searchType = 'color';
        }
        break;
    }

    // Ensure we always have a valid search type when a query exists.
    searchType ??= 'name';

    // Check if any filter is applied
    final hasSearchQuery = searchTerm.isNotEmpty;
    final hasAnyFilter = hasSearchQuery || isPriceEnabled;

// Trigger search with filters
    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: hasSearchQuery ? searchTerm : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: isPriceEnabled ? priceRange.start.round() : null,
          endPrice: isPriceEnabled ? priceRange.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
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
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }

  void _onSearchChanged([String? newValue]) {
    // Allow search even if selectedServiceId is null (All Services)
    final query = (newValue ?? serviceSearchController.text)
        .trim()
        .toLowerCase();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final hasSearchQuery = query.isNotEmpty;
    final hasPriceFilter = _isPriceFilterEnabled.value;

    final hasAnyFilter = hasSearchQuery || hasPriceFilter;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    // Debug log to trace search behavior
    log(
      '_onSearchChanged -> query: "$query", hasSearchQuery: $hasSearchQuery, hasPriceFilter: $hasPriceFilter, searchTypeIndex: ${_selectedSearchTypeIndex.value}, hasAnyFilter: $hasAnyFilter',
    );

    if (!hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
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
          // Dynamic search type based on service
          if (_currentServiceType != null) {
            if (_currentServiceType.isMultiVariantProductType) {
              // For multi-variant: use size or serial_number
              if (_currentServiceType == MainServiceType.dress ||
                  _currentServiceType == MainServiceType.costume) {
                searchType = 'size';
              } else if (_currentServiceType == MainServiceType.gadgets) {
                searchType = 'serial_number';
              } else {
                searchType = 'variant';
              }
            } else {
              // For non-multi-variant: use color
              searchType = 'color';
            }
          } else {
            searchType = 'color';
          }
          break;
      }

      // Ensure we have a fallback search type
      searchType ??= 'name';

      log('_onSearchChanged -> dispatching searchProducts, type: $searchType');
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: hasSearchQuery ? query : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: hasPriceFilter ? _priceRange.value.start.round() : null,
          endPrice: hasPriceFilter ? _priceRange.value.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }

  /// Get variant display text for product in table
  String _getVariantDisplayText(ProductSelectedEntity product) {
    final mainServiceType = product.variant.mainServiceType;

    // For multi-variant product types (dress, costume, gadgets),
    // show the variant attribute (size/serial number)
    if (mainServiceType.isMultiVariantProductType) {
      return product.variant.variantAttribute?.isNotEmpty ?? false
          ? product.variant.variantAttribute!
          : '-';
    }

    // For non-multi-variant products, keep it blank
    return '';
  }

  /// Calculate number of days between pickup and return dates
  /// Below 24 hours = 1 day, Above 24 hours = 2 days, etc.
  /// Considers the actual time component for accurate 24-hour period calculation
  int _calculateRentalDays() {
    // Default pickup time: 23:59 if not selected
    final pickupDateTime = DateTime(
      pickupDate.year,
      pickupDate.month,
      pickupDate.day,
      pickupTime?.hour ?? 23,
      pickupTime?.minute ?? 59,
    );

    // Default return time: 00:00 if not selected
    final returnDateTime = DateTime(
      returnDate.year,
      returnDate.month,
      returnDate.day,
      returnTime?.hour ?? 0,
      returnTime?.minute ?? 0,
    );

    // Safety: return date must be after pickup
    if (!returnDateTime.isAfter(pickupDateTime)) {
      return 1;
    }

    final difference = returnDateTime.difference(pickupDateTime);

    // Convert to hours (include minutes precision)
    final hours = difference.inMinutes / 60;

    // Business rule:
    // Below 24 hours = 1 day
    // Every started 24h block = +1 day
    return hours <= 24 ? 1 : (hours / 24).ceil();
  }

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

  /// Get service-specific specification text for product
  String _getProductSpecifications(ProductSelectedEntity product) {
    // final mainServiceType = product.variant.mainServiceType;
    final List<String> specs = [];

    // Add category (with service-specific label)
    if (product.variant.category != null &&
        product.variant.category!.isNotEmpty) {
      specs.add(product.variant.category!);
    }

    // Add model/secondary attribute if available
    if (product.variant.model != null && product.variant.model!.isNotEmpty) {
      specs.add(product.variant.model!);
    }

    // Add color if not already shown
    if (product.variant.color != null && product.variant.color!.isNotEmpty) {
      if (!specs.contains(product.variant.color)) {
        specs.add(product.variant.color!);
      }
    }

    return specs.isNotEmpty ? specs.join(' • ') : '-';
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

    // When cooling period mode is "before", adjust the effective pickup date for availability check
    final effectivePickupDate =
        isBooking && coolingPeriodMode.isBefore && coolingPeriodDays > 0
        ? pickupDate.subtract(Duration(days: coolingPeriodDays))
        : pickupDate;

    // For booking mode + after cooling: extend return date by cooling days.
    // Before mode only adjusts pickup side — return date is unchanged.
    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

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

  /// Perform a quick local filter on the currently loaded products
  /// and show results immediately in the overlay. This avoids waiting
  /// for server responses for single-character queries.
  void _showLocalFilteredResults(String rawQuery) {
    final q = rawQuery.toLowerCase();

    // Get products from current bloc state if available
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

    if (currentProducts.isEmpty) return;

    final filtered = currentProducts.where((p) {
      final name = p.name.toLowerCase();
      final color = p.color?.toLowerCase() ?? '';
      final category = p.category?.toLowerCase() ?? '';
      final model = p.model?.toLowerCase() ?? '';
      final variantMatch = p.variants.any(
        (v) => v.attribute.toLowerCase().contains(q),
      );

      // Default to name + variant attribute
      return name.contains(q) ||
          color.contains(q) ||
          category.contains(q) ||
          model.contains(q) ||
          variantMatch;
    }).toList();

    _overlayIsLoading.value = false;
    _overlayProducts.value = filtered;
    if (_searchOverlayEntry == null) {
      _showSearchOverlay();
    }
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
                          selectedProducts: selectedProductsNotifier.value
                              .where(
                                (p) =>
                                    (p.variant.mainServiceType?.isDress ??
                                        false) ||
                                    (p.variant.mainServiceType?.isCostume ??
                                        false),
                              )
                              .toList(),
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
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final today = DateTime.now().dateOnly;
    final oldBookingMinDate = DateTime(2015);

    if (isPickup) {
      // PICKUP DATE PICKER (or SALE DATE for sales mode)
      // For sales: only today or past dates (up to 1 year)
      // For bookings: can be past (up to 1 year) or future (up to 1 year)
      final picked = await showDatePicker(
        context: context,
        initialDate: pickupDate,
        firstDate: isOldBooking
            ? oldBookingMinDate
            : DateTime.now().subtract(const Duration(days: 365)),
        lastDate: (isSales || isOldBooking)
            ? DateTime.now()
            : DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.arrowRight):
                  NextFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowDown):
                  NextFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowLeft):
                  PreviousFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowUp):
                  PreviousFocusIntent(),
            },
            child: Focus(
              autofocus: true,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: Color(0xFF6132E4)),
                ),
                child: child!,
              ),
            ),
          );
        },
      );

      if (picked != null) {
        setState(() {
          pickupDate = picked;

          // Check if past date for sales mode
          if (isSales) {
            // final today = DateTime.now().dateOnly;
            // final isPastDate = picked.dateOnly.isBefore(today);
            // Show checkbox only for past dates
            decreaseStockForPastDate =
                false; // Reset checkbox when date changes
          }

          // RIPPLE EFFECT: If pickup > return, push return forward
          if (picked.dateOnly.isAfter(returnDate.dateOnly)) {
            returnDate = isOldBooking
                ? picked
                : picked.add(const Duration(days: 1));

            // Also update cooling period if it exists
            if (coolingPeriodDate != null) {
              _updateCoolingPeriod();
            }
          }

          // If cooling period exists and mode is "before", recalculate
          // (For now, assuming "after" mode - can add mode toggle later)
        });

        _loadProductsForService(selectedServiceId);
        if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
      }
    } else {
      // RETURN DATE PICKER
      if (isOldBooking) {
        final minReturnDate = pickupDate.dateOnly;
        final initialReturnDate = returnDate.dateOnly.isBefore(minReturnDate)
            ? minReturnDate
            : returnDate.dateOnly.isAfter(today)
            ? today
            : returnDate.dateOnly;

        final picked = await showDatePicker(
          context: context,
          initialDate: initialReturnDate,
          firstDate: minReturnDate,
          lastDate: today,
          builder: (context, child) {
            return Shortcuts(
              shortcuts: <ShortcutActivator, Intent>{
                const SingleActivator(LogicalKeyboardKey.arrowRight):
                    const NextFocusIntent(),
                const SingleActivator(LogicalKeyboardKey.arrowDown):
                    const NextFocusIntent(),
                const SingleActivator(LogicalKeyboardKey.arrowLeft):
                    const PreviousFocusIntent(),
                const SingleActivator(LogicalKeyboardKey.arrowUp):
                    const PreviousFocusIntent(),
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
            );
          },
        );

        if (picked != null) {
          setState(() {
            returnDate = picked;
          });
          _loadProductsForService(selectedServiceId);
          if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
        }
        return;
      }

      // CRITICAL: Must be today or future, never in the past
      final minReturnDate = pickupDate.dateOnly.isAfter(today)
          ? pickupDate.dateOnly
          : today;

      final picked = await showDatePicker(
        context: context,
        initialDate: minReturnDate.isAfter(returnDate.dateOnly)
            ? minReturnDate
            : returnDate,
        firstDate: minReturnDate, // Cannot be before max(today, pickup)
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.arrowRight):
                  NextFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowDown):
                  NextFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowLeft):
                  PreviousFocusIntent(),
              SingleActivator(LogicalKeyboardKey.arrowUp):
                  PreviousFocusIntent(),
            },
            child: Focus(
              autofocus: true,
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: Color(0xFF6132E4)),
                ),
                child: child!,
              ),
            ),
          );
        },
      );

      if (picked != null) {
        setState(() {
          returnDate = picked;

          // RIPPLE EFFECT: Update cooling period if mode is "after"
          if (coolingPeriodDate != null) {
            _updateCoolingPeriod();
          }
        });

        _loadProductsForService(selectedServiceId);
        if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
      }
    }
  }

  Future<void> _selectBookedDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _bookedDate ?? DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            const SingleActivator(LogicalKeyboardKey.arrowRight):
                const NextFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowDown):
                const NextFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowLeft):
                const PreviousFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowUp):
                const PreviousFocusIntent(),
          },
          child: Focus(
            autofocus: true,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme:
                    const ColorScheme.light(primary: Color(0xFF6132E4)),
              ),
              child: child!,
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() => _bookedDate = picked);
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
            const SingleActivator(LogicalKeyboardKey.arrowRight):
                const NextFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowDown):
                const NextFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowLeft):
                const PreviousFocusIntent(),
            const SingleActivator(LogicalKeyboardKey.arrowUp):
                const PreviousFocusIntent(),
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
        );
      },
    );

    if (picked != null) {
      // VALIDATION: Check if time is in the past for today's date
      if (isPickup) {
        // Pickup time validation
        if (pickupDate.isDateToday && _isTimeInPast(picked)) {
          _showTimeError('Pickup time cannot be in the past');
          return;
        }

        setState(() {
          pickupTime = picked;
        });

        // VALIDATION: If same day booking, validate return time
        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            returnTime != null) {
          if (!_isReturnTimeAfterPickupTime(picked, returnTime!)) {
            setState(() {
              returnTime = null; // Clear invalid return time
            });
            _showTimeError(
              'Return time has been cleared as it was before the new pickup time',
            );
          }
        }

        // Reload products with new time
        _loadProductsForService(selectedServiceId);
      } else {
        // Return time validation
        if (returnDate.isDateToday && _isTimeInPast(picked)) {
          _showTimeError('Return time cannot be in the past');
          return;
        }

        // VALIDATION: If same day booking, return must be after pickup
        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            pickupTime != null) {
          if (!_isReturnTimeAfterPickupTime(pickupTime!, picked)) {
            _showTimeError('Return time must be after pickup time');
            return;
          }
        }

        setState(() {
          returnTime = picked;
        });

        // Reload products with new time
        _loadProductsForService(selectedServiceId);
      }
    }
  }

  /// Helper: Check if a time is in the past for today
  bool _isTimeInPast(TimeOfDay time) {
    final now = TimeOfDay.now();
    final nowMinutes = now.hour * 60 + now.minute;
    final timeMinutes = time.hour * 60 + time.minute;
    return timeMinutes < nowMinutes;
  }

  /// Helper: Check if return time is after pickup time
  bool _isReturnTimeAfterPickupTime(
    TimeOfDay pickupTime,
    TimeOfDay returnTime,
  ) {
    final pickupMinutes = pickupTime.hour * 60 + pickupTime.minute;
    final returnMinutes = returnTime.hour * 60 + returnTime.minute;
    return returnMinutes > pickupMinutes;
  }

  /// Helper: Show time validation error
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

  /// Helper: Update cooling period based on pickup/return date changes
  /// Supports both "before" and "after" modes
  void _updateCoolingPeriod() {
    if (coolingPeriodDays <= 0) {
      coolingPeriodDate = null;
      return;
    }

    if (coolingPeriodMode.isAfter) {
      // TC-10: After mode (Maintenance) - cooling starts after return
      coolingPeriodDate = returnDate.add(Duration(days: coolingPeriodDays));
    } else {
      // TC-15: Before mode (Preparation) - cooling ends before pickup
      coolingPeriodDate = pickupDate.subtract(
        Duration(days: coolingPeriodDays),
      );
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

  Widget _buildPaymentMethodOption(
    PaymentMethod method,
    IconData icon, {
    bool isSecurity = false,
  }) {
    final isMultiSelect = !isSecurity;
    final isSelected = isMultiSelect
        ? _selectedPaymentMethods.contains(method)
        : securityPaymentMethod == method;

    void Function() onTap;
    if (isSecurity) {
      onTap = () => setState(() => securityPaymentMethod = method);
    } else {
      onTap = () => _togglePaymentMethodSelection(method);
    }

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6132E4)
                  : Colors.grey.shade300,
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
                color: isSelected
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade700,
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
          'Payment Methods',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildPaymentMethodOption(PaymentMethod.upi, Icons.qr_code),
            const SizedBox(width: 8),
            _buildPaymentMethodOption(PaymentMethod.cash, Icons.money),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'You can select both if the customer is splitting payment.',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSecurityPaymentMethodSelector() {
    return Row(
      children: [
        _buildPaymentMethodOption(
          PaymentMethod.upi,
          Icons.qr_code,
          isSecurity: true,
        ),
        const SizedBox(width: 8),
        _buildPaymentMethodOption(
          PaymentMethod.cash,
          Icons.money,
          isSecurity: true,
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
            final hasQuery =
                serviceSearchController.text.isNotEmpty ||
                _showAllProductsOnSearchFocus;
            final hasFilters =
                _isPriceFilterEnabled.value ||
                _selectedSearchTypeIndex.value != 0;
            final hasAnyFilter = hasQuery || hasFilters;

            state.maybeWhen(
              loading: () {
                // While fetching, show the overlay with a spinner so the user
                // knows something is happening — do NOT remove the overlay.
                if (hasAnyFilter) {
                  _overlayIsLoading.value = true;
                  if (_searchOverlayEntry == null) {
                    _showSearchOverlay();
                  }
                }
              },
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
                    if (hasAnyFilter || (products.isNotEmpty && isSearching)) {
                      _overlayIsLoading.value = false;
                      _overlayProducts.value = products;
                      if (_searchOverlayEntry == null) {
                        _showSearchOverlay();
                      }
                    } else {
                      _removeSearchOverlay();
                    }
                  },
              error: (_) {
                _overlayIsLoading.value = false;
                _overlayProducts.value = [];
                if (hasAnyFilter) {
                  if (_searchOverlayEntry == null) {
                    _showSearchOverlay();
                  }
                } else {
                  _removeSearchOverlay();
                }
              },
              orElse: () {
                // Error or unknown — only hide if nothing is being searched
                if (!hasAnyFilter) _removeSearchOverlay();
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
                      child: ValueListenableBuilder(
                        valueListenable: _selectedSearchTypeIndex,
                        builder: (context, searchTypeIndex, _) {
                          return ValueListenableBuilder(
                            valueListenable: _isPriceFilterEnabled,
                            builder: (context, isPriceEnabled, _) {
                              // Build active filter text
                              String? filterText;
                              if (searchTypeIndex != 0) {
                                filterText = _searchTypes[searchTypeIndex];
                              }
                              if (isPriceEnabled) {
                                if (filterText != null) {
                                  filterText += ' | Price';
                                } else {
                                  filterText = 'Price';
                                }
                              }

                              return Focus(
                                skipTraversal: true,
                                canRequestFocus: false,
                                onKeyEvent: (_, event) {
                                  if (event is KeyDownEvent &&
                                      (event.logicalKey ==
                                              LogicalKeyboardKey.arrowDown ||
                                          event.logicalKey ==
                                              LogicalKeyboardKey.numpad2)) {
                                    if (_overlayProducts.value.isNotEmpty) {
                                      _getOverlayItemFocusNode(0).requestFocus();
                                      return KeyEventResult.handled;
                                    }
                                  }
                                  return KeyEventResult.ignored;
                                },
                                child: TextField(
                                controller: serviceSearchController,
                                focusNode: _productSearchFocusNode,
                                onTap: () {
                                  if (serviceSearchController.text
                                      .trim()
                                      .isEmpty) {
                                    _searchAllProductsForOverlay();
                                  }
                                },
                                textInputAction: TextInputAction.next,
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
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 18,
                                  ),
                                  suffixIcon: filterText != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: Chip(
                                            label: Text(
                                              filterText,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF6132E4),
                                              ),
                                            ),
                                            backgroundColor: const Color(
                                              0xFF6132E4,
                                            ).withOpacity(0.1),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                            ),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                          ),
                                        )
                                      : null,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.trim().isNotEmpty &&
                                      _showAllProductsOnSearchFocus) {
                                    _showAllProductsOnSearchFocus = false;
                                  }
                                  _onSearchChanged(value);
                                  if (value.isEmpty) {
                                    _removeSearchOverlay();
                                  } else {
                                    // Show quick local results for single-char input
                                    if (value.trim().length == 1) {
                                      _showLocalFilteredResults(value.trim());
                                    }
                                    // Immediate dispatch to ensure backend receives search_value
                                    final queryValue = value
                                        .trim()
                                        .toLowerCase();
                                    final isSales =
                                        selectedBookingType ==
                                        BookingType.sales;
                                    final isBooking = selectedBookingType == BookingType.booking;
                                    final serviceIdToUse =
                                        (selectedServiceId == null ||
                                            selectedServiceId == -1)
                                        ? null
                                        : selectedServiceId;

                                    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
                                        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
                                        : returnDate.format();
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
                                        if (_currentServiceType != null) {
                                          if (_currentServiceType
                                              .isMultiVariantProductType) {
                                            if (_currentServiceType ==
                                                    MainServiceType.dress ||
                                                _currentServiceType ==
                                                    MainServiceType.costume) {
                                              searchType = 'size';
                                            } else if (_currentServiceType ==
                                                MainServiceType.gadgets) {
                                              searchType = 'serial_number';
                                            } else {
                                              searchType = 'variant';
                                            }
                                          } else {
                                            searchType = 'color';
                                          }
                                        } else {
                                          searchType = 'color';
                                        }
                                        break;
                                    }
                                    searchType ??= 'name';

                                    _selectProductBloc.add(
                                      SelectProductEvent.searchProducts(
                                        serviceId: serviceIdToUse,
                                        query: queryValue,
                                        type: searchType,
                                        startPrice: _isPriceFilterEnabled.value
                                            ? _priceRange.value.start.round()
                                            : null,
                                        endPrice: _isPriceFilterEnabled.value
                                            ? _priceRange.value.end.round()
                                            : null,
                                        pickupDate: pickupDate.format(),
                                        returnDate: effectiveReturnDate,
                                        pickupTime: pickupTime,
                                        returnTime: returnTime,
                                        useAvailableProductsApi:
                                            selectedBookingType ==
                                            BookingType.booking,
                                        isSales: isSales,
                                      ),
                                    );
                                  }
                                },
                                onSubmitted: (_) {
                                  if (_overlayProducts.value.isNotEmpty) {
                                    _getOverlayItemFocusNode(0).requestFocus();
                                  } else {
                                    _clientNameFocusNode.requestFocus();
                                  }
                                },
                              ),
                              );
                            },
                          );
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
    // Guard: only insert once; subsequent updates go through the ValueNotifiers
    if (_searchOverlayEntry != null) return;

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier — tap outside to dismiss
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
          // The actual search overlay
          Positioned(
            width: 1000,
            child: CompositedTransformFollower(
              link: _searchLayerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                // Wrap both notifiers so the overlay rebuilds reactively
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
                              // ── Header ──────────────────────────────────
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
                              // ── Body ────────────────────────────────────
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
                                    controller: _searchResultsScrollController,
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
                                        _buildOverlaySearchItem(
                                          productList[i],
                                          index: i,
                                          itemCount: productList.length,
                                        ),
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
  Widget _buildOverlaySearchItem(
    ProductEntity product, {
    required int index,
    required int itemCount,
  }) {
    return OverlaySearchItem(
      product: product,
      isSales: selectedBookingType == BookingType.sales,
      focusNode: _getOverlayItemFocusNode(index),
      nextFocusNode: index + 1 < itemCount
          ? _getOverlayItemFocusNode(index + 1)
          : _clientNameFocusNode,
      onAddProduct: (selectedVariant) {
        _addProductFromSearchWithVariant(product, selectedVariant);
        _removeSearchOverlay();
        serviceSearchController.clear();
        _clientNameFocusNode.requestFocus();
      },
      onArrowDown: () {
        if (index + 1 < itemCount) {
          _getOverlayItemFocusNode(index + 1).requestFocus();
        }
      },
      onArrowUp: () {
        if (index > 0) {
          _getOverlayItemFocusNode(index - 1).requestFocus();
        } else {
          _productSearchFocusNode.requestFocus();
        }
      },
      onEscape: () {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _productSearchFocusNode.requestFocus();
      },
      onImageTap: (imageUrl, title) async {
        final cachedProducts = List<ProductEntity>.from(_overlayProducts.value);
        _removeSearchOverlay();
        await ZoomableImageDialog.show(
          context,
          imageUrl: imageUrl,
          title: title,
        );
        if (mounted && cachedProducts.isNotEmpty) {
          _overlayProducts.value = cachedProducts;
          _showSearchOverlay();
        }
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

    // For sales mode, use sale_price if available, otherwise fall back to price
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    // Parse product-level sale_price (String?) to int for comparison
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
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;

      if (!isOldBooking) {
        // Check if incrementing would exceed available stock
        final availableStock = variant.remainingStock ?? variant.stock;

        if (newQuantity > availableStock) {
          context.showSnackBar(
            'Cannot add more. Available stock: $availableStock',
            isError: true,
          );
          return; // Don't add the product
        }
      }

      // Increment quantity
      products[existingIndex] = existing.copyWith(quantity: newQuantity);
    } else {
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

  Widget _buildProductListHeader() {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final hasVariants = _hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildHeaderCell('items', alignLeft: true)),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: _buildHeaderCell('Specifications')),
          const SizedBox(width: 4),
          if (hasVariants) ...[
            Expanded(child: _buildHeaderCell('Variants')),
            const SizedBox(width: 4),
          ],
          if (!isOldBooking) ...[
            Expanded(child: _buildHeaderCell('Available')),
            const SizedBox(width: 4),
          ],
          Expanded(child: _buildHeaderCell('Quantity')),
          const SizedBox(width: 4),
          if (!isSales) ...[
            Expanded(child: _buildHeaderCell('Days')),
            const SizedBox(width: 4),
          ],
          Expanded(child: _buildHeaderCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(child: _buildHeaderCell('Total')),
          const SizedBox(width: 50), // Matches row close button area
        ],
      ),
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

  int _getDiscountProductBase() {
    final rentalDays = _getEffectiveRentalDays();
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

  int _calculateBookingTotalPayable() {
    final rentalDays = _getEffectiveRentalDays();
    final isSales = selectedBookingType == BookingType.sales;
    final productTotal = selectedProductsNotifier.value.fold<int>(0, (
      sum,
      product,
    ) {
      final effectiveDaysMultiplier =
          (!isSales && _shouldMultiplyByDays(product.variant.mainServiceType))
          ? (rentalDays > 0 ? rentalDays : 1)
          : 1;
      return sum +
          (product.amount * product.quantity * effectiveDaysMultiplier);
    });
    final additionalTotal = additionalChargesNotifier.value.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );

    final discountInput =
        discountAmountController.text.trim().toIntOrNull() ?? 0;
    final discountAmount = isDiscountPercentage
        ? ((productTotal + additionalTotal) * discountInput / 100).round()
        : discountInput;

    return productTotal + additionalTotal - discountAmount;
  }

  Widget _buildProductRow(ProductSelectedEntity product) {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final rentalDays = !isSales ? _getEffectiveRentalDays() : 0;
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
                // Text
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
          // Specifications (service-specific)
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                _getProductSpecifications(product),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Variant (only for multi-variant products)
          if (hasVariants) ...[
            Expanded(
              child: Center(
                child: Text(
                  _getVariantDisplayText(product),
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
          if (!isOldBooking) ...[
            Expanded(
              child: Center(
                child: Container(
                  //  width: 58,
                  // height: 21,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1C1FD300), // Light green bg
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27AE60), // Green dot
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${product.variant.remainingStock ?? product.variant.stock} left',
                        style: const TextStyle(
                          fontSize: 12, // Slightly larger font 12
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
          ],
          // Quantity Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuantityBtn(
                  icon: Icons.remove,
                  onTap: () => _decrementQuantity(product),
                  compact: true,
                ),
                const SizedBox(width: 3),
                SizedBox(
                  width: 25,
                  height: 20,
                  child: TextField(
                    controller: _getQuantityController(product),
                    focusNode: _getQuantityFocusNode(_quantityKey(product)),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Color(0xFF6132E4)),
                      ),
                    ),
                    onSubmitted: (value) => _saveTypedQuantity(product, value),
                    onTapOutside: (_) => _saveTypedQuantity(
                      product,
                      _getQuantityController(product).text,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                _buildQuantityBtn(
                  icon: Icons.add,
                  onTap: () => _incrementQuantity(product),
                  compact: true,
                  isDisabled:
                      !isOldBooking &&
                      product.quantity >=
                          (product.variant.remainingStock ??
                              product.variant.stock ??
                              999),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Days controls (only for bookings/custom/old booking)
          if (!isSales) ...[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQuantityBtn(
                    icon: Icons.remove,
                    onTap: _decrementRentalDays,
                    isDisabled: _manualExtraRentalDays == 0,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$rentalDays',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _buildQuantityBtn(
                    icon: Icons.add,
                    onTap: _incrementRentalDays,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
          ],
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
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
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
                          '${product.amount}', // format currency if needed
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
                  fontWeight: FontWeight.w700, // Bold
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
    bool isDisabled = false,
    bool compact = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: compact ? 20 : 18,
        height: compact ? 20 : 18,
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.shade300
              : const Color(0xFFF3F0FF), // Light purple bg
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          size: compact ? 12 : 14,
          color: isDisabled ? Colors.grey.shade500 : const Color(0xFF6132E4),
        ),
      ),
    );
  }

  TextEditingController _getQuantityController(ProductSelectedEntity product) {
    final quantityKey = _quantityKey(product);
    final focusNode = _getQuantityFocusNode(quantityKey);
    final controller = _quantityControllers.putIfAbsent(
      quantityKey,
      () => TextEditingController(text: product.quantity.toString()),
    );
    if (!focusNode.hasFocus && controller.text != product.quantity.toString()) {
      controller.text = product.quantity.toString();
    }
    return controller;
  }

  int _quantityKey(ProductSelectedEntity product) {
    return product.variant.variantId ?? product.variant.id;
  }

  FocusNode _getQuantityFocusNode(int quantityKey) {
    return _quantityFocusNodes.putIfAbsent(quantityKey, FocusNode.new);
  }

  FocusNode _getOverlayItemFocusNode(int index) {
    return _overlayItemFocusNodes.putIfAbsent(index, FocusNode.new);
  }

  void _focusNextProductRowOrClient(ProductSelectedEntity product) {
    final products = selectedProductsNotifier.value;
    final currentIndex = products.indexWhere(
      (item) => item.variant.variantId == product.variant.variantId,
    );
    if (currentIndex != -1 && currentIndex + 1 < products.length) {
      final nextProduct = products[currentIndex + 1];
      _getQuantityFocusNode(_quantityKey(nextProduct)).requestFocus();
      return;
    }

    _clientNameFocusNode.requestFocus();
  }

  /// Increment quantity of a product with stock validation
  void _incrementQuantity(ProductSelectedEntity product) {
    final isOldBooking = selectedBookingType == BookingType.oldBooking;

    if (!isOldBooking) {
      // Check available stock using remainingStock with fallback to stock
      final availableStock =
          product.variant.remainingStock ?? product.variant.stock ?? 999;
      final currentQuantity = product.quantity;

      // Silently prevent increment if at max - button should already be disabled
      if (currentQuantity >= availableStock) {
        return;
      }
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
      _quantityControllers[_quantityKey(product)]?.text = products[index]
          .quantity
          .toString();
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
        _quantityControllers[_quantityKey(product)]?.text = products[index]
            .quantity
            .toString();
      } else {
        _quantityControllers.remove(_quantityKey(product))?.dispose();
        _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
        products.removeAt(index);
      }
      selectedProductsNotifier.value = products;
    }
  }

  void _saveTypedQuantity(ProductSelectedEntity product, String value) {
    final parsedQuantity = int.tryParse(value.trim());

    if (parsedQuantity == null || parsedQuantity <= 0) {
      _quantityControllers[_quantityKey(product)]?.text = product.quantity
          .toString();
      context.showSnackBar('Quantity must be greater than 0', isError: true);
      return;
    }

    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;

    if (!isOldBooking && parsedQuantity > availableStock) {
      _quantityControllers[_quantityKey(product)]?.text = product.quantity
          .toString();
      context.showSnackBar(
        'Quantity cannot be greater than available stock ($availableStock)',
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

    if (index == -1) return;

    products[index] = products[index].copyWith(quantity: parsedQuantity);
    _quantityControllers[_quantityKey(product)]?.text = parsedQuantity
        .toString();
    selectedProductsNotifier.value = products;
    _quantityFocusNodes[_quantityKey(product)]?.unfocus();
    _focusNextProductRowOrClient(products[index]);
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

    // Validate that price is not zero
    if (newPrice == null || newPrice <= 0) {
      context.showSnackBar(
        'Product price cannot be zero or empty',
        isError: true,
      );
      // Keep the field in edit mode
      return;
    }

    _updateProductPrice(product, newPrice);

    setState(() {
      _editingVariantId = null;
      _inlinePriceController.clear();
      _inlinePriceFocusNode.unfocus();
    });
    _focusNextProductRowOrClient(product);
  }

  /// Remove a product from the selected list
  void _removeProduct(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      selectedProductsNotifier.value,
    );
    _quantityControllers.remove(_quantityKey(product))?.dispose();
    _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
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
              final isSaleType = selectedBookingType == BookingType.sales;
              final advanceAmount = isSaleType
                  ? 0
                  : (advanceAmountController.text.trim().toIntOrNull() ?? 0);
              final summaryRentalDays = !isSaleType
                  ? _getEffectiveRentalDays()
                  : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                final daysMultiplier =
                    (!isSaleType &&
                        _shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (summaryRentalDays > 0 ? summaryRentalDays : 1)
                    : 1;
                return sum +
                    (product.amount * product.quantity * daysMultiplier);
              });
              final additionalTotal = additionalCharges.fold<int>(
                0,
                (sum, charge) => sum + (charge.amount ?? 0),
              );
              final discountInput =
                  discountAmountController.text.trim().toIntOrNull() ?? 0;
              final discountAmount = isDiscountPercentage
                  ? ((productTotal + additionalTotal) * discountInput / 100)
                        .round()
                  : discountInput;
              final totalPayable =
                  productTotal + additionalTotal - discountAmount;
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
                    if (discountAmount > 0)
                      _buildSummaryRow(
                        '- Discount',
                        discountAmount,
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
          // const SizedBox(height: 3),

          // const SizedBox(height: 3),
          // Add customization button - Only for Dresses (not for sales)
          ValueListenableBuilder<List<ProductSelectedEntity>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              // Hide customization button for sales mode
              if (selectedBookingType == BookingType.sales) {
                return const SizedBox.shrink();
              }
              final hasDressesOrCostumes = products.any(
                (p) =>
                    (p.variant.mainServiceType?.isDress ?? false) ||
                    (p.variant.mainServiceType?.isCostume ?? false),
              );
              if (!hasDressesOrCostumes) return const SizedBox.shrink();

              // Check if any dress/costume product has measurements (customizations saved)
              final hasCustomizations = products.any(
                (p) =>
                    ((p.variant.mainServiceType?.isDress ?? false) ||
                        (p.variant.mainServiceType?.isCostume ?? false)) &&
                    p.measurements.isNotEmpty,
              );

              return Column(
                children: [
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
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
                            : Colors.grey.shade600,
                        side: BorderSide(
                          color: hasCustomizations
                              ? const Color(0xFF6132E4)
                              : Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              fontSize: 13,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          // Confirm button - Color #6132E4
          SizedBox(
            width: double.infinity,
            height: 39, // Balanced height
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
              child: Text(
                selectedBookingType == BookingType.sales
                    ? 'Confirm Sales'
                    : 'Confirm Booking',
                style: const TextStyle(
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
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

              // Validate name
              if (name.isEmpty) {
                context.showSnackBar('Please enter charge name', isError: true);
                return;
              }

              // Validate amount
              if (amount == null || amount <= 0) {
                context.showSnackBar(
                  'Please enter a valid amount greater than 0',
                  isError: true,
                );
                return;
              }

              Navigator.pop(
                context,
                AdditionalChargesEntity(name: name, amount: amount),
              );
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

    // Validate that at least one product has a price greater than zero
    final hasProductWithPrice = products.any((product) => product.amount > 0);
    if (!hasProductWithPrice) {
      context.showSnackBar(
        'Product price cant be zero. At least one product should have a price.',
        isError: true,
      );
      return;
    }

    if (selectedBookingType != BookingType.sales) {
      final advanceAmount =
          advanceAmountController.text.trim().toIntOrNull() ?? 0;
      final totalPayable = _calculateBookingTotalPayable();
      if (advanceAmount > totalPayable) {
        context.showSnackBar(
          'Advance amount cannot be greater than total amount',
          isError: true,
        );
        return;
      }
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
    final products = selectedProductsNotifier.value;
    final additionalCharges = additionalChargesNotifier.value;
    final runningKm = runningKilometersController.text.trim();

    // Propagate running kilometers into each product so it is sent
    // inside the variant's measurements JSON (not as a top-level field).
    final requestProducts = products.map((product) {
      final adjusted = product.copyWith(
        amount: product.amount * _getDaysMultiplierForProduct(product),
      );
      if (runningKm.isNotEmpty) {
        return adjusted.copyWith(runningKilometers: runningKm);
      }
      return adjusted;
    }).toList();

    final productTotal = products.fold<int>(0, (sum, product) {
      return sum + (product.amount * product.quantity);
    });
    final additionalTotal = additionalCharges.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );
    final discountInput =
        discountAmountController.text.trim().toIntOrNull() ?? 0;
    final actualDiscount = isDiscountPercentage
        ? ((productTotal + additionalTotal) * discountInput / 100).round()
        : discountInput;

    // Get staff ID from cubit
    final staffState = context.read<StaffSearchCubit>().state;
    final staffId = staffState.selectedStaff?.id;

    // If there's no client ID, we need to send client data
    ClientRequestEntity? clientData;
    if (selectedClientId == null) {
      final phone1Raw = clientPhone1Controller.text.trim();
      final phone2Raw = clientPhone2Controller.text.trim();

      clientData = ClientRequestEntity(
        id: null,
        name: clientNameController.text.trim().isEmpty
            ? null
            : clientNameController.text.trim(),
        phone1E164: phone1Raw.isEmpty ? null : toPhone1E164(phone1Raw),
        phone2E164: phone2Raw.isEmpty ? null : toPhone1E164(phone2Raw),
      );
    }

    // Location fields go under the "details" key.
    final locationStart = startLocationController.text.trim();
    final locationFrom = pickupLocationController.text.trim();
    final locationTo = destinationLocationController.text.trim();
    final hasLocationData =
        locationStart.isNotEmpty ||
        locationFrom.isNotEmpty ||
        locationTo.isNotEmpty;
    final otherDetails = hasLocationData
        ? BookingOtherDetailsEntity(
            locationStart: locationStart.isEmpty ? null : locationStart,
            locationFrom: locationFrom.isEmpty ? null : locationFrom,
            locationTo: locationTo.isEmpty ? null : locationTo,
          )
        : null;

    // cooling_period_type is sent based on user-selected cooling period mode.
    final coolingPeriodType = coolingPeriodDays > 0
        ? coolingPeriodMode.value.toLowerCase()
        : null;

    // Calculate return date and cooling period date based on user-selected mode
    DateTime effectiveReturnDate;
    DateTime? effectiveCoolingPeriodDate;

    if (coolingPeriodDays > 0) {
      if (coolingPeriodMode.isAfter) {
        // After mode: return date stays as picked, cooling period starts after return
        effectiveReturnDate = returnDate;
        effectiveCoolingPeriodDate = returnDate.add(
          Duration(days: coolingPeriodDays),
        );
      } else {
        // Before mode: return date stays as-is, cooling period ends before pickup
        effectiveReturnDate = returnDate;
        effectiveCoolingPeriodDate = pickupDate.subtract(
          Duration(days: coolingPeriodDays),
        );
      }
    } else {
      effectiveReturnDate = returnDate;
      effectiveCoolingPeriodDate = null;
    }

    return BookingRequestEntity(
      clientId: selectedClientId,
      staffId: staffId,
      client: clientData,
      address: clientAddressController.text.trim(),
      pickupDate: pickupDate.format(),
      returnDate: effectiveReturnDate.format(),
      coolingPeriodDate: effectiveCoolingPeriodDate?.format(),
      coolingPeriodType: coolingPeriodType,
      advanceAmount: advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: securityAmountController.text.trim().toIntOrNull(),
      securityPaymentMethod:
          securityAmountController.text.trim().toIntOrNull() != null
          ? securityPaymentMethod
          : null,
      discountAmount: actualDiscount,
      purchaseMode: 'normal',
      paymentMethod: paymentMethod,
      deliveryStatus: deliveryStatus,
      products: requestProducts,
      otherDetails: otherDetails,
      additionalCharges: additionalCharges.isNotEmpty
          ? additionalCharges
          : null,
      description: _buildDescriptionWithPaymentSummary(),
      pickupTime: pickupTime,
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
    );
  }

  /// Build sales request for creating a sale
  RequestSalesModel _buildSalesRequest() {
    final products = selectedProductsNotifier.value;

    // Build variants array with id, quantity, and amount (total = per-unit price × quantity)
    final variants = products.map((product) {
      return {
        'id': product.variant.variantId,
        'quantity': product.quantity,
        'amount': product.amount * product.quantity,
      };
    }).toList();
    final grossTotal = variants.fold<int>(
      0,
      (sum, item) => sum + (item['amount'] ?? 0),
    );

    // Calculate actual discount amount (support percentage)
    final discountInput =
        discountAmountController.text.trim().toIntOrNull() ?? 0;
    final discount = isDiscountPercentage
        ? (grossTotal * discountInput / 100).round()
        : discountInput;

    final finalTotal = (grossTotal - discount) > 0
        ? (grossTotal - discount)
        : 0;

    // Get staff ID from cubit
    final staffState = context.read<StaffSearchCubit>().state;
    final staffId = staffState.selectedStaff?.id;

    // Use phone1 as client_phone
    final clientPhone = clientPhone1Controller.text.trim();

    return RequestSalesModel(
      staffId: staffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      clientAddress: clientAddressController.text.trim().isEmpty
          ? null
          : clientAddressController.text.trim(),
      saleDate: pickupDate.format(), // Use pickup date as sale date
      description: _buildDescriptionWithPaymentSummary(),
      sendInvoice: sendPdfToWhatsApp,
      variants: variants,
      // Sales flow has no paid field in UI; mark as fully paid by default.
      paidAmount: finalTotal,
      paymentMethod: paymentMethod,
      discount: discount,
      // Default to true, or use checkbox value if past date
      decreaseStock: decreaseStockForPastDate || !_isPastDate(),
    );
  }

  Widget _buildDateSelectionSection() {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;

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
                autofocus: true,
              ),
            )
          else if (isOldBooking)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: _buildOldBookedDateField()),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNewDateField(
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: () => _selectDate(isPickup: true),
                    autofocus: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildNewDateField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                  ),
                ),
              ],
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
                    focusNode: _pickupDateFocusNode,
                    nextFocusNode: _pickupTimeFocusNode,
                    autofocus: true,
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
                    focusNode: _pickupTimeFocusNode,
                    nextFocusNode: _returnDateFocusNode,
                  ),
                ),
                const SizedBox(width: 16),

                // Divider between Pickup and Return
                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                // Return Date
                Expanded(
                  flex: 3,
                  child: _buildNewDateField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                    focusNode: _returnDateFocusNode,
                    nextFocusNode: _returnTimeFocusNode,
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
                    focusNode: _returnTimeFocusNode,
                    nextFocusNode: _coolingPeriodFocusNode,
                  ),
                ),

                const SizedBox(width: 16),

                // Divider between Return and Cooling Period
                Container(
                  height: 50,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 0),
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                ),
                const SizedBox(width: 16),

                // Cooling Period (Days)
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
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
                                Text(
                                  coolingPeriodMode.isAfter
                                      ? '(after)'
                                      : '(before)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade400,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
                            ),
                          ),
                         TextButton(
  onPressed: () {
    setState(() {
      coolingPeriodMode = coolingPeriodMode.isAfter
          ? CoolingPeriodMode.before
          : CoolingPeriodMode.after;
    });
    _updateCoolingPeriod();
    _loadProductsForService(selectedServiceId);
    if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
  },
  child: Text(
    coolingPeriodMode.isAfter ? "After" : "Before",
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Colors.black, // change if background is dark
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
                        child: Focus(
                          focusNode: _coolingPeriodFocusNode,
                          onKeyEvent: (_, event) {
                            if (event is KeyDownEvent &&
                                (event.logicalKey == LogicalKeyboardKey.enter ||
                                    event.logicalKey ==
                                        LogicalKeyboardKey.numpadEnter)) {
                              _searchAllProductsForOverlay();
                              _productSearchFocusNode.requestFocus();
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
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
                                      _loadProductsForService(selectedServiceId);
                                      if (_searchOverlayEntry != null) _searchAllProductsForOverlay();
                                      _productSearchFocusNode.requestFocus();
                                    }
                                  },
                                );
                              },
                            ),
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

  Widget _buildNewDateField({
    required String label,
    required String value,
    required Future<void> Function() onTap,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    bool autofocus = false,
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
        Focus(
          focusNode: focusNode,
          autofocus: autofocus,
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              focusNode?.requestFocus();
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
            },
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
        ),
      ],
    );
  }

  Widget _buildOldBookedDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booked date (optional)',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              _selectBookedDate().then(
                (_) => FocusScope.of(context).nextFocus(),
              );
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () => _selectBookedDate().then(
              (_) => FocusScope.of(context).nextFocus(),
            ),
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
                      _bookedDate?.format() ?? 'Select booked date',
                      style: TextStyle(
                        fontSize: 13,
                        color: _bookedDate == null
                            ? Colors.grey.shade500
                            : Colors.black87,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_bookedDate != null)
                    GestureDetector(
                      onTap: () => setState(() => _bookedDate = null),
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                    )
                  else
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewTimeField({
    required String label,
    required String value,
    required Future<void> Function() onTap,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    bool autofocus = false,
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
        Focus(
          focusNode: focusNode,
          autofocus: autofocus,
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () {
              focusNode?.requestFocus();
              onTap().then((_) {
                if (nextFocusNode != null) {
                  nextFocusNode.requestFocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              });
            },
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
        ),
      ],
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

  /// Single panel for sales mode with all necessary fields
  Widget _buildSalesSinglePanel() {
    return Container(
      key: const ValueKey(2),
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Phone
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Client Phone (WP)',
                    textInputAction: TextInputAction.done,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
                      if (clientPhone1Controller.text != digits) {
                        clientPhone1Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'Place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: _staffNameFocusNode,
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Staff Details
                  const Text(
                    'Staff',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 7),
                  StaffSearchNameField(
                    nameController: staffNameController,
                    errorText: _staffNameError,
                    focusNode: _staffNameFocusNode,
                    nextFocusNode: _notesFocusNode,
                  ),
                  const SizedBox(height: _fieldSpacing),

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
                      focusNode: _notesFocusNode,
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
                  const SizedBox(height: _fieldSpacing),

                  // Discount
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: discountAmountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Payment Method
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 16),

                  // WhatsApp Checkbox
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
                                setState(() => sendPdfToWhatsApp = v ?? false),
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

                  // Past Date Checkbox - Only show for sales with past dates
                  if (selectedBookingType == BookingType.sales && _isPastDate())
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F2FE),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: decreaseStockForPastDate,
                                onChanged: (v) => setState(
                                  () => decreaseStockForPastDate = v ?? false,
                                ),
                                activeColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Decrease Stock quantity',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'If unchecked, the stock quantity will not be decreased from the inventory',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Fixed Bottom Section with Summary
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

                  // Name - Only show for bookings
                  if (selectedBookingType != BookingType.sales) ...[
                    // ClientName with Search
                    BlocListener<ClientCubit, ClientState>(
                      listener: (context, state) {
                        if (state.selectedClient != null) {
                          final client = state.selectedClient!;
                          // Auto-fill fields
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
                        hitText: 'Type or Search name',
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
                  ], // End of name section for bookings only
                  // Phone 1 (WhatsApp) - Always enabled
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Whatsapp number',
                    textInputAction: TextInputAction.next,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
                      if (clientPhone1Controller.text != digits) {
                        clientPhone1Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Phone 2 - Optional, only show for bookings, always enabled
                  if (selectedBookingType != BookingType.sales)
                    CustomPhoneNumberField(
                      controller: _clientPhone2FieldController,
                      hintText: 'Phone 2',
                      isRequired: false,
                      textInputAction: TextInputAction.next,
                      onChanged: (phone) {
                        final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                        cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
                        if (clientPhone2Controller.text != digits) {
                          clientPhone2Controller.value = TextEditingValue(
                            text: digits,
                            selection: TextSelection.collapsed(offset: digits.length),
                          );
                        }
                      },
                    ),
                  const SizedBox(height: _fieldSpacing),
                  // Place - Optional
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: _staffNameFocusNode,
                    prefixIcon: Icons.location_on,
                  ),

                  const SizedBox(height: _fieldSpacing),
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
                                setState(() => sendPdfToWhatsApp = v ?? false),
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

                  // Upload documents - Hidden for now
                  // if (selectedBookingType == BookingType.booking) ...[
                  //   const SizedBox(height: 8),
                  //   BookingDocumentUploadSection(
                  //     documentsNotifier: documentsNotifier,
                  //   ),
                  //   const SizedBox(height: 7),
                  // ],

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
                      focusNode: _notesFocusNode,
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
                      color: const Color(0xFF6132E4).withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Collapsed view - always visible
                      InkWell(
                        onTap: () {
                          setState(() {
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

  void _showSuccessDialog(int id, BookingType type) {
    final isSale = type == BookingType.sales;

    // Call send-invoice API after showing success (only for bookings)
    // For sales, the invoice is sent via the sales API automatically
    if (!isSale) {
      Future.delayed(Duration.zero, () async {
        try {
          final repo = getIt<IBookingRepository>();
          await repo.sendInvoice(id, sendPdfToWhatsApp);
        } catch (e) {
          log('Error sending invoice: $e');
        }
      });
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        // Auto-close after 10 seconds and navigate to dashboard
        Future.delayed(const Duration(seconds: 10), () {
          if (mounted) {
            // First close the dialog
            Navigator.of(dialogContext).pop();
            // Then close the booking screen and navigate to dashboard
            if (widget.onClose != null) {
              widget.onClose!();
            } else {
              Navigator.of(context).pop();
            }
          }
        });

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 64,
              ),
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
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                'Auto-closing in 10 seconds...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
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
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                          GlobalLoadingOverlay.show(
                            context,
                            text: 'Loading invoice...',
                          );

                          if (isSale) {
                            // For sales, use sales API endpoint
                            final repo = getIt<SalesRepositoryImpl>();
                            final pdfBytes = await repo.getInvoicePdfBytes(id);

                            GlobalLoadingOverlay.hide();

                            if (mounted) {
                              if (kIsWeb) {
                                // Open PDF in new tab for web
                                openPdfInNewTab(
                                  pdfBytes,
                                  'sale_invoice_$id.pdf',
                                );
                              } else {
                                // For desktop, save and open
                                final downloadsDir = Directory(
                                  '${Platform.environment['USERPROFILE']}\\Downloads',
                                );
                                if (!downloadsDir.existsSync()) {
                                  downloadsDir.createSync(recursive: true);
                                }
                                final fileName = 'sale_invoice_$id.pdf';
                                final filePath =
                                    '${downloadsDir.path}\\$fileName';
                                final file = File(filePath);
                                await file.writeAsBytes(pdfBytes);
                                await launchUrl(Uri.file(filePath));
                                context.showSnackBar(
                                  'Invoice saved to Downloads\\$fileName',
                                );
                              }
                            }
                          } else {
                            // For bookings, use booking API endpoint
                            final repo = getIt<IBookingRepository>();
                            final pdfBytes = await repo.getInvoicePdfBytes(id);

                            GlobalLoadingOverlay.hide();

                            if (mounted) {
                              if (kIsWeb) {
                                // Open PDF in new tab for web
                                openPdfInNewTab(
                                  pdfBytes,
                                  'booking_invoice_$id.pdf',
                                );
                              } else {
                                // For desktop, save and open
                                final downloadsDir = Directory(
                                  '${Platform.environment['USERPROFILE']}\\Downloads',
                                );
                                if (!downloadsDir.existsSync()) {
                                  downloadsDir.createSync(recursive: true);
                                }
                                final fileName = 'booking_invoice_$id.pdf';
                                final filePath =
                                    '${downloadsDir.path}\\$fileName';
                                final file = File(filePath);
                                await file.writeAsBytes(pdfBytes);
                                await launchUrl(Uri.file(filePath));
                                context.showSnackBar(
                                  'Invoice saved to Downloads\\$fileName',
                                );
                              }
                            }
                          }
                        } catch (e) {
                          GlobalLoadingOverlay.hide();
                          log('Error loading invoice: $e');
                          if (mounted) {
                            context.showSnackBar(
                              'Failed to load invoice: $e',
                              isError: true,
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6132E4),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        isSale ? 'View Sale' : 'View Invoice',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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
                      setState(() => _bookingStep = 0);
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
                    controller: advanceAmountController,
                    hint: 'Advance amount',
                    isNumber: true,
                    focusNode: _advanceAmountFocusNode,
                    nextFocusNode: _securityAmountFocusNode,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: securityAmountController,
                    hint: 'Security amount',
                    isNumber: true,
                    focusNode: _securityAmountFocusNode,
                    nextFocusNode: _discountAmountFocusNode,
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
                            const Text(
                              'Security Payment Method',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF3E3E3E),
                              ),
                            ),
                            const SizedBox(height: 6),
                            _buildSecurityPaymentMethodSelector(),
                            const SizedBox(height: 14),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),
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
                                      final amount = (total * input / 100)
                                          .round();
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
                    ],
                  ),

                  const SizedBox(height: 14),
                  // Payment Method Selection - only show if advance amount has value
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: advanceAmountController,
                    builder: (context, value, child) {
                      final hasAdvanceAmount =
                          value.text.trim().isNotEmpty &&
                          (int.tryParse(value.text.trim()) ?? 0) > 0;
                      if (hasAdvanceAmount) {
                        return Column(
                          children: [
                            _buildPaymentMethodSection(),
                            const SizedBox(height: 14),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),

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
                                color: const Color(0xFF6132E4).withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
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
                                        ).withOpacity(0.1),
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

  // ─── Old Booking ─────────────────────────────────────────────────────────

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
                        selectedClientId = client.id;
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: clientNameController,
                      errorText: _clientNameError,
                      hitText: 'Type or search name',
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Client Phone
                  CustomPhoneNumberField(
                    controller: _clientPhone1FieldController,
                    hintText: 'Client Phone',
                    textInputAction: TextInputAction.next,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
                      if (clientPhone1Controller.text != digits) {
                        clientPhone1Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Client Phone 2
                  CustomPhoneNumberField(
                    controller: _clientPhone2FieldController,
                    hintText: 'Client Phone 2 (Optional)',
                    isRequired: false,
                    textInputAction: TextInputAction.next,
                    onChanged: (phone) {
                      final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
                      cachePhoneE164(rawPhoneNumber: digits, e164: phoneNumberToE164(phone));
                      if (clientPhone2Controller.text != digits) {
                        clientPhone2Controller.value = TextEditingValue(
                          text: digits,
                          selection: TextSelection.collapsed(offset: digits.length),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Address
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'Place / Address',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: _fieldSpacing),

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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final repository = getIt<IBookingRepository>();
      final request = _buildOldBookingRequest();
      log('Old Booking Request: ${request.toString()}');
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
    final products = selectedProductsNotifier.value;
    final totalAmount = products.fold<int>(
      0,
      (sum, product) =>
          sum +
          (product.amount *
              product.quantity *
              _getDaysMultiplierForProduct(product)),
    );
    final requestProducts = products
        .map(
          (product) => product.copyWith(
            amount: product.amount * _getDaysMultiplierForProduct(product),
          ),
        )
        .toList();

    return BookingRequestEntity(
      clientId: selectedClientId,
      staffId: null,
      client: selectedClientId == null
          ? ClientRequestEntity(
              id: null,
              name: clientNameController.text.trim().isEmpty
                  ? null
                  : clientNameController.text.trim(),
              phone1E164: clientPhone1Controller.text.trim().isEmpty
                  ? null
                  : toPhone1E164(clientPhone1Controller.text.trim()),
              phone2E164: clientPhone2Controller.text.trim().isEmpty
                  ? null
                  : toPhone1E164(clientPhone2Controller.text.trim()),
            )
          : null,
      address: clientAddressController.text.trim().isEmpty
          ? null
          : clientAddressController.text.trim(),
      bookedDate: _bookedDate?.format(),
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      advanceAmount: totalAmount,
      paymentMethod: paymentMethod,
      deliveryStatus: DeliveryStatus.returned,
      bookingStatus: BookingStatus.completed,
      description: _buildDescriptionWithPaymentSummary(),
      products: requestProducts,
    );
  }
}
