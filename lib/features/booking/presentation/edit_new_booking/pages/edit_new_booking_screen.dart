import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_new_booking/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_partial_usecase.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_search_product_field_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_search_overlay_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_product_list_header_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_selection_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_selected_products_list_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_summary_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_client_details_panel.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_payment_summary_panel.dart';

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
  final _form = BookingFormControllers();
  @override
  BookingFormControllers get form => _form;

  BookingType selectedBookingType = BookingType.booking;
  final _formKey = GlobalKey<FormState>();

  // Date / time getters/setters (bridged to form)
  DateTime get pickupDate => _form.pickupDate;
  set pickupDate(DateTime v) => _form.pickupDate = v;
  DateTime get returnDate => _form.returnDate;
  set returnDate(DateTime v) => _form.returnDate = v;
  TimeOfDay? get pickupTime => _form.pickupTime;
  set pickupTime(TimeOfDay? v) => _form.pickupTime = v;
  TimeOfDay? get returnTime => _form.returnTime;
  set returnTime(TimeOfDay? v) => _form.returnTime = v;

  BookingStatus? bookingStatus;
  String? bookingCompletedDate;
  bool sendPdfToWhatsApp = true;
  int? selectedServiceId = -1;
  int coolingPeriodDays = 0;
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;
  bool showCustomization = false;

  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final _searchResultsScrollController = ScrollController();

  // Original values for change tracking
  DateTime? _originalPickupDate;
  DateTime? _originalReturnDate;
  TimeOfDay? _originalPickupTime;
  TimeOfDay? _originalReturnTime;
  String? _originalClientName;
  int? _originalStaffId;
  List<DocumentFileEntity>? _originalDocuments;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    if (widget.bookingDetails != null) {
      _initializeFromBooking(widget.bookingDetails!);
    } else if (widget.saleDetails != null) {
      _initializeFromSale(widget.saleDetails!);
    }

    _searchResultsScrollController.addListener(
      () => handleSearchOverlayScroll(_searchResultsScrollController),
    );
    setupSelectProductBlocListener();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());

      final bStaffId = widget.bookingDetails?.staffId;
      final bStaffName = widget.bookingDetails?.staffName;
      final sStaffId = widget.saleDetails?.staffId;
      final sStaffName = widget.saleDetails?.staffName;

      if (bStaffId != null) {
        context.read<StaffSearchCubit>().getAllStaffs(
          bStaffId,
          StaffEntity(
            id: bStaffId,
            name: bStaffName ?? 'Staff',
            phoneNumber: '',
          ),
        );
      } else if (sStaffId != null) {
        context.read<StaffSearchCubit>().getAllStaffs(
          sStaffId,
          StaffEntity(
            id: sStaffId,
            name: sStaffName ?? 'Staff',
            phoneNumber: '',
          ),
        );
      } else {
        context.read<StaffSearchCubit>().getAllStaffs();
      }

      _loadAvailableProducts();
    });
  }

  @override
  void dispose() {
    _searchResultsScrollController.removeListener(
      () => handleSearchOverlayScroll(_searchResultsScrollController),
    );
    disposeSelectProductBlocListener();
    _searchResultsScrollController.dispose();
    _form.dispose();
    super.dispose();
  }

  void _initializeFromBooking(BookingDetailsEntity booking) {
    selectedBookingType = BookingType.booking;
    if (booking.pickupDate != null) {
      pickupDate = booking.pickupDate!.parseToDateTime();
      pickupTime = TimeOfDay.fromDateTime(pickupDate);
    }
    returnDate = booking.returnDate.parseToDateTime();
    returnTime = TimeOfDay.fromDateTime(returnDate);

    if (booking.coolingPeriodDate != null) {
      final coolingDate = booking.coolingPeriodDate!.parseToDateTime();
      coolingPeriodDays = coolingDate.difference(returnDate).inDays.abs();
    }

    _form.clientNameController.text = booking.client.name;
    _form.clientPhone1Controller.text = booking.client.phone1.toString();
    _form.clientPhone2Controller.text = booking.client.phone2?.toString() ?? '';
    _form.clientAddressController.text = booking.address ?? '';
    _form.selectedClientId = booking.client.id;
    _form.staffNameController.text = booking.staffName ?? '';
    _form.selectedStaffId = booking.staffId;
    _form.advanceAmountController.text = booking.paidAmount.toString();
    _form.securityAmountController.text =
        booking.securityAmount?.toString() ?? '';
    _form.discountAmountController.text =
        booking.discountAmount?.toString() ?? '';
    _form.deliveryStatus = booking.deliveryStatus;
    bookingStatus = booking.bookingStatus;
    bookingCompletedDate = booking.bookingCompletedDate;
    _form.descriptionController.text = booking.description ?? '';
    _form.startLocationController.text =
        booking.otherDetails.locationStart ?? '';
    _form.pickupLocationController.text =
        booking.otherDetails.locationFrom ?? '';
    _form.destinationLocationController.text =
        booking.otherDetails.locationTo ?? '';
    _form.runningKilometersController.text = booking.otherDetails.end ?? '';

    final products = booking.bookedItems
        .map(
          (item) => ProductSelectedEntity(
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
            ),
            measurements: item.measurements,
            quantity: item.quantity,
            amount: item.amount,
          ),
        )
        .toList();
    _form.selectedProductsNotifier.value = products;
    _form.additionalChargesNotifier.value = booking.additionalCharges;

    if (booking.documents.isNotEmpty) {
      _form.documentsNotifier.value = booking.documents.map((doc) {
        final url = doc is Map
            ? (doc['url'] ?? doc['file'] ?? '')
            : (doc is String ? doc : '');
        return DocumentFileEntity(name: url.split('/').last, path: url);
      }).toList();
    }
    _storeOriginalValues(booking);
  }

  void _initializeFromSale(SaleDetailsEntity sale) {
    selectedBookingType = BookingType.sales;
    pickupDate = sale.saleDate.parseToDateTime();
    _form.clientPhone1Controller.text = sale.clientPhone.toString();
    _form.clientAddressController.text = sale.address;
    _form.staffNameController.text = sale.staffName ?? '';
    _form.advanceAmountController.text = sale.paidAmount.toString();
    _form.discountAmountController.text = sale.discountAmount.toString();
    _form.paymentMethod = sale.paymentMethod;
    _form.descriptionController.text = sale.description;

    _form.selectedProductsNotifier.value = sale.products
        .map(
          (item) => ProductSelectedEntity(
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
              quantity: item.quantity,
            ),
            quantity: item.quantity,
            amount: item.price,
          ),
        )
        .toList();
  }

  void _storeOriginalValues(BookingDetailsEntity booking) {
    _originalPickupDate = booking.pickupDate?.parseToDateTime();
    _originalReturnDate = booking.returnDate.parseToDateTime();
    _originalPickupTime = booking.pickupDate != null
        ? TimeOfDay.fromDateTime(booking.pickupDate!.parseToDateTime())
        : null;
    _originalReturnTime = TimeOfDay.fromDateTime(
      booking.returnDate.parseToDateTime(),
    );
    _originalClientName = booking.client.name;
    _originalStaffId = booking.staffId;
    _originalDocuments = List.from(_form.documentsNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await handleBackNavigation();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              EditBookingAppBar(
                onSave: _handleSaveBooking,
                bookingId:
                    widget.bookingId ??
                    widget.bookingDetails?.id ??
                    widget.saleDetails?.id ??
                    0,
                bookingType: selectedBookingType.name,
                onBack: handleBackNavigation,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: buildBookingContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBookingContent() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            children: [
              BookingDateSelectionWidget(
                isSales: selectedBookingType == BookingType.sales,
                pickupDate: pickupDate,
                returnDate: returnDate,
                pickupTime: pickupTime,
                returnTime: returnTime,
                coolingPeriodDays: coolingPeriodDays,
                onSelectPickupDate: () => _selectDate(isPickup: true),
                onSelectReturnDate: () => _selectDate(isPickup: false),
                onSelectPickupTime: () => _selectTime(isPickup: true),
                onSelectReturnTime: () => _selectTime(isPickup: false),
                onCoolingPeriodChanged: (val) {
                  setState(() => coolingPeriodDays = val);
                  _loadAvailableProducts();
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
                          onSaveForProduct: (p, m) =>
                              _updateProductWithMeasurements(p, m),
                          selectedProducts:
                              _form.selectedProductsNotifier.value,
                        )
                      : buildServiceSelectionSection(),
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
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          BookingSearchProductFieldWidget(
            form: _form,
            onSearchChanged: () => onSearchChanged(selectedBookingType),
            showProductFilterDialog: _showProductFilterBottomSheet,
          ),
          const SizedBox(height: 8),
          BookingProductListHeaderWidget(
            isSales: selectedBookingType == BookingType.sales,
            hasVariants: hasAnyProductWithVariants(),
          ),
          Expanded(
            child: BookingSelectedProductsListWidget(
              form: _form,
              selectedBookingType: selectedBookingType,
              calculateRentalDays: calculateRentalDays,
              shouldMultiplyByDays: shouldMultiplyByDays,
              hasAnyProductWithVariants: hasAnyProductWithVariants,
              onDecrement: decrementQuantity,
              onIncrement: incrementQuantity,
              onStartEditingPrice: startEditingPrice,
              onSaveEditingPrice: saveEditingPrice,
              onRemove: removeProduct,
            ),
          ),
        ],
      ),
    );
  }

  void _updateProductWithMeasurements(
    ProductSelectedEntity product,
    List<MeasurementValueEntity> measurements,
  ) {
    final products = List<ProductSelectedEntity>.from(
      _form.selectedProductsNotifier.value,
    );
    final idx = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (idx != -1) {
      products[idx] = product.copyWith(measurements: measurements);
      _form.selectedProductsNotifier.value = products;
    }
  }

  void _loadAvailableProducts() {
    final isSales = selectedBookingType == BookingType.sales;
    final currentVariantIds = _form.selectedProductsNotifier.value
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    _form.selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: (selectedServiceId == -1) ? null : selectedServiceId,
        pickupDate: pickupDate.format(),
        returnDate: returnDate.format(),
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: !isSales,
        isSales: isSales,
        bookingId: widget.bookingId,
        variantIds: currentVariantIds.isNotEmpty ? currentVariantIds : null,
      ),
    );
  }

  Future<void> _selectDate({required bool isPickup}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? pickupDate : returnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          pickupDate = picked;
          if (returnDate.isBefore(picked))
            returnDate = picked.add(const Duration(days: 1));
        } else
          returnDate = picked;
      });
      _loadAvailableProducts();
    }
  }

  Future<void> _selectTime({required bool isPickup}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isPickup
          ? (pickupTime ?? TimeOfDay.now())
          : (returnTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isPickup)
          pickupTime = picked;
        else
          returnTime = picked;
      });
      _loadAvailableProducts();
    }
  }

  void _showProductFilterBottomSheet() {
    showDialog(
      context: context,
      builder: (_) => ProductFilterDialog(
        services: [],
        searchTypes: _searchTypes,
        initialServiceId: selectedServiceId,
        initialSearchTypeIndex: _form.selectedSearchTypeIndex.value,
        initialPriceRange: const RangeValues(0, 100000),
        initialMaxPrice: 100000,
        initialIsPriceFilterEnabled: false,
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
              });
              applyProductFilters(
                selectedBookingType,
                searchTypeIndex,
                priceRange,
                isPriceFilterEnabled,
              );
            },
      ),
    );
  }

  Widget _buildRightSidePanel() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _bookingStep == 0
          ? BookingClientDetailsPanel(
              form: _form,
              isSales: selectedBookingType == BookingType.sales,
              sendPdfToWhatsApp: sendPdfToWhatsApp,
              onSendPdfChanged: (v) => setState(() => sendPdfToWhatsApp = v),
              calculateRentalDays: calculateRentalDays,
              onContinue: _validateAndContinue,
              clientNameError: _clientNameError,
              phoneError: _phoneError,
              staffNameError: _staffNameError,
            )
          : BookingPaymentSummaryPanel(
              form: _form,
              onBack: () => setState(() => _bookingStep = 0),
              summarySection: _buildSummarySection(),
            ),
    );
  }

  Widget _buildSummarySection() {
    return BookingSummarySection(
      form: _form,
      isSales: selectedBookingType == BookingType.sales,
      calculateRentalDays: calculateRentalDays,
      bookingStatus: bookingStatus,
      bookingCompletedDate: bookingCompletedDate,
      onShowCustomization: () => setState(() => showCustomization = true),
      onConfirm: _handleSaveBooking,
      confirmLabel: 'Save Changes',
    );
  }

  void _validateAndContinue() {
    final staff = context.read<StaffSearchCubit>().state.selectedStaff;
    final res = BookingValidationHelper.validateClientDetailsPanel(
      clientName: _form.clientNameController.text,
      phone1: _form.clientPhone1Controller.text,
      phone2: _form.clientPhone2Controller.text,
      address: _form.clientAddressController.text,
      documentsCount: _form.documentsNotifier.value.length,
      selectedStaffId: staff?.id,
      staffName: _form.staffNameController.text,
    );
    if (res.isValid)
      setState(() => _bookingStep = 1);
    else {
      setState(() {
        _clientNameError = res.fieldErrors['clientName'];
        _phoneError = res.fieldErrors['phone1'];
        _staffNameError = res.fieldErrors['staff'];
      });
      BookingValidationHelper.showValidationErrors(context, res);
    }
  }

  Future<void> _handleSaveBooking() async {
    if (!_formKey.currentState!.validate()) return;
    if (_form.selectedProductsNotifier.value.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    GlobalLoadingOverlay.show(context);
    try {
      if (widget.bookingDetails != null) {
        final updates = _buildPartialUpdateRequest();
        final currentDocs = _form.documentsNotifier.value;
        final originalDocPaths =
            _originalDocuments?.map((d) => d.path).toSet() ?? {};
        final removedUrls = originalDocPaths
            .difference(currentDocs.map((d) => d.path).toSet())
            .toList();
        final newDocs = currentDocs.where((d) => d.bytes != null).toList();

        await getIt<UpdateBookingPartialUseCase>()(
          widget.bookingDetails!.id,
          updates,
          newDocuments: newDocs.isNotEmpty ? newDocs : null,
          removedDocumentUrls: removedUrls.isNotEmpty ? removedUrls : null,
        );
      } else if (widget.saleDetails != null) {
        await getIt<ISalesRepository>().updateSale(_buildSalesRequest());
      }
      GlobalLoadingOverlay.hide();
      if (mounted) {
        context.showSnackBar('Updated successfully!');
        if (widget.onClose != null)
          widget.onClose!();
        else
          Navigator.of(context).pop(true);
      }
    } catch (e) {
      GlobalLoadingOverlay.hide();
      context.showSnackBar('Failed to save: $e', isError: true);
    }
  }

  Map<String, dynamic> _buildPartialUpdateRequest() {
    final updates = <String, dynamic>{};
    final currentP = pickupDate.format().appendTimeToDate(time: pickupTime);
    final currentR = returnDate.format().appendTimeToDate(time: returnTime);
    final origP = _originalPickupDate?.format().appendTimeToDate(
      time: _originalPickupTime,
    );
    final origR = _originalReturnDate?.format().appendTimeToDate(
      time: _originalReturnTime,
    );

    if (currentP != origP || currentR != origR) {
      updates['pickup_date'] = currentP;
      updates['return_date'] = currentR;
      updates['cooling_period_date'] = coolingPeriodDays == 0
          ? currentR
          : returnDate
                .add(Duration(days: coolingPeriodDays))
                .format()
                .appendTimeToDate(time: returnTime);
    }

    if (_form.clientNameController.text.trim() != (_originalClientName ?? '')) {
      updates['client'] = {
        'id': _form.selectedClientId,
        'name': _form.clientNameController.text.trim(),
        'phone1': _form.clientPhone1Controller.text.trim().toIntOrNull(),
      };
      updates['address'] = _form.clientAddressController.text.trim();
    }

    final staffId = context.read<StaffSearchCubit>().state.selectedStaff?.id;
    if (staffId != _originalStaffId) updates['staff_id'] = staffId;

    updates['advance_amount'] = _form.advanceAmountController.text
        .trim()
        .toIntOrNull();
    updates['security_amount'] = _form.securityAmountController.text
        .trim()
        .toIntOrNull();
    updates['discount_amount'] = _form.discountAmountController.text
        .trim()
        .toIntOrNull();
    updates['variants'] = _form.selectedProductsNotifier.value
        .map(
          (p) => {
            'id': p.variant.variantId ?? p.variant.id,
            'quantity': p.quantity,
            'amount': p.amount * p.quantity,
            'measurements': p.measurements,
          },
        )
        .toList();
    updates['delivery_status'] = _form.deliveryStatus.toValue();
    updates['description'] = _form.descriptionController.text.trim();

    return updates;
  }

  SalesRequestEntity _buildSalesRequest() {
    return SalesRequestEntity(
      id: widget.saleDetails?.id,
      staffId: _form.selectedStaffId,
      clientPhone: _form.clientPhone1Controller.text.trim(),
      address: _form.clientAddressController.text.trim(),
      saleDate: pickupDate.format(),
      description: _form.descriptionController.text.trim(),
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      products: _form.selectedProductsNotifier.value,
      paidAmount: _form.advanceAmountController.text.trim().toIntOrNull() ?? 0,
      paymentMethod: _form.paymentMethod,
      discountAmount:
          _form.discountAmountController.text.trim().toIntOrNull() ?? 0,
    );
  }

  @override
  void showSearchOverlay() {
    BookingSearchOverlayHelper.showSearchOverlay(
      form: _form,
      context: context,
      isSales: selectedBookingType == BookingType.sales,
      onAddProduct: (p, v) => addProductFromSearchWithVariant(
        product: p,
        variant: v,
        isSales: selectedBookingType == BookingType.sales,
      ),
    );
  }
}
