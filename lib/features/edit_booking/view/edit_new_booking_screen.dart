import 'dart:developer';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/app_routes.dart';
import 'package:bookie_buddy_web/core/ui/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
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
import 'package:bookie_buddy_web/features/add_booking/models/request_sales_model/request_sales_model.dart';
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
import 'package:bookie_buddy_web/features/edit_booking/view/widgets/edit_booking_app_bar.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/generate_booking_pdf.dart';
import 'package:bookie_buddy_web/features/sale_details/view/widgets/generate_sale_details_pdf.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/core/ui/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';

/// Booking types enum for the tab selection
enum EditBookingType { booking, sales, customWork }

class EditNewBookingScreen extends StatefulWidget {
  final BookingDetailsModel? bookingDetails;
  final SaleDetailsModel? saleDetails;
  final VoidCallback? onClose;

  const EditNewBookingScreen({
    super.key,
    this.bookingDetails,
    this.saleDetails,
    this.onClose,
  }) : assert(
          (bookingDetails != null && saleDetails == null) ||
              (bookingDetails == null && saleDetails != null),
          'Either bookingDetails or saleDetails must be provided, but not both',
        );

  @override
  State<EditNewBookingScreen> createState() => EditNewBookingScreenState();
}

class EditNewBookingScreenState extends State<EditNewBookingScreen> {
  // Current selected tab
  late EditBookingType selectedBookingType;

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
  late PaymentMethod paymentMethod;
  late DeliveryStatus deliveryStatus;
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

  int? selectedServiceId = -1;
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

  // Customization state
  bool showCustomization = false;

  // Track if changes were made
  Map<String, dynamic>? _initialState;
  bool get hasUnsavedChanges => _checkForChanges();

  @override
  void initState() {
    super.initState();

    // Determine edit mode
    if (widget.bookingDetails != null) {
      selectedBookingType = EditBookingType.booking;
      _initializeFromBooking(widget.bookingDetails!);
    } else {
      selectedBookingType = EditBookingType.sales;
      _initializeFromSale(widget.saleDetails!);
    }

    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );

    // Save initial state for comparison
    _saveInitialState();

