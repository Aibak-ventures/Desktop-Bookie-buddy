import 'dart:developer';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/additional_charges_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_phone_populator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_loader.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_search_rules.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_picker_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_notes_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_time_picker_field.dart';
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
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/product_mapper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_search_overlay_popup.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_list_search_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/product_list_table_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_form_validator.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

part '../helpers/edit_booking_initializer.dart';
part '../helpers/edit_booking_change_detector.dart';
part '../helpers/edit_booking_submission_handler.dart';
part '../helpers/edit_booking_search_handler.dart';

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
  final _discountTypeNotifier = ValueNotifier<bool>(false);
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

  // Product loading coordinator — owns debouncer; replaces _loadProductsDebouncer
  late BookingProductLoader _productLoader;

  // Search overlay management
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;
  // Reactive overlay state â€” updated without recreating the OverlayEntry
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

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Search overlay keyboard navigation
  final Map<int, FocusNode> _overlayItemFocusNodes = {};

  // Focus nodes for client details navigation
  final _clientNameFocusNode = FocusNode();
  final _productSearchFocusNode = FocusNode();
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
  CoolingPeriodMode _originalCoolingPeriodMode = CoolingPeriodMode.after;
  bool _hasLoadedInitialProducts = false; // Prevent duplicate API calls on init

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
    _productLoader = BookingProductLoader(selectProductBloc: _selectProductBloc);

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

      // ðŸ”„ Load available products immediately using check-availability API
      // This ensures only products available for the booking dates are shown
      if (!_hasLoadedInitialProducts) {
        _hasLoadedInitialProducts = true;
        _loadAvailableProducts();
      }
    });
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
    for (final focusNode in _overlayItemFocusNodes.values) {
      focusNode.dispose();
    }
    serviceSearchController.dispose();
    _productSearchFocusNode.dispose();
    _selectProductBloc.close();
    _selectedSearchTypeIndex.dispose();
    _priceRange.dispose();
    _maxPriceNotifier.dispose();
    _isPriceFilterEnabled.dispose();
    runningKilometersController.dispose();
    _overlayProducts.dispose();
    _overlayIsLoading.dispose();
    _discountTypeNotifier.dispose();
    super.dispose();
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

    final validationResult = BookingFormValidator.validateClientDetails(
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
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
                              selectedProductsNotifier.value =
                                  SelectedProductsManager.updateMeasurements(
                                    currentProducts:
                                        selectedProductsNotifier.value,
                                    updatedProduct: product,
                                    measurements: measurements,
                                  );
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
        // Keep coolingPeriodDate in sync whenever dates change.
        _updateCoolingPeriod();
      });
      // ðŸ”„ Reload available products for the new date range
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
      // ðŸ”„ Reload available products for the new time
      _loadAvailableProducts();
    }
  }

  /// Load available products using the check-availability API.
  /// Called on screen entry and whenever pickup/return date or time changes.
  void _loadAvailableProducts() {
    _productLoader.load(
      bookingType: selectedBookingType,
      selectedServiceId: selectedServiceId,
      pickupDate: pickupDate,
      returnDate: returnDate,
      pickupTime: pickupTime,
      returnTime: returnTime,
      coolingPeriodDays: coolingPeriodDays,
      coolingPeriodMode: coolingPeriodMode,
      selectedProducts: selectedProductsNotifier.value,
      bookingId: widget.bookingId,
    );
  }

  /// Handles the full cooling-settings change cascade:
  /// recalculates cooling period → reloads products → checks selected availability.
  /// Called from both the cooling-mode toggle and the cooling-days dropdown.
  void _onCoolingSettingsChanged() {
    _updateCoolingPeriod();
    _loadAvailableProducts();
    _checkSelectedProductsAvailability();
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
          Expanded(
            child: ProductListTableWidget(
              selectedProductsNotifier: selectedProductsNotifier,
              selectedBookingType: selectedBookingType,
              effectiveRentalDays: _calculateRentalDays(),
              manualExtraRentalDays: 0,
              clientNameFocusNode: _clientNameFocusNode,
              onIncrementRentalDays: () {},
              onDecrementRentalDays: () {},
              showDayControls: false,
            ),
          ),
        ],
      ),
    );
  }

  int _calculateRentalDays() => PaymentCalculator.calculateRentalDays(
    pickupDate: pickupDate,
    returnDate: returnDate,
    pickupTime: pickupTime,
    returnTime: returnTime,
  );

  void _updateCoolingPeriod() {
    coolingPeriodDate = BookingDateCalculator.coolingPeriodDate(
      pickupDate: pickupDate,
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
    );
  }

  int _getDiscountProductBase() => PaymentCalculator.getDiscountProductBase(
    selectedProducts: selectedProductsNotifier.value,
    additionalCharges: additionalChargesNotifier.value,
    bookingType: selectedBookingType,
    effectiveRentalDays: _calculateRentalDays(),
  );

  Widget _buildSummaryBreakdownCard() {
    return BookingAmountSummary(
      selectedProductsNotifier: selectedProductsNotifier,
      additionalChargesNotifier: additionalChargesNotifier,
      advanceAmountController: advanceAmountController,
      discountAmountController: discountAmountController,
      isDiscountPercentage: _discountTypeNotifier,
      securityAmountController: securityAmountController,
      securityMethodLabel: selectedSecurityAccount?.accountName ?? 'Cash',
      isSales: selectedBookingType == BookingType.sales,
      calculateRentalDays: _calculateRentalDays,
      advanceLabel: 'Paid',
      totalRemainingLabel: 'Balance Amount',
    );
  }

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
      calculateRentalDays: _calculateRentalDays,
      advanceLabel: 'Paid',
      totalRemainingLabel: 'Balance Amount',
      onShowCustomization: () => setState(() => showCustomization = true),
      bookingStatus: bookingStatus,
      bookingCompletedDate: bookingCompletedDate,
      onConfirm: _handleSaveBooking,
      confirmLabel: 'Save Change',
    );
  }

  void _addAdditionalCharge() =>
      AdditionalChargesManager.showAddChargeDialog(
          context, additionalChargesNotifier);

  void _removeCharge(AdditionalChargesEntity charge) =>
      AdditionalChargesManager.removeCharge(charge, additionalChargesNotifier);


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
              child: BookingDatePickerField(
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
                  child: BookingDatePickerField(
                    label: 'Pickup date',
                    value: pickupDate.format(),
                    onTap: () => _selectDate(isPickup: true),
                  ),
                ),
                const SizedBox(width: 12),
                // Pickup Time
                Expanded(
                  flex: 2,
                  child: BookingTimePickerField(
                    label: 'time',
                    value: pickupTime?.format(context) ?? '',
                    onTap: () => _selectTime(isPickup: true),
                  ),
                ),
                const SizedBox(width: 24),

                // Return Date
                Expanded(
                  flex: 3,
                  child: BookingDatePickerField(
                    label: 'Return date',
                    value: returnDate.format(),
                    onTap: () => _selectDate(isPickup: false),
                  ),
                ),
                const SizedBox(width: 12),
                // Return Time
                Expanded(
                  flex: 2,
                  child: BookingTimePickerField(
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
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ],
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
                              _onCoolingSettingsChanged();
                            },
                            child: Text(
                              coolingPeriodMode.isAfter ? "After" : "Before",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
                                    _onCoolingSettingsChanged();
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
                        // phone1 is non-nullable int â€” defaults to 0 when API returns null.
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
                  // const SizedBox(height: 16),
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
                  BookingNotesField(controller: descriptionController),

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
                                equiv = 'â‰ˆ â‚¹$amount';
                              } else {
                                final pct = input / total * 100;
                                final pctStr = pct % 1 == 0
                                    ? '${pct.round()}'
                                    : pct.toStringAsFixed(1);
                                equiv = 'â‰ˆ $pctStr%';
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
                                  // amount â†’ percentage
                                  final pct = (input / total * 100)
                                      .round()
                                      .clamp(0, 100);
                                  discountAmountController.text = pct
                                      .toString();
                                } else {
                                  // percentage â†’ amount
                                  final amount = (total * input / 100).round();
                                  discountAmountController.text = amount
                                      .toString();
                                }
                              }
                              isDiscountPercentage = switchToPercent;
                              _discountTypeNotifier.value = switchToPercent;
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
                                const Text('Amount (â‚¹)'),
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
                                      'â‚¹${c.amount}',
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
}
