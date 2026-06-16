import 'dart:developer';

import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/keyboard_navigable_date_picker.dart';
import 'package:bookie_buddy_web/core/common/widgets/keyboard_navigable_time_picker.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_picker_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_notes_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/summary_amount_row.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_time_picker_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/selected_products_manager.dart';
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
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_form_validator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_request_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/additional_charges_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_phone_populator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_loader.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_search_rules.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/new_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_list_search_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_search_overlay_popup.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/bloc/add_booking_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_left_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_success_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_two_panel_layout.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/service_selection_section.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

// Conditional import for web-specific code
import '../helpers/web_helper_stub.dart'
    if (dart.library.html) '../helpers/web_helper_web.dart'
    as web_helper;
import '../widgets/old_booking_content_widget.dart';
part '../widgets/booking_content_widget.dart';
part '../widgets/sales_content_widget.dart';
part '../widgets/product_search_helper.dart';
part '../widgets/booking_date_section_widget.dart';

class NewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const NewBookingScreen({super.key, this.onClose});

  @override
  State<NewBookingScreen> createState() => NewBookingScreenState();
}

class NewBookingScreenState extends State<NewBookingScreen> {
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

  // Product loading coordinator — owns debouncer; replaces _loadProductsDebouncer
  late BookingProductLoader _productLoader;

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
  final _continueButtonFocusNode = FocusNode();
  final _advanceAmountFocusNode = FocusNode();
  final _securityAmountFocusNode = FocusNode();
  final _discountAmountFocusNode = FocusNode();
  final _confirmStepButtonFocusNode = FocusNode();

  /// Triggers auto-focus on a product's quantity field after adding from search
  final _focusOnProductQuantityKey = ValueNotifier<int?>(null);

  // Customization state
  bool showCustomization = false;

  late AddBookingCubit _addBookingCubit;

  void rebuild([VoidCallback? fn]) => setState(fn ?? () {});

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

