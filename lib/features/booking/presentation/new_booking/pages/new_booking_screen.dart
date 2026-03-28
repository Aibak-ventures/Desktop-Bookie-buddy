import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/data/models/request_sales_model/request_sales_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/new_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/booking_sales_right_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_search_overlay_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_selected_products_list_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_product_list_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Conditional import for web-specific code
import 'web_helper_stub.dart'
    if (dart.library.html) 'web_helper_web.dart'
    as web_helper;
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_client_details_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_payment_summary_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_selection_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/old_booking_right_panel.dart';

class NewBookingScreen extends StatefulWidget {
  final VoidCallback? onClose;

  const NewBookingScreen({super.key, this.onClose});

  @override
  State<NewBookingScreen> createState() => NewBookingScreenState();
}

class NewBookingScreenState extends State<NewBookingScreen>
    with BookingFormMixin<NewBookingScreen> {
  // ── Shared: controllers, notifiers, overlay, product bloc ─────────────────
  final _form = BookingFormControllers();

  @override
  BookingFormControllers get form => _form;

  // ── Tab & form ─────────────────────────────────────────────────────────────
  BookingType selectedBookingType = BookingType.booking;
  final _formKey = GlobalKey<FormState>();

  // ── Date / time getters/setters (bridged to form) ──────────────────────────
  DateTime get pickupDate => _form.pickupDate;
  set pickupDate(DateTime v) => _form.pickupDate = v;
  DateTime get returnDate => _form.returnDate;
  set returnDate(DateTime v) => _form.returnDate = v;
  DateTime? get coolingPeriodDate => _form.coolingPeriodDate;
  set coolingPeriodDate(DateTime? v) => _form.coolingPeriodDate = v;
  TimeOfDay? get coolingPeriodTime => _form.coolingPeriodTime;
  set coolingPeriodTime(TimeOfDay? v) => _form.coolingPeriodTime = v;
  TimeOfDay? get pickupTime => _form.pickupTime;
  set pickupTime(TimeOfDay? v) => _form.pickupTime = v;
  TimeOfDay? get returnTime => _form.returnTime;
  set returnTime(TimeOfDay? v) => _form.returnTime = v;

  // ── Service / search filter getters/setters ────────────────────────────────
  int? get selectedServiceId => _form.selectedServiceId;
  set selectedServiceId(int? v) => _form.selectedServiceId = v;
  List<String> get _searchTypes => _form.searchTypes;
  int get coolingPeriodDays => _form.coolingPeriodDays;
  set coolingPeriodDays(int v) => _form.coolingPeriodDays = v;

  // ── UI state ───────────────────────────────────────────────────────────────
  bool sendPdfToWhatsApp = false;
  bool decreaseStockForPastDate = false;
  DateTime? _bookedDate;
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;
  final _searchResultsScrollController = ScrollController();

  // State variables for payment method
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  // UI Constants

  // Customization state
  bool showCustomization = false;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    // Add listeners to detect manual changes
    _form.clientNameController.addListener(onClientNameChanged);
    _form.clientPhone1Controller.addListener(onClientPhoneChanged);
    _form.clientPhone2Controller.addListener(onClientPhoneChanged);
    _searchResultsScrollController.addListener(
      () => handleSearchOverlayScroll(_searchResultsScrollController),
    );

    // Set up web beforeUnload listener
    if (kIsWeb) {
      web_helper.setupBeforeUnloadListener(() => hasUnsavedChanges());
    }
    setupSelectProductBlocListener();

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      context.read<StaffSearchCubit>().getAllStaffs();
      initializeCoolingPeriod(context);
    });
  }

  @override
  void dispose() {
    if (kIsWeb) {
      web_helper.removeBeforeUnloadListener();
    }
    _form.clientNameController.removeListener(onClientNameChanged);
    _form.clientPhone1Controller.removeListener(onClientPhoneChanged);
    _form.clientPhone2Controller.removeListener(onClientPhoneChanged);
    _searchResultsScrollController.removeListener(
      () => handleSearchOverlayScroll(_searchResultsScrollController),
    );
    disposeSelectProductBlocListener();
    _searchResultsScrollController.dispose();
    _form.dispose();
    super.dispose();
  }

  // ── UI Building methods ────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await handleBackNavigation();
      },
      child: Container(
        color: const Color(0xFFF5F6FA),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              NewBookingAppBar(
                selectedTab: _convertBookingTypeToTabType(selectedBookingType),
                onTabChanged: (tabType) =>
                    handleTabSwitch(_convertTabTypeToBookingType(tabType)),
                onBack: handleBackNavigation,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: buildMainContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMainContent() {
    if (selectedBookingType == BookingType.customWork) {
      return const Center(child: Text('Custom Work - Coming Soon'));
    }
    if (selectedBookingType == BookingType.oldBooking) {
      return _buildOldBookingContent();
    }
    return buildBookingContent();
  }

  Widget buildBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookingDateSelectionWidget(
                isSales: selectedBookingType == BookingType.sales,
                pickupDate: pickupDate,
                returnDate: returnDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodDays: coolingPeriodDays,
                onSelectPickupDate: () => selectDate(isPickup: true),
                onSelectReturnDate: () => selectDate(isPickup: false),
                onSelectPickupTime: () => selectTime(isPickup: true),
                onSelectReturnTime: () => selectTime(isPickup: false),
                onCoolingPeriodChanged: (val) {
                  setState(() => coolingPeriodDays = val);
                  loadProductsForService(
                    selectedBookingType,
                    selectedServiceId,
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: showCustomization
                      ? ProductCustomizationWidget(
                          key: const ValueKey('customization'),
                          onBack: () =>
                              setState(() => showCustomization = false),
                          onSaveForProduct: _handleUpdateProductMeasurements,
                          selectedProducts: _form.selectedProductsNotifier.value
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
                          child: buildServiceSelectionSection(),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(width: 340, child: _buildRightSidePanel()),
      ],
    );
  }

  Widget buildServiceSelectionSection() {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchAndFilterHeader(),
          BookingProductListHeaderWidget(
            isSales: selectedBookingType == BookingType.sales,
            hasVariants: hasAnyProductWithVariants(),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BookingSelectedProductsListWidget(
              form: _form,
              selectedBookingType: selectedBookingType,
              calculateRentalDays: calculateRentalDays,
              shouldMultiplyByDays: shouldMultiplyByDays,
              hasAnyProductWithVariants: hasAnyProductWithVariants,
              onDecrement: decrementQuantity,
              onIncrement: incrementQuantity,
              onSaveTypedQuantity: saveTypedQuantity,
              onStartEditingPrice: startEditingPrice,
              onSaveEditingPrice: saveEditingPrice,
              onRemove: removeProduct,
              getQuantityController: getQuantityController,
              getQuantityFocusNode: (key) => getQuantityFocusNode(key),
              getQuantityKey: (product) => quantityKey(product),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: CompositedTransformTarget(
              link: _form.searchLayerLink,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ValueListenableBuilder(
                  valueListenable: _form.selectedSearchTypeIndex,
                  builder: (context, searchTypeIndex, _) {
                    return ValueListenableBuilder(
                      valueListenable: _form.isPriceFilterEnabled,
                      builder: (context, isPriceEnabled, _) {
                        // Build active filter badge text
                        String? filterText;
                        if (searchTypeIndex != 0) {
                          filterText = _searchTypes[searchTypeIndex];
                        }
                        if (isPriceEnabled) {
                          filterText = filterText != null
                              ? '$filterText | Price'
                              : 'Price';
                        }

                        return TextField(
                          controller: _form.serviceSearchController,
                          onTap: () {
                            if (_form.serviceSearchController.text
                                .trim()
                                .isEmpty) {
                              searchAllProductsForOverlay(
                                bookingType: selectedBookingType,
                                pickupDate: pickupDate,
                                returnDate: returnDate,
                                pickupTime: pickupTime,
                                returnTime: returnTime,
                                showSearchOverlay: showSearchOverlay,
                              );
                            }
                          },
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
                            suffixIcon: filterText != null
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 8),
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
                                      ).withValues(alpha: 0.1),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
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
                            onSearchChanged(selectedBookingType, value);
                            if (value.isEmpty) {
                              _form.removeSearchOverlay();
                            } else {
                              showSearchOverlay();
                              // Dispatch immediately for every keystroke
                              final query = value.trim().toLowerCase();
                              final isSales =
                                  selectedBookingType == BookingType.sales;
                              final serviceIdToUse =
                                  (selectedServiceId == null ||
                                      selectedServiceId == -1)
                                  ? null
                                  : selectedServiceId;
                              String searchType;
                              switch (_form.selectedSearchTypeIndex.value) {
                                case 1:
                                  searchType = 'category';
                                  break;
                                case 2:
                                  searchType = 'model';
                                  break;
                                case 3:
                                  final st = _form.currentServiceType;
                                  if (st != null &&
                                      st.isMultiVariantProductType) {
                                    if (st == MainServiceType.dress ||
                                        st == MainServiceType.costume) {
                                      searchType = 'size';
                                    } else if (st == MainServiceType.gadgets) {
                                      searchType = 'serial_number';
                                    } else {
                                      searchType = 'variant';
                                    }
                                  } else {
                                    searchType = 'color';
                                  }
                                  break;
                                default:
                                  searchType = 'name';
                              }
                              _form.selectProductBloc.add(
                                SelectProductEvent.searchProducts(
                                  serviceId: serviceIdToUse,
                                  query: query,
                                  type: searchType,
                                  startPrice: _form.isPriceFilterEnabled.value
                                      ? _form.priceRange.value.start.round()
                                      : null,
                                  endPrice: _form.isPriceFilterEnabled.value
                                      ? _form.priceRange.value.end.round()
                                      : null,
                                  pickupDate: pickupDate.format(),
                                  returnDate: returnDate.format(),
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
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildFilterButton(),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IconButton(
        onPressed: () {
          _form.removeSearchOverlay();
          showProductFilterDialog(
            bookingType: selectedBookingType,
            selectedServiceId: selectedServiceId,
            onServiceIdChanged: (id) => setState(() => selectedServiceId = id),
          );
        },
        icon: const Icon(Icons.tune, size: 20, color: Color(0xFF6132E4)),
      ),
    );
  }

  Widget _buildRightSidePanel() {
    if (selectedBookingType == BookingType.sales)
      return _buildSalesSinglePanel();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _bookingStep == 0
          ? BookingClientDetailsPanel(
              form: _form,
              isSales: false,
              clientNameError: _clientNameError,
              phoneError: _phoneError,
              staffNameError: _staffNameError,
              sendPdfToWhatsApp: sendPdfToWhatsApp,
              onSendPdfChanged: (v) => setState(() => sendPdfToWhatsApp = v),
              onContinue: _validateAndContinue,
              calculateRentalDays: calculateRentalDays,
            )
          : BookingPaymentSummaryPanel(
              form: _form,
              selectedPaymentMethod: _selectedPaymentMethod,
              onPaymentMethodChanged: (method) =>
                  setState(() => _selectedPaymentMethod = method),
              onBack: () => setState(() => _bookingStep = 0),
              summarySection: _buildSummarySection(),
            ),
    );
  }

  Widget _buildSalesSinglePanel() {
    return BookingSalesRightPanel(
      form: _form,
      phoneError: _phoneError,
      staffNameError: _staffNameError,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      onSendPdfChanged: (v) => setState(() => sendPdfToWhatsApp = v),
      selectedPaymentMethod: _selectedPaymentMethod,
      onPaymentMethodChanged: (m) => setState(() => _selectedPaymentMethod = m),
      decreaseStockForPastDate: decreaseStockForPastDate,
      onDecreaseStockChanged: (v) =>
          setState(() => decreaseStockForPastDate = v),
      isPastDate: isPastDate(),
      summarySection: _buildSummarySection(),
    );
  }

  Widget _buildSummarySection() {
    return BookingSummarySection(
      form: _form,
      isSales: selectedBookingType == BookingType.sales,
      calculateRentalDays: calculateRentalDays,
      onShowCustomization: () => setState(() => showCustomization = true),
      onConfirm: _handleConfirmBooking,
      confirmLabel: selectedBookingType == BookingType.sales
          ? 'Confirm Sales'
          : 'Confirm Booking',
    );
  }

  // ── Logic & Event Handlers ─────────────────────────────────────────────────

  void _validateAndContinue() {
    if (_form.clientNameController.text.trim().isEmpty) {
      setState(() => _clientNameError = 'Please enter client name');
      return;
    }
    if (_form.selectedProductsNotifier.value.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }
    setState(() {
      _bookingStep = 1;
      _clientNameError = null;
    });
  }

  void _handleUpdateProductMeasurements(
    ProductSelectedEntity product,
    List<MeasurementValueEntity> measurements,
  ) {
    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = product.copyWith(measurements: measurements);
      _form.selectedProductsNotifier.value = products;
    }
  }

  void _handleConfirmBooking() async {
    if (!_formKey.currentState!.validate()) return;

    final products = _form.selectedProductsNotifier.value;
    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    GlobalLoadingOverlay.show(context);
    try {
      int id = 0;
      if (selectedBookingType == BookingType.sales) {
        id = await getIt<CreateSaleBookingUseCase>()(
          _buildSalesRequest().toJson(),
        );
      } else {
        id = await getIt<AddBookingUseCase>()(_buildBookingRequest());
      }

      GlobalLoadingOverlay.hide();
      if (mounted) {
        if (id != 0)
          _showSuccessDialog(id, selectedBookingType);
        else {
          context.showSnackBar('Success!');
          if (widget.onClose != null)
            widget.onClose!();
          else
            Navigator.of(context).pop();
        }
      }
    } catch (e) {
      GlobalLoadingOverlay.hide();
      context.showSnackBar('Error: $e', isError: true);
    }
  }

  BookingRequestEntity _buildBookingRequest() {
    return BookingRequestEntity(
      clientId: _form.selectedClientId,
      staffId: context.read<StaffSearchCubit>().state.selectedStaff?.id,
      client: _form.selectedClientId == null
          ? ClientRequestEntity(
              id: null,
              name: _form.clientNameController.text.trim(),
              phone1: _form.clientPhone1Controller.text.trim().toIntOrNull(),
            )
          : null,
      address: _form.clientAddressController.text.trim(),
      pickupDate: pickupDate.format().appendTimeToDate(time: pickupTime),
      returnDate: returnDate
          .add(Duration(days: coolingPeriodDays))
          .format()
          .appendTimeToDate(time: returnTime),
      coolingPeriodDate: coolingPeriodDays == 0
          ? null
          : returnDate
                .add(Duration(days: coolingPeriodDays))
                .format()
                .appendTimeToDate(time: returnTime),
      advanceAmount: _form.advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: _form.securityAmountController.text.trim().toIntOrNull(),
      discountAmount: _form.discountAmountController.text.trim().toIntOrNull(),
      paymentMethod: _form.paymentMethod,
      deliveryStatus: _form.deliveryStatus,
      products: _form.selectedProductsNotifier.value,
      description: _form.descriptionController.text.trim(),
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
    );
  }

  RequestSalesModel _buildSalesRequest() {
    final products = _form.selectedProductsNotifier.value;
    final discount =
        _form.discountAmountController.text.trim().toIntOrNull() ?? 0;
    final variants = products
        .map(
          (p) => {
            'id': p.variant.variantId,
            'quantity': p.quantity,
            'amount': p.amount * p.quantity,
          },
        )
        .toList();
    final total =
        variants.fold<int>(0, (sum, item) => sum + (item['amount'] as int)) -
        discount;

    return RequestSalesModel(
      staffId: context.read<StaffSearchCubit>().state.selectedStaff?.id,
      clientPhone: _form.clientPhone1Controller.text.trim(),
      saleDate: pickupDate.format(),
      description: _form.descriptionController.text.trim(),
      sendInvoice: sendPdfToWhatsApp,
      variants: variants,
      paidAmount: total > 0 ? total : 0,
      paymentMethod: _form.paymentMethod,
      discount: discount,
      decreaseStock: decreaseStockForPastDate || !isPastDate(),
    );
  }

  void _showSuccessDialog(int id, BookingType type) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Successful!'),
        content: Text(
          '${type == BookingType.sales ? "Sale" : "Booking"} created successfully.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void showSearchOverlay() {
    BookingSearchOverlayHelper.showSearchOverlay(
      form: _form,
      context: context,
      isSales: selectedBookingType == BookingType.sales,
      scrollController: _searchResultsScrollController,
      onAddProduct: (product, variant) => addProductFromSearchWithVariant(
        product: product,
        variant: variant,
        isSales: selectedBookingType == BookingType.sales,
      ),
    );
  }

  void handleTabSwitch(BookingType type) {
    if (selectedBookingType == type) return;
    _form.removeSearchOverlay();
    setState(() => selectedBookingType = type);
    loadProductsForService(type, _form.selectedServiceId);
  }

  bool isPastDate() => pickupDate.dateOnly.isBefore(DateTime.now().dateOnly);

  BookingTabType _convertBookingTypeToTabType(BookingType type) =>
      BookingTabType.values[type.index];
  BookingType _convertTabTypeToBookingType(BookingTabType type) =>
      BookingType.values[type.index];

  Future<void> selectDate({required bool isPickup}) async {
    final isSales = selectedBookingType == BookingType.sales;
    final isOldBooking = selectedBookingType == BookingType.oldBooking;
    final today = DateTime.now().dateOnly;
    final oldBookingMinDate = DateTime(2015);

    if (isPickup) {
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
          pickupDate = picked;

          if (isSales) {
            decreaseStockForPastDate = false;
          }

          // Ripple: if pickup > return, push return forward
          if (picked.dateOnly.isAfter(returnDate.dateOnly)) {
            returnDate = isOldBooking
                ? picked
                : picked.add(const Duration(days: 1));
            if (coolingPeriodDate != null)
              recalculateCoolingPeriodDate(
                pickupDate: pickupDate,
                returnDate: returnDate,
                coolingPeriodDays: coolingPeriodDays,
              );
          }
        });
        loadProductsForService(selectedBookingType, selectedServiceId);
      }
    } else {
      // Return date picker
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
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFF6132E4),
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() => returnDate = picked);
          loadProductsForService(selectedBookingType, selectedServiceId);
        }
        return;
      }

      // Regular booking: return must be today or future
      final minReturnDate = pickupDate.dateOnly.isAfter(today)
          ? pickupDate.dateOnly
          : today;

      final picked = await showDatePicker(
        context: context,
        initialDate: minReturnDate.isAfter(returnDate.dateOnly)
            ? minReturnDate
            : returnDate,
        firstDate: minReturnDate,
        lastDate: DateTime.now().add(const Duration(days: 365)),
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
          returnDate = picked;
          if (coolingPeriodDate != null)
            recalculateCoolingPeriodDate(
              pickupDate: pickupDate,
              returnDate: returnDate,
              coolingPeriodDays: coolingPeriodDays,
            );
        });
        loadProductsForService(selectedBookingType, selectedServiceId);
      }
    }
  }

  Future<void> selectTime({required bool isPickup}) async {
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
      if (isPickup) {
        if (pickupDate.isDateToday && isTimeInPast(picked)) {
          showTimeError('Pickup time cannot be in the past');
          return;
        }
        setState(() {
          pickupTime = picked;
        });
        // If same-day booking, clear an invalid return time
        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            returnTime != null) {
          if (!isReturnTimeAfterPickupTime(picked, returnTime!)) {
            setState(() => returnTime = null);
            showTimeError(
              'Return time has been cleared as it was before the new pickup time',
            );
          }
        }
        loadProductsForService(selectedBookingType, selectedServiceId);
      } else {
        if (returnDate.isDateToday && isTimeInPast(picked)) {
          showTimeError('Return time cannot be in the past');
          return;
        }
        if (pickupDate.dateOnly.isAtSameMomentAs(returnDate.dateOnly) &&
            pickupTime != null) {
          if (!isReturnTimeAfterPickupTime(pickupTime!, picked)) {
            showTimeError('Return time must be after pickup time');
            return;
          }
        }
        setState(() => returnTime = picked);
        loadProductsForService(selectedBookingType, selectedServiceId);
      }
    }
  }

  // ── Old Booking Content ────────────────────────────────────────────────────
  Widget _buildOldBookingContent() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              BookingDateSelectionWidget(
                isSales: false,
                pickupDate: pickupDate,
                returnDate: returnDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodDays: coolingPeriodDays,
                onSelectPickupDate: () => selectDate(isPickup: true),
                onSelectReturnDate: () => selectDate(isPickup: false),
                onSelectPickupTime: () => selectTime(isPickup: true),
                onSelectReturnTime: () => selectTime(isPickup: false),
                onCoolingPeriodChanged: (v) =>
                    setState(() => coolingPeriodDays = v),
              ),
              const SizedBox(height: 16),
              Expanded(child: buildServiceSelectionSection()),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 340,
          child: OldBookingRightPanel(
            form: _form,
            bookedDate: _bookedDate,
            onBookedDateChanged: (d) => setState(() => _bookedDate = d),
            clientNameError: _clientNameError,
            staffNameError: _staffNameError,
            selectedPaymentMethod: _selectedPaymentMethod,
            onPaymentMethodChanged: (m) =>
                setState(() => _selectedPaymentMethod = m),
            onConfirm: () {}, // Implement old booking confirm if needed
          ),
        ),
      ],
    );
  }
}