    // Load products for the selected service
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProductsForService(selectedServiceId);
    });
  }

  void _initializeFromBooking(BookingDetailsModel booking) {
    // Initialize dates
    pickupDate = booking.pickupDate?.parseToDateTime() ?? DateTime.now();
    returnDate = booking.returnDate.parseToDateTime();
    coolingPeriodDate = booking.coolingPeriodDate?.parseToDateTime();

    // Initialize times
    pickupTime = booking.pickupDate?.parseToDateTime().toTimeOfDay;
    returnTime = booking.returnDate.parseToDateTime().toTimeOfDay;
    coolingPeriodTime =
        booking.coolingPeriodDate?.parseToDateTime().toTimeOfDay;

    // Initialize client details
    clientNameController.text = booking.client.name;
    clientPhone1Controller.text = booking.client.phone1.toString();
    clientPhone2Controller.text = booking.client.phone2?.toString() ?? '';
    clientAddressController.text = booking.address ?? '';
    selectedClientId = booking.client.id;

    // Initialize staff
    staffNameController.text = booking.staffName ?? '';
    selectedStaffId = booking.staffId;

    // Initialize payment details
    advanceAmountController.text = booking.paidAmount.toString();
    securityAmountController.text = booking.securityAmount?.toString() ?? '0';
    discountAmountController.text = booking.discountAmount?.toString() ?? '0';
    // Get payment method from payments history if available
    final paymentMethodValue = booking.payments.isNotEmpty
        ? booking.payments.first.paymentMethod
        : PaymentMethod.cash;
    paymentMethod = paymentMethodValue;
    deliveryStatus = booking.deliveryStatus;

    // Initialize description
    descriptionController.text = booking.description ?? '';

    // Initialize locations from otherDetails
    startLocationController.text = booking.otherDetails.locationStart ?? '';
    pickupLocationController.text = booking.otherDetails.locationFrom ?? '';
    destinationLocationController.text = booking.otherDetails.locationTo ?? '';
    // Note: runningKilometers is not in the model, leaving empty
    runningKilometersController.text = '';

    // Initialize products
    selectedProductsNotifier.value = booking.bookedItems.map((item) {
      return ProductSelectedModel(
        variant: item,
        amount: item.amount,
        quantity: item.quantity,
        measurements: item.measurements,
      );
    }).toList();

    // Initialize additional charges
    additionalChargesNotifier.value = booking.additionalCharges;
  }

  void _initializeFromSale(SaleDetailsModel sale) {
    // Initialize date
    returnDate = sale.saleDate.parseToDateTime();
    pickupDate = returnDate;

    // Initialize client details
    clientNameController.text = sale.client?.name ?? '';
    clientPhone1Controller.text = sale.clientPhone?.toString() ?? '';
    clientPhone2Controller.text = sale.client?.phone2?.toString() ?? '';
    clientAddressController.text = sale.address;
    selectedClientId = sale.client?.id;

    // Initialize staff
    staffNameController.text = sale.staffName ?? '';
    selectedStaffId = sale.staffId;

    // Initialize payment details
    advanceAmountController.text = sale.paidAmount.toString();
    discountAmountController.text = sale.discountAmount.toString();
    paymentMethod = sale.paymentMethod;
    deliveryStatus = DeliveryStatus.booked;

    // Initialize description
    descriptionController.text = sale.description ?? '';

    // Initialize products
    selectedProductsNotifier.value = sale.products.map((item) {
      // Create ProductInfoModel from ProductSaleInfoModel
      final variant = ProductInfoModel(
        id: item.variantId,
        productId: item.productId,
        variantId: item.variantId,
        name: item.name,
        image: item.image,
        mainServiceType: item.mainServiceType,
        variantAttribute: item.variantAttribute,
        color: item.color,
        category: item.category,
        model: item.model,
        quantity: item.quantity,
        amount: item.price,
      );

      return ProductSelectedModel(
        variant: variant,
        amount: item.price,
        quantity: item.quantity,
      );
    }).toList();
  }

  void _saveInitialState() {
    _initialState = {
      'clientName': clientNameController.text,
      'clientPhone1': clientPhone1Controller.text,
      'clientPhone2': clientPhone2Controller.text,
      'clientAddress': clientAddressController.text,
      'staffName': staffNameController.text,
      'advanceAmount': advanceAmountController.text,
      'securityAmount': securityAmountController.text,
      'discountAmount': discountAmountController.text,
      'description': descriptionController.text,
      'pickupDate': pickupDate,
      'returnDate': returnDate,
      'coolingPeriodDate': coolingPeriodDate,
      'paymentMethod': paymentMethod,
      'deliveryStatus': deliveryStatus,
      'selectedProducts': selectedProductsNotifier.value.length,
      'additionalCharges': additionalChargesNotifier.value.length,
      'documents': documentsNotifier.value.length,
    };
  }

  bool _checkForChanges() {
    if (_initialState == null) return false;

    return _initialState!['clientName'] != clientNameController.text ||
        _initialState!['clientPhone1'] != clientPhone1Controller.text ||
        _initialState!['clientPhone2'] != clientPhone2Controller.text ||
        _initialState!['clientAddress'] != clientAddressController.text ||
        _initialState!['staffName'] != staffNameController.text ||
        _initialState!['advanceAmount'] != advanceAmountController.text ||
        _initialState!['securityAmount'] != securityAmountController.text ||
        _initialState!['discountAmount'] != discountAmountController.text ||
        _initialState!['description'] != descriptionController.text ||
        _initialState!['pickupDate'] != pickupDate ||
        _initialState!['returnDate'] != returnDate ||
        _initialState!['coolingPeriodDate'] != coolingPeriodDate ||
        _initialState!['paymentMethod'] != paymentMethod ||
        _initialState!['deliveryStatus'] != deliveryStatus ||
        _initialState!['selectedProducts'] !=
            selectedProductsNotifier.value.length ||
        _initialState!['additionalCharges'] !=
            additionalChargesNotifier.value.length ||
        _initialState!['documents'] != documentsNotifier.value.length;
  }

  @override
  void dispose() {
    clientNameController.dispose();
    clientPhone1Controller.dispose();
    clientPhone2Controller.dispose();
    clientAddressController.dispose();
    staffNameController.dispose();
    advanceAmountController.dispose();
    securityAmountController.dispose();
    discountAmountController.dispose();
    descriptionController.dispose();
    serviceSearchController.dispose();
    runningKilometersController.dispose();
    startLocationController.dispose();
    pickupLocationController.dispose();
    destinationLocationController.dispose();
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    _selectProductBloc.close();
    super.dispose();
  }

  Future<void> _handleBackNavigation() async {
    if (hasUnsavedChanges) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard ?? false) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleTabSwitch(EditBookingType newType) {
    // Tab switching not allowed in edit mode
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cannot switch type while editing'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _loadProductsForService(int? serviceId) {
    final isSales = selectedBookingType == EditBookingType.sales;
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

  void _onSearchChanged() {
    final query = serviceSearchController.text.trim();
    final isSales = selectedBookingType == EditBookingType.sales;
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

  void _openProductSelection() async {
    final isSales = selectedBookingType == EditBookingType.sales;

    // If "All Services" is selected (-1), pass null to the screen to show all
    final serviceIdToUse = (selectedServiceId == -1) ? null : selectedServiceId;

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
            isSales: isSales,
            useAvailableProductsApi: !isSales,
          ),
        ),
      ),
    );

    if (result != null) {
      selectedProductsNotifier.value = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          await _handleBackNavigation();
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                // Edit booking app bar
                EditBookingAppBar(
                  bookingType: selectedBookingType == EditBookingType.booking
                      ? 'Booking'
                      : 'Sale',
                  bookingId:
                      widget.bookingDetails?.id ?? widget.saleDetails?.id ?? 0,
                  onBack: _handleBackNavigation,
                  onSave: _handleSave,
                ),
                // Main content
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: _buildMainContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    if (selectedBookingType == EditBookingType.customWork) {
      return Container(
        child: Center(
          child: Text('Custom Work - Coming Soon'),
        ),
      );
    }
    return _buildBookingContent();
  }

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
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: child.key == const ValueKey('customization')
                        ? const Offset(1.0, 0.0)
                        : const Offset(-1.0, 0.0),
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
                              selectedProductsNotifier.value = updatedProducts;
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

  Widget _buildDateSelectionSection() {
    // Use the same booking calendar widget from new booking
    return BookingCalendarWidget(
      pickupDate: pickupDate,
      returnDate: returnDate,
      coolingPeriodDate: coolingPeriodDate,
      pickupTime: pickupTime,
      returnTime: returnTime,
      coolingPeriodTime: coolingPeriodTime,
      isSalesMode: selectedBookingType == EditBookingType.sales,
      staffNameController: staffNameController,
      clientNameController: clientNameController,
      clientPhone1Controller: clientPhone1Controller,
      clientPhone2Controller: clientPhone2Controller,
      clientAddressController: clientAddressController,
      descriptionController: descriptionController,
      isSearchClientEnabled: isSearchClientEnabled,
      clientNameError: _clientNameError,
      staffNameError: _staffNameError,
      onSearchClientToggle: (value) {
        setState(() {
          isSearchClientEnabled = value;
        });
      },
      onStaffSelected: (staffId) {
        setState(() {
          selectedStaffId = staffId;
        });
      },
      onClientSelected: (clientId) {
        setState(() {
          selectedClientId = clientId;
        });
      },
      onPickupDateChanged: (date) {
        setState(() {
          pickupDate = date;
          if (returnDate.isBefore(date)) {
            returnDate = date.add(const Duration(days: 1));
          }
        });
      },
      onReturnDateChanged: (date) {
        setState(() {
          returnDate = date;
        });
      },
      onCoolingPeriodDateChanged: (date) {
        setState(() {
          coolingPeriodDate = date;
        });
      },
      onPickupTimeChanged: (time) {
        setState(() {
          pickupTime = time;
        });
      },
      onReturnTimeChanged: (time) {
        setState(() {
          returnTime = time;
        });
      },
      onCoolingPeriodTimeChanged: (time) {
        setState(() {
          coolingPeriodTime = time;
        });
      },
    );
  }

  Widget _buildServiceSelectionSection() {
    // This would contain the product selection UI
    // Similar to new booking screen
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Service selection and search header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Selected Products',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: _openProductSelection,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add Products'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6132E4),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Products list
          ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: selectedProductsNotifier,
            builder: (context, products, _) {
              if (products.isEmpty) {
                return Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 64,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No products selected',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return _buildProductCard(product);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductSelectedModel product) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Product image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.variant.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.variant.variantAttribute ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${product.amount}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6132E4),
                  ),
                ),
              ],
            ),
          ),
          // Remove button
          IconButton(
            onPressed: () {
              setState(() {
                selectedProductsNotifier.value =
                    List<ProductSelectedModel>.from(
                        selectedProductsNotifier.value)
                      ..removeWhere((p) =>
                          p.variant.variantId == product.variant.variantId);
              });
            },
            icon: const Icon(Icons.close, size: 20),
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  Widget _buildRightSidePanel() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          _buildClientSection(),
          const SizedBox(height: 20),
          _buildStaffSection(),
          const SizedBox(height: 20),
          _buildPaymentSection(),
          const SizedBox(height: 20),
          _buildDocumentSection(),
          const SizedBox(height: 20),
          _buildDescriptionSection(),
        ],
      ),
    );
  }

  Widget _buildClientSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Client Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        ClientSearchNameField(
          nameController: clientNameController,
          onClientSelected: (client) {
            setState(() {
              selectedClientId = client.id;
              clientNameController.text = client.name;
              clientPhone1Controller.text = client.phone1.toString();
              clientPhone2Controller.text = client.phone2?.toString() ?? '';
              // Note: ClientModel doesn't have address field
            });
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: clientPhone1Controller,
          decoration: const InputDecoration(
            labelText: 'Phone',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildStaffSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Staff Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        StaffSearchNameField(
          nameController: staffNameController,
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: advanceAmountController,
          decoration: const InputDecoration(
            labelText: 'Advance Amount',
            border: OutlineInputBorder(),
            isDense: true,
            prefixText: '₹ ',
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: discountAmountController,
          decoration: const InputDecoration(
            labelText: 'Discount',
            border: OutlineInputBorder(),
            isDense: true,
            prefixText: '₹ ',
          ),
          keyboardType: TextInputType.number,
        ),
        if (selectedBookingType == EditBookingType.booking) ...[
          const SizedBox(height: 8),
          TextFormField(
            controller: securityAmountController,
            decoration: const InputDecoration(
              labelText: 'Security Amount',
              border: OutlineInputBorder(),
              isDense: true,
              prefixText: '₹ ',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ],
    );
  }

  Widget _buildDocumentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Documents',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () {
                // Add document functionality
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add'),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6132E4),
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder<List<DocumentFile>>(
          valueListenable: documentsNotifier,
          builder: (context, documents, _) {
            if (documents.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Center(
                  child: Text(
                    'No documents uploaded',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              );
            }
            return Column(
              children:
                  documents.map((doc) => _buildDocumentCard(doc)).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildDocumentCard(DocumentFile document) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.description, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              document.name,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                documentsNotifier.value =
                    List<DocumentFile>.from(documentsNotifier.value)
                      ..remove(document);
              });
            },
            icon: const Icon(Icons.close, size: 16),
            color: Colors.grey.shade600,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: 'Add any additional notes...',
            border: OutlineInputBorder(),
            isDense: true,
          ),
          maxLines: 4,
        ),
      ],
    );
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Show loading
    GlobalLoadingOverlay.show(context);

    try {
      if (selectedBookingType == EditBookingType.booking) {
        await _updateBooking();
      } else {
        await _updateSale();
      }

      // Hide loading
      if (mounted) {
        GlobalLoadingOverlay.hide();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Updated successfully'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      // Hide loading
      if (mounted) {
        GlobalLoadingOverlay.hide();

        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _updateBooking() async {
    // TODO: Implement booking update logic
    // This would involve creating a request model and calling the repository
    log('Updating booking...');
  }

  Future<void> _updateSale() async {
    // TODO: Implement sale update logic
    log('Updating sale...');
  }
}
