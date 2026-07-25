
import 'dart:developer';

import 'package:bookie_buddy_web/core/common/entities/applied_tax_entity/applied_tax_entity.dart';
import 'package:bookie_buddy_web/core/common/entities/tax_summary_entity/tax_summary_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_phone_number_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/keyboard_navigable_date_picker.dart';
import 'package:bookie_buddy_web/core/common/widgets/keyboard_navigable_time_picker.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/additional_charges_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_phone_populator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_loader.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_search_rules.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_picker_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_notes_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_time_picker_field.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_left_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_two_panel_layout.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/service_selection_section.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/send_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/send_sale_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/bloc/edit_booking_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_date_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/product_mapper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_search_overlay_popup.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_list_search_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_form_validator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_document_upload_section.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/phone_number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';

part '../helpers/edit_booking_initializer.dart';
part '../helpers/edit_booking_change_detector.dart';
part '../helpers/edit_booking_submission_handler.dart';
part '../helpers/edit_booking_search_handler.dart';

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
  State<EditNewBookingScreen> createState() =>
      EditNewBookingScreenState();
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
  // Opt-in: only (re)send the invoice to WhatsApp when the user ticks the box.
  bool sendPdfToWhatsApp = false;

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
  String? __originalClientPhone1E164;
  String? __originalClientPhone2E164;
  String? _originalClientAddress;
  int? _originalStaffId;
  int? _originalSecurityAmount;
  int? _originalDiscountAmount;
  List<AdditionalChargesEntity>? _originalAdditionalCharges;
  List<DocumentFileEntity>?
  _originalDocuments; // Track original documents for removal detection
  String? _originalRunningKm; // Track original running kilometers
  DeliveryStatus? _originalDeliveryStatus; // Track original delivery status
  int _originalCoolingPeriodDays = 0; // Track original cooling period
  CoolingPeriodMode _originalCoolingPeriodMode = CoolingPeriodMode.after;
  int? _originalRentalDays; // Rental days computed from original booking entity
  bool _hasLoadedInitialProducts = false; // Prevent duplicate API calls on init

  bool showCustomization = false;

  late EditBookingCubit _editBookingCubit;

  void rebuild([VoidCallback? fn]) => setState(fn ?? () {});

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

    _editBookingCubit = getIt<EditBookingCubit>();

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
      final staffId =
          widget.bookingDetails?.staffId ?? widget.saleDetails?.staffId;
      final staffName =
          widget.bookingDetails?.staffName ?? widget.saleDetails?.staffName;
      if (staffId != null) {
        context.read<StaffSearchCubit>().getAllStaffs(
          staffId,
          StaffEntity(id: staffId, name: staffName ?? 'Staff', phoneNumber: ''),
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
    for (final f in _overlayItemFocusNodes.values) f.dispose();
    for (final d in <ChangeNotifier>[
      clientNameController, clientPhone1Controller, clientPhone2Controller,
      clientAddressController, startLocationController, pickupLocationController,
      destinationLocationController, staffNameController, advanceAmountController,
      securityAmountController, discountAmountController, descriptionController,
      serviceSearchController, runningKilometersController,
      _clientNameFocusNode, _productSearchFocusNode, _clientPhone1FocusNode,
      _clientPhone2FocusNode, _clientAddressFocusNode,
      selectedProductsNotifier, additionalChargesNotifier, documentsNotifier,
      _selectedSearchTypeIndex, _priceRange, _maxPriceNotifier,
      _isPriceFilterEnabled, _overlayProducts, _overlayIsLoading,
      _discountTypeNotifier,
    ]) d.dispose();
    _clientPhone1FieldController.dispose();
    _clientPhone2FieldController.dispose();
    _selectProductBloc.close();
    _editBookingCubit.close();
    super.dispose();
  }


  /// Validates client details and continues to next step if valid
  void _validateAndContinue() {
    setState(() {
      _clientNameError = null;
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
        _staffNameError = validationResult.fieldErrors['staff'];
      });
      BookingValidationHelper.showValidationErrors(context, validationResult);
    }
  }

  void _handleEditBookingState(BuildContext context, EditBookingState state) {
    state.when(
      initial: () {},
      loading: () {
        GlobalLoadingOverlay.show(context);
      },
      success: (isBooking) async {
        GlobalLoadingOverlay.hide();
        if (!mounted) return;

        if (sendPdfToWhatsApp) {
          try {
            if (isBooking && widget.bookingDetails != null) {
              await getIt<SendInvoiceUseCase>()(
                widget.bookingDetails!.id,
                true,
              );
            } else if (!isBooking && widget.saleDetails != null) {
              await getIt<SendSaleInvoiceUsecase>()(
                widget.saleDetails!.id,
                sendWhatsApp: true,
              );
            }
          } catch (e) {
            log('Failed to send invoice to WhatsApp: $e');
          }
        }

        if (!mounted) return;
        context.showSnackBar(
          isBooking ? 'Booking updated successfully!' : 'Sale updated successfully!',
        );
        if (widget.onClose != null) {
          widget.onClose!();
        } else {
          Navigator.of(context).pop(isBooking ? true : null);
        }
      },
      error: (message) {
        GlobalLoadingOverlay.hide();
        if (!mounted) return;
        context.showSnackBar(_formatBookingError(message), isError: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _editBookingCubit,
      child: BlocListener<EditBookingCubit, EditBookingState>(
        listener: _handleEditBookingState,
        child: PopScope(
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
      ),
    ));
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
    return BookingTwoPanelLayout(
      left: BookingLeftPanel(
        dateSection: _buildDateSelectionSection(),
        serviceSection: _buildServiceSelectionSection(),
        showCustomization: showCustomization,
        customizationProducts: selectedProductsNotifier.value,
        onBackFromCustomization: () => rebuild(() => showCustomization = false),
        onSaveCustomization: (product, measurements) {
          rebuild(() {
            selectedProductsNotifier.value =
                SelectedProductsManager.updateMeasurements(
                  currentProducts: selectedProductsNotifier.value,
                  updatedProduct: product,
                  measurements: measurements,
                );
          });
        },
      ),
      right: _buildRightSidePanel(),
    );
  }

  Future<void> _selectDate({required bool isPickup}) async {
    final initialDate = isPickup ? pickupDate : returnDate;
    final now = DateTime.now();
    final picked = await showKeyboardDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: isPickup ? DateTime(now.year - 5) : pickupDate,
      lastDate: now.add(const Duration(days: 365 * 2)),
      selectedColor: const Color(0xFF6132E4),
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
        _updateCoolingPeriod();
      });
      _loadAvailableProducts();
    }
  }

  Future<void> _selectTime({required bool isPickup}) async {
    final initialTime =
        isPickup ? (pickupTime ?? TimeOfDay.now()) : (returnTime ?? TimeOfDay.now());
    final picked = await showKeyboardTimePicker(
      context: context,
      initialTime: initialTime,
      selectedColor: const Color(0xFF6132E4),
    );
    if (picked != null) {
      setState(() {
        isPickup ? pickupTime = picked : returnTime = picked;
      });
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

  /// Handles the cooling-settings change cascade:
  /// recalculates cooling period → checks selected availability.
  ///
  /// Note: this intentionally does NOT also call [_loadAvailableProducts].
  /// Both that loader and [_checkSelectedProductsAvailability] hit the same
  /// `available-products` endpoint, which previously caused the availability
  /// API to fire twice on every cooling change. The availability check already
  /// sends the selected variant ids for the new cooling window (and surfaces the
  /// unavailable-products dialog); the searchable product list refreshes on the
  /// next search interaction. Called from the cooling-mode toggle and dropdown.
  void _onCoolingSettingsChanged() {
    _updateCoolingPeriod();
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
      final notFoundIds = await getIt<IProductRepository>()
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
    return ServiceSelectionSection(
      selectedProductsNotifier: selectedProductsNotifier,
      searchBar: _buildProductSearchBar(),
      selectedBookingType: selectedBookingType,
      effectiveRentalDays: _calculateRentalDays(),
      manualExtraRentalDays: 0,
      clientNameFocusNode: _clientNameFocusNode,
      onIncrementRentalDays: () {},
      onDecrementRentalDays: () {},
      showDayControls: false,
    );
  }

  int _calculateRentalDays() {
    final result = PaymentCalculator.calculateRentalDays(
      pickupDate: pickupDate,
      returnDate: returnDate,
      pickupTime: pickupTime,
      returnTime: returnTime,
    );
    // Fallback: if calculation returns 1 (e.g., because screen-state pickupDate
    // is incorrect when booking.pickupDate is null from the API), use the
    // original booking entity's dates for a more accurate computation.
    if ((result <= 1) && _originalRentalDays != null && _originalRentalDays! > 1) {
      return _originalRentalDays!;
    }
    return result;
  }

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

  /// Recalculates against the booking's own frozen tax snapshot (never the
  /// shop's current live config) so editing amounts after creation stays
  /// accurate even if the shop's tax rules changed since.
  TaxSummaryEntity _calculateTaxSummary({
    double productTotal = 0,
    double additionalCharges = 0,
    double securityAmount = 0,
    double discountAmount = 0,
  }) => (_originalBooking?.appliedTaxes ??
          widget.saleDetails?.appliedTaxes ??
          const [])
      .calculateTaxSummary(
    productTotal: productTotal,
    additionalCharges: additionalCharges,
    securityAmount: securityAmount,
    discountAmount: discountAmount,
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
      calculateTaxSummary: _calculateTaxSummary,
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
      calculateTaxSummary: _calculateTaxSummary,
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
            color: Colors.black.withValues(alpha: 0.02),
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
                    label: 'Pickup time',
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
                    label: 'Return time',
                    value: returnTime?.format(context) ?? '',
                    onTap: () => _selectTime(isPickup: false),
                  ),
                ),

                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: _buildCoolingPeriodSection(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCoolingPeriodSection() {
    return Column(
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
                    coolingPeriodMode.isAfter ? '(after)' : '(before)',
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
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                coolingPeriodMode.isAfter ? 'After' : 'Before',
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
                const standardValues = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
                final hasCustomValue = !standardValues.contains(currentDays);
                return DropdownButton<int>(
                  value: currentDays,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                  items: [
                    const DropdownMenuItem(value: 0, child: Text('None')),
                    if (hasCustomValue)
                      DropdownMenuItem(
                        value: currentDays,
                        child: Text('$currentDays days'),
                      ),
                    ...List.generate(10, (index) {
                      final days = index + 1;
                      return DropdownMenuItem(
                        value: days,
                        child: Text('$days day${days > 1 ? 's' : ''}'),
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
                  const Text(
                    'Client details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),
                  _buildClientNameField(),
                  const SizedBox(height: _fieldSpacing),
                  _buildPhone1Field(),
                  const SizedBox(height: _fieldSpacing),
                  _buildPhone2Field(),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: clientAddressController,
                    hint: 'place',
                    focusNode: _clientAddressFocusNode,
                    nextFocusNode: null,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  if (selectedBookingType == BookingType.booking) ...[
                    const SizedBox(height: 8),
                    BookingDocumentUploadSection(
                      documentsNotifier: documentsNotifier,
                    ),
                    const SizedBox(height: 7),
                  ],
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
                  BookingNotesField(controller: descriptionController),
                  const SizedBox(height: 7),
                  _buildVehicleKmField(),
                ],
              ),
            ),
          ),
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
                _buildWhatsAppOption(),
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

  Widget _buildClientNameField() {
    return BlocListener<ClientCubit, ClientState>(
      listener: (context, state) {
        if (state.selectedClient != null) {
          final client = state.selectedClient!;
          clientNameController.text = client.name;
          BookingPhonePopulator.setPhoneFieldValue(
            _clientPhone1FieldController,
            clientPhone1Controller,
            phoneNumber: client.phone1 > 0 ? client.phone1.toString() : null,
            e164: client.phone1E164,
          );
          BookingPhonePopulator.setPhoneFieldValue(
            _clientPhone2FieldController,
            clientPhone2Controller,
            phoneNumber: (client.phone2 ?? 0) > 0 ? client.phone2.toString() : null,
            e164: client.phone2E164,
          );
          selectedClientId = client.id;
        }
      },
      child: ClientSearchNameField(
        nameController: clientNameController,
        focusNode: _clientNameFocusNode,
        hitText: 'Search client by name',
        onClear: () {
          clientNameController.clear();
          BookingPhonePopulator.setPhoneFieldValue(
            _clientPhone1FieldController,
            clientPhone1Controller,
            phoneNumber: null,
            e164: null,
          );
          BookingPhonePopulator.setPhoneFieldValue(
            _clientPhone2FieldController,
            clientPhone2Controller,
            phoneNumber: null,
            e164: null,
          );
          clientAddressController.clear();
          selectedClientId = null;
        },
        errorText: _clientNameError,
      ),
    );
  }

  Widget _buildPhone1Field() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        final isClientSelected = state.selectedClient != null;
        return CustomPhoneNumberField(
          controller: _clientPhone1FieldController,
          hintText: 'Phone',
          readOnly: isClientSelected,
          textInputAction: TextInputAction.next,
          onChanged: (phone) {
            final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
            cachePhoneE164(
              rawPhoneNumber: digits,
              e164: phoneNumberToE164(phone),
            );
            if (clientPhone1Controller.text != digits) {
              clientPhone1Controller.value = TextEditingValue(
                text: digits,
                selection: TextSelection.collapsed(offset: digits.length),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildPhone2Field() {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        final isClientSelected = state.selectedClient != null;
        return CustomPhoneNumberField(
          controller: _clientPhone2FieldController,
          hintText: 'Phone 2',
          readOnly: isClientSelected,
          isRequired: false,
          textInputAction: TextInputAction.next,
          onChanged: (phone) {
            final digits = phone.nsn.replaceAll(RegExp(r'[^0-9]'), '');
            cachePhoneE164(
              rawPhoneNumber: digits,
              e164: phoneNumberToE164(phone),
            );
            if (clientPhone2Controller.text != digits) {
              clientPhone2Controller.value = TextEditingValue(
                text: digits,
                selection: TextSelection.collapsed(offset: digits.length),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildVehicleKmField() {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
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
                  _buildLocationsSection(),
                  BookingTextFieldBuilder.buildSectionHeader(
                    'Payment details',
                    optional: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  _buildSecurityAmountSection(),
                  const SizedBox(height: _fieldSpacing),
                  _buildDiscountField(),
                  const SizedBox(height: 14),
                  _buildAdditionalChargesSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildPaymentPanelSummaryBar(),
        ],
      ),
    );
  }

  Widget _buildLocationsSection() {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
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
    );
  }

  Widget _buildSecurityAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookingTextFieldBuilder.buildRightPanelTextField(
          controller: securityAmountController,
          hint: 'Security amount',
          isNumber: true,
        ),
        const SizedBox(height: 8),
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
                  AccountSelectionField(
                    selectedAccount: selectedSecurityAccount,
                    initialAccountId: widget.bookingDetails?.securityAccountId,
                    onChanged: (account) => rebuild(() => selectedSecurityAccount = account),
                    label: 'Security Payment Option',
                  ),
                  const SizedBox(height: 8),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildDiscountField() {
    return Row(
      children: [
        Expanded(
          child: BookingTextFieldBuilder.buildRightPanelTextField(
            controller: discountAmountController,
            hint: isDiscountPercentage ? 'Discount %' : 'Discount amount',
            isNumber: true,
            suffix: ValueListenableBuilder<TextEditingValue>(
              valueListenable: discountAmountController,
              builder: (context, val, _) {
                final input = val.text.trim().toIntOrNull() ?? 0;
                final total = _getDiscountProductBase();
                if (input <= 0 || total <= 0) return const SizedBox.shrink();
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
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
          onSelected: (value) {
            setState(() {
              final switchToPercent = value == 'percentage';
              if (switchToPercent != isDiscountPercentage) {
                final input =
                    discountAmountController.text.trim().toIntOrNull() ?? 0;
                final total = _getDiscountProductBase();
                if (input > 0 && total > 0) {
                  if (switchToPercent) {
                    final pct =
                        (input / total * 100).round().clamp(0, 100);
                    discountAmountController.text = pct.toString();
                  } else {
                    final amount = (total * input / 100).round();
                    discountAmountController.text = amount.toString();
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
              'Additional charges',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
            InkWell(
              onTap: _addAdditionalCharge,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6132E4).withValues(alpha: 0.1),
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
      ],
    );
  }

  /// Opt-in checkbox to (re)send the invoice PDF to the client's WhatsApp on
  /// save. Only visible when the shop has the feature AND the user has made
  /// changes to the form.
  Widget _buildWhatsAppOption() {
    if (!context.read<UserCubit>().hasFeature(
      AppPremiumFeatures.whatsappMessage,
    )) {
      return const SizedBox.shrink();
    }
    if (!_hasAnyFormChanges()) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: sendPdfToWhatsApp,
              onChanged: (v) => rebuild(() => sendPdfToWhatsApp = v ?? false),
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
    );
  }

  Widget _buildPaymentPanelSummaryBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
    );
  }
}