    _addBookingCubit = getIt<AddBookingCubit>();

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      getAvailableProducts: getIt(),
      getProducts: getIt(),
      searchAndFilterProducts: getIt(),
    );
    _productLoader = BookingProductLoader(selectProductBloc: _selectProductBloc);

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
    if (kIsWeb) web_helper.removeBeforeUnloadListener();
    _removeSearchOverlay();
    clientNameController.removeListener(_onClientNameChanged);
    clientPhone1Controller.removeListener(_onClientPhoneChanged);
    clientPhone2Controller.removeListener(_onClientPhoneChanged);
    _searchResultsScrollController.removeListener(_handleSearchOverlayScroll);
    for (final f in _overlayItemFocusNodes.values) f.dispose();
    for (final d in <ChangeNotifier>[
      clientNameController, clientPhone1Controller, clientPhone2Controller,
      clientAddressController, startLocationController, pickupLocationController,
      destinationLocationController, staffNameController, advanceAmountController,
      securityAmountController, discountAmountController, descriptionController,
      serviceSearchController, runningKilometersController,
      _clientNameFocusNode, _productSearchFocusNode, _pickupDateFocusNode,
      _pickupTimeFocusNode, _returnDateFocusNode, _returnTimeFocusNode,
      _coolingPeriodFocusNode, _clientPhone1FocusNode, _clientPhone2FocusNode,
      _clientAddressFocusNode, _staffNameFocusNode, _notesFocusNode,
      _continueButtonFocusNode,
      _advanceAmountFocusNode, _securityAmountFocusNode, _discountAmountFocusNode,
      _confirmStepButtonFocusNode,
      selectedProductsNotifier, additionalChargesNotifier, documentsNotifier,
      _selectedSearchTypeIndex, _priceRange, _maxPriceNotifier,
      _isPriceFilterEnabled, _overlayProducts, _overlayIsLoading,
      _discountTypeNotifier, _searchResultsScrollController,
      _focusOnProductQuantityKey,
    ]) d.dispose();
    _clientPhone1FieldController.dispose();
    _clientPhone2FieldController.dispose();
    _selectProductBloc.close();
    _addBookingCubit.close();
    super.dispose();
  }

  String? _buildDescriptionWithPaymentSummary() {
    final description = descriptionController.text.trim();
    return description.isEmpty ? null : description;
  }

  bool hasUnsavedChanges() {
    final anyText = [
      clientNameController, clientPhone1Controller, clientPhone2Controller,
      clientAddressController, advanceAmountController, securityAmountController,
      discountAmountController, descriptionController, runningKilometersController,
    ].any((c) => c.text.trim().isNotEmpty);
    return _manualExtraRentalDays > 0 ||
        anyText ||
        selectedProductsNotifier.value.isNotEmpty ||
        additionalChargesNotifier.value.isNotEmpty ||
        documentsNotifier.value.isNotEmpty;
  }

  void _closeScreen() =>
      widget.onClose != null ? widget.onClose!() : Navigator.of(context).pop();

  Future<void> _handleBackNavigation() async {
    _removeSearchOverlay();
    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true && mounted) _closeScreen();
    } else {
      _closeScreen();
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
      BookingValidationHelper.showValidationErrors(context, clientResult);
    }
  }



  int _calculateRentalDays() => PaymentCalculator.calculateRentalDays(
    pickupDate: pickupDate,
    returnDate: returnDate,
    pickupTime: pickupTime,
    returnTime: returnTime,
  );

  int _getEffectiveRentalDays() => PaymentCalculator.getEffectiveRentalDays(
    baseDays: _calculateRentalDays(),
    manualExtraRentalDays: _manualExtraRentalDays,
  );

  int _getDaysMultiplierForProduct(ProductSelectedEntity product) =>
      PaymentCalculator.getDaysMultiplierForProduct(
        product: product,
        bookingType: selectedBookingType,
        effectiveRentalDays: _getEffectiveRentalDays(),
      );

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
    _productLoader.load(
      bookingType: selectedBookingType,
      selectedServiceId: serviceId,
      pickupDate: pickupDate,
      returnDate: returnDate,
      pickupTime: pickupTime,
      returnTime: returnTime,
      coolingPeriodDays: coolingPeriodDays,
      coolingPeriodMode: coolingPeriodMode,
      selectedProducts: selectedProductsNotifier.value,
    );
  }

  /// Helper method to check if current pickup date (sale date) is in the past
  bool _isPastDate() {
    final today = DateTime.now().dateOnly;
    return pickupDate.dateOnly.isBefore(today);
  }

  void _handleAddBookingState(BuildContext context, AddBookingState state) {
    state.when(
      initial: () {},
      loading: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      },
      success: (id, type) {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        _showBookingResult(id, type);
      },
      error: (message) {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
        context.showSnackBar(message, isError: true);
        log('Error: $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _addBookingCubit,
      child: BlocListener<AddBookingCubit, AddBookingState>(
        listener: _handleAddBookingState,
        child: PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
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
                selectedTab: selectedBookingType.toTabType(),
                onTabChanged: (tabType) {
                  _handleTabSwitch(tabType.toBookingType());
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
        ),
      ),
    );
  }


  Widget _buildMainContent() {
    if (selectedBookingType == BookingType.customWork) {
      return Container(child: Center(child: Text('Custom Work - Coming Soon')));
    }
    if (selectedBookingType == BookingType.oldBooking) {
      return OldBookingContentWidget(
        dateSection: _buildDateSelectionSection(),
        serviceSection: _buildServiceSelectionSection(),
        clientNameController: clientNameController,
        phone1FieldController: _clientPhone1FieldController,
        phone2FieldController: _clientPhone2FieldController,
        clientPhone1Controller: clientPhone1Controller,
        clientPhone2Controller: clientPhone2Controller,
        clientAddressController: clientAddressController,
        descriptionController: descriptionController,
        selectedAdvanceAccount: selectedAdvanceAccount,
        onAdvanceAccountChanged: (account) => rebuild(() => selectedAdvanceAccount = account),
        selectedProductsNotifier: selectedProductsNotifier,
        clientNameError: _clientNameError,
        onClientIdChanged: (id) => setState(() => selectedClientId = id),
        onCachePhoneE164: cachePhoneE164,
        getDaysMultiplier: _getDaysMultiplierForProduct,
        onConfirm: _handleConfirmOldBooking,
      );
    }
    // Same UI for both booking and sales
    return _buildBookingContent();
  }

  void _handleConfirmOldBooking() {
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

    if (selectedAdvanceAccount == null) {
      context.showSnackBar('Please select a payment option', isError: true);
      return;
    }

    _addBookingCubit.submitOldBooking(_buildOldBookingRequest());
  }

  BookingRequestEntity _buildOldBookingRequest() {
    return BookingRequestBuilder.buildOldBookingRequest(
      products: selectedProductsNotifier.value,
      bookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
      selectedClientId: selectedClientId,
      clientName: clientNameController.text.trim(),
      phone1Raw: clientPhone1Controller.text.trim(),
      phone2Raw: clientPhone2Controller.text.trim(),
      address: clientAddressController.text.trim(),
      bookedDate: _bookedDate,
      pickupDate: pickupDate,
      returnDate: returnDate,
      description: _buildDescriptionWithPaymentSummary(),
      advanceAccountId: selectedAdvanceAccount?.id,
    );
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

  void _onNavigateToClientDetails() {
    _clientNameFocusNode.requestFocus();
  }

  Widget _buildServiceSelectionSection() {
    return ServiceSelectionSection(
      selectedProductsNotifier: selectedProductsNotifier,
      searchBar: _buildProductSearchBar(),
      selectedBookingType: selectedBookingType,
      effectiveRentalDays: _getEffectiveRentalDays(),
      manualExtraRentalDays: _manualExtraRentalDays,
      clientNameFocusNode: _clientNameFocusNode,
      onIncrementRentalDays: _incrementRentalDays,
      onDecrementRentalDays: _decrementRentalDays,
      focusTargetProductKey: _focusOnProductQuantityKey,
      onNavigateToClientDetails: _onNavigateToClientDetails,
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
      confirmButtonFocusNode: _confirmStepButtonFocusNode,
    );
  }

  Widget _buildSummaryRow(
    String label,
    int amount, {
    Color? valueColor,
    bool isBold = false,
    bool isNegative = false,
  }) =>
      SummaryAmountRow(
        label,
        amount,
        valueColor: valueColor,
        isBold: isBold,
        isNegative: isNegative,
      );

  // Actions

  void _addAdditionalCharge() =>
      AdditionalChargesManager.showAddChargeDialog(
          context, additionalChargesNotifier);

  void _removeCharge(AdditionalChargesEntity charge) =>
      AdditionalChargesManager.removeCharge(charge, additionalChargesNotifier);

  void _handleConfirmBooking() {
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

    if (selectedBookingType == BookingType.sales) {
      _addBookingCubit.submitSale(_buildSalesRequest());
    } else {
      _addBookingCubit.submitBooking(
        _buildBookingRequest(),
        documents: documentsNotifier.value.isEmpty
            ? null
            : List<DocumentFileEntity>.from(documentsNotifier.value),
      );
    }
  }

  void _showBookingResult(int id, BookingType type) {
    if (!mounted) return;
    if (id != 0) {
      showBookingSuccessDialog(
        context: context,
        id: id,
        type: type,
        sendPdfToWhatsApp: sendPdfToWhatsApp,
        isMounted: () => mounted,
        onClose: widget.onClose,
      );
    } else {
      context.showSnackBar(
        type == BookingType.oldBooking
            ? 'Old booking saved successfully!'
            : type == BookingType.sales
                ? 'Sale created successfully!'
                : 'Booking created successfully!',
      );
      _closeScreen();
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

  SalesRequestEntity _buildSalesRequest() {
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
