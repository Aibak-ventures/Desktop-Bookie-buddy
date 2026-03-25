import 'dart:developer';
import 'dart:io';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/check_variant_availability_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/app_premium_features_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/client/presentation/widgets/client_search_name_field.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/search_overlay_result_widget.dart';
import 'package:flutter/services.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_old_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/send_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_request_entity/booking_request_entity.dart';
import 'package:bookie_buddy_web/features/sales/data/models/request_sales_model/request_sales_model.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/product_customization_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_validation_helper.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/widgets/new_booking_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Conditional import for web-specific code
import 'web_helper_stub.dart'
    if (dart.library.html) 'web_helper_web.dart'
    as web_helper;
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/select_date_failure_dialog.dart';
import 'package:bookie_buddy_web/utils/open_pdf_in_new_tab.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bookie_buddy_web/core/common/widgets/global_loading_overlay.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_mixin.dart';

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

  // ── Date / time ────────────────────────────────────────────────────────────
  late DateTime pickupDate;
  late DateTime returnDate;
  DateTime? coolingPeriodDate;
  TimeOfDay? coolingPeriodTime;
  TimeOfDay? pickupTime;
  TimeOfDay? returnTime;

  // ── Service / search filter ────────────────────────────────────────────────
  int? selectedServiceId = -1;
  List<String> _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  MainServiceType? _currentServiceType;

  // ── UI state ───────────────────────────────────────────────────────────────
  bool sendPdfToWhatsApp = false;
  bool decreaseStockForPastDate = false;

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
        // For non-multi-variant types (Vehicle, jewellery, etc.): use service-specific labels
        _searchTypes = ['Name', categoryLabel, secondaryLabel, 'Color'];
      }
    }
  }

  // Step state
  int coolingPeriodDays = 0;
  DateTime? _bookedDate;
  int _bookingStep = 0;
  String? _clientNameError;
  String? _staffNameError;
  String? _phoneError;

  // Scroll / quantity controllers (screen-only)
  final _searchResultsScrollController = ScrollController();
  final Map<int, TextEditingController> _quantityControllers = {};
  final Map<int, FocusNode> _quantityFocusNodes = {};

  // State variables for payment method
  PaymentMethod _selectedPaymentMethod = PaymentMethod.cash;

  // UI Constants
  static const double _fieldSpacing = 8.0;

  // Customization state
  bool showCustomization = false;

  // Summary expansion state
  bool _isSummaryExpanded = false;

  @override
  void initState() {
    super.initState();
    pickupDate = DateTime.now();
    returnDate = DateTime.now().add(const Duration(days: 1));

    // Add listener to client name controller to detect manual changes
    _form.clientNameController.addListener(_onClientNameChanged);
    _form.clientPhone1Controller.addListener(_onClientPhoneChanged);
    _form.clientPhone2Controller.addListener(_onClientPhoneChanged);
    _searchResultsScrollController.addListener(_handleSearchOverlayScroll);
    // Set up web beforeUnload listener to prevent accidental browser close
    if (kIsWeb) {
      web_helper.setupBeforeUnloadListener(() => hasUnsavedChanges());
    }

    // Load services and auto-select first one
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
      // Load staffs for staff search dropdown
      context.read<StaffSearchCubit>().getAllStaffs();

      // Initialize cooling period based on shop settings (TC-01-03)
      _initializeCoolingPeriod();
    });
  }

  @override
  void dispose() {
    // Remove web beforeUnload listener
    if (kIsWeb) {
      web_helper.removeBeforeUnloadListener();
    }

    _form.clientNameController.removeListener(_onClientNameChanged);
    _form.clientPhone1Controller.removeListener(_onClientPhoneChanged);
    _form.clientPhone2Controller.removeListener(_onClientPhoneChanged);
    _searchResultsScrollController.removeListener(_handleSearchOverlayScroll);
    _searchResultsScrollController.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _quantityFocusNodes.values) {
      focusNode.dispose();
    }
    _form.dispose();
    super.dispose();
  }

  void _handleSearchOverlayScroll() {
    if (!_searchResultsScrollController.hasClients) return;
    final position = _searchResultsScrollController.position;
    if (position.pixels < position.maxScrollExtent - 180) return;
    _form.selectProductBloc.state.maybeWhen(
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
              _form.selectProductBloc.add(
                const SelectProductEvent.loadNextSearchResults(),
              );
            } else {
              _form.selectProductBloc.add(
                const SelectProductEvent.loadNextPageProducts(),
              );
            }
          },
      orElse: () {},
    );
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
    if (_form.runningKilometersController.text.trim().isNotEmpty) return true;

    return false;
  }

  /// Handle back navigation with discard dialog if needed
  Future<void> _handleBackNavigation() async {
    // Close search overlay if open to prevent UI conflict
    _form.removeSearchOverlay();

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
    _form.removeSearchOverlay();

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
    _form.clientNameController.clear();
    _form.clientPhone1Controller.clear();
    _form.clientPhone2Controller.clear();
    _form.clientAddressController.clear();
    _form.staffNameController.clear();
    _form.selectedStaffId = null;
    _form.selectedClientId = null;
    _bookedDate = null;
    _form.advanceAmountController.clear();
    _form.securityAmountController.clear();
    _form.discountAmountController.clear();
    _form.descriptionController.clear();
    _form.selectedProductsNotifier.value = [];
    _form.additionalChargesNotifier.value = [];
    _form.documentsNotifier.value = [];
    _form.serviceSearchController.clear();
    context.read<StaffSearchCubit>().clearSelectedStaff();
    context.read<ClientCubit>().clearSelected();
  }

  /// Listener for client name changes to detect manual editing
  void _onClientNameChanged() {
    // Clear validation error when user types
    if (_clientNameError != null &&
        _form.clientNameController.text.trim().isNotEmpty) {
      setState(() {
        _clientNameError = null;
      });
    }

    // Get the current selected client from the cubit
    final selectedClient = context.read<ClientCubit>().state.selectedClient;

    // If a client is selected but the name has been manually changed
    if (selectedClient != null && _form.selectedClientId != null) {
      final currentName = _form.clientNameController.text.trim();
      final selectedClientName = selectedClient.name.trim();

      // If the names don't match, user has manually edited - treat as new client
      if (currentName != selectedClientName) {
        setState(() {
          _form.selectedClientId = null;
        });
        // Clear the selected client in the cubit
        context.read<ClientCubit>().clearSelected();
      }
    }
  }

  /// Listener for phone changes to detect manual editing
  void _onClientPhoneChanged() {
    // Clear validation error when user types
    if (_phoneError != null &&
        (_form.clientPhone1Controller.text.trim().isNotEmpty ||
            _form.clientPhone2Controller.text.trim().isNotEmpty)) {
      setState(() {
        _phoneError = null;
      });
    }

    // Get the current selected client from the cubit
    final selectedClient = context.read<ClientCubit>().state.selectedClient;

    // If a client is selected but phone has been manually changed
    if (selectedClient != null && _form.selectedClientId != null) {
      final currentPhone1 = _form.clientPhone1Controller.text.trim();
      final currentPhone2 = _form.clientPhone2Controller.text.trim();
      final selectedPhone1 = selectedClient.phone1.toString().trim();
      final selectedPhone2 = selectedClient.phone2?.toString().trim() ?? '';

      // If phones don't match, user has manually edited - treat as new client
      if (currentPhone1 != selectedPhone1 || currentPhone2 != selectedPhone2) {
        setState(() {
          _form.selectedClientId = null;
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

    // Validate at least one product has price > 0
    final selectedProducts = _form.selectedProductsNotifier.value;
    if (selectedProducts.isNotEmpty) {
      final hasProductWithPrice = selectedProducts.any((p) => p.amount > 0);
      if (!hasProductWithPrice) {
        context.showSnackBar(
          'At least one product must have a price greater than 0',
          isError: true,
        );
        return;
      }
    }

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
      isSalesMode: selectedBookingType == BookingType.sales,
    );

    if (validationResult.isValid) {
      // Close search overlay before changing steps to prevent UI conflict
      _form.removeSearchOverlay();
      // Move to next step
      setState(() => _bookingStep = 1);
    } else {
      // Show validation errors
      setState(() {
        _clientNameError = validationResult.fieldErrors['clientName'];
        _phoneError = validationResult.fieldErrors['phone1'];
        _staffNameError = validationResult.fieldErrors['staff'];
      });
      // Field errors are already shown via errorText parameters
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

    // Filter out material services for booking/sales (only show in stock listing)
    services = services
        .where((s) => !s.mainServiceName.toLowerCase().contains('material'))
        .toList();

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
        computeSearchTypes: (serviceId) {
          _updateSearchTypesForService(serviceId == -1 ? null : serviceId);
          return _searchTypes;
        },
        onApply: ({
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
            _updateSearchTypesForService(selectedServiceId);
          });
          _applyProductFilters(searchTypeIndex, priceRange, isPriceFilterEnabled);
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
    final searchTerm = _form.serviceSearchController.text.trim().toLowerCase();
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
      _form.selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: hasSearchQuery ? searchTerm : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: isPriceEnabled ? priceRange.start.round() : null,
          endPrice: isPriceEnabled ? priceRange.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
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
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }

  void _onSearchChanged([String? newValue]) {
    // Allow search even if selectedServiceId is null (All Services)
    final query = (newValue ?? _form.serviceSearchController.text)
        .trim()
        .toLowerCase();
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected, serviceId will be -1, so we pass null to API
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final hasSearchQuery = query.isNotEmpty;
    final hasPriceFilter = _form.isPriceFilterEnabled.value;
    final hasAnyFilter = hasSearchQuery || hasPriceFilter;

    // Debug log to trace search behavior
    log(
      '_onSearchChanged -> query: "$query", hasSearchQuery: $hasSearchQuery, hasPriceFilter: $hasPriceFilter, searchTypeIndex: ${_form.selectedSearchTypeIndex.value}, hasAnyFilter: $hasAnyFilter',
    );

    if (!hasAnyFilter) {
      _form.selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
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
      _form.selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: hasSearchQuery ? query : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: hasPriceFilter ? _form.priceRange.value.start.round() : null,
          endPrice: hasPriceFilter ? _form.priceRange.value.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: returnDate.format(),
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
    final isSales = selectedBookingType == BookingType.sales;
    // If "All Services" is selected (-1), pass null to API
    final serviceIdToUse = (serviceId == null || serviceId == -1)
        ? null
        : serviceId;

    // For booking mode only, add cooling period; sales and old booking use actual return date
    final effectiveReturnDate = selectedBookingType == BookingType.booking
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    _form.selectProductBloc.add(
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

    // After reloading products, check if selected products are still available
    _checkSelectedProductsAvailability();
  }

  /// Perform a quick local filter on the currently loaded products
  /// and show results immediately in the overlay. This avoids waiting
  /// for server responses for single-character queries.
  void _showLocalFilteredResults(String rawQuery) {
    final q = rawQuery.toLowerCase();

    // Get products from current bloc state if available
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

    _form.overlayIsLoading.value = false;
    _form.overlayProducts.value = filtered;
    if (_form.searchOverlayEntry == null) {
      _showSearchOverlay();
    }
  }

  /// Check if already-selected products are still available for the current
  /// date range. If any are unavailable, show the [showUnavailableProductsDialog].
  Future<void> _checkSelectedProductsAvailability() async {
    final isSales = selectedBookingType == BookingType.sales;
    // Only check availability for bookings, not sales
    if (isSales) return;

    final selected = _form.selectedProductsNotifier.value;
    if (selected.isEmpty) return;

    final variantIds = selected
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    if (variantIds.isEmpty) return;

    final effectiveReturnDate = returnDate
        .add(Duration(days: coolingPeriodDays))
        .format();

    try {
      final notFoundIds = await getIt<CheckVariantAvailabilityUseCase>()(
        pickupDate: pickupDate.format(),
        returnDate: effectiveReturnDate,
        variantIds: variantIds,
        pickupTime: pickupTime,
        returnTime: returnTime,
      );

      if (notFoundIds.isNotEmpty && mounted) {
        await showUnavailableProductsDialog(
          context: context,
          unavailableDateFrom: pickupDate.format(),
          unavailableDateTo: effectiveReturnDate,
          unavailableProducts: notFoundIds,
          selectedProductsNotifier: _form.selectedProductsNotifier,
        );
      }
    } catch (e) {
      log('Error checking selected product availability: $e');
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

    if (isPickup) {
      // PICKUP DATE PICKER (or SALE DATE for sales mode)
      // For sales: only today or past dates (up to 1 year)
      // For bookings: can be past (up to 1 year) or future (up to 1 year)
      final picked = await showDatePicker(
        context: context,
        initialDate: pickupDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: isSales
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
            returnDate = picked.add(const Duration(days: 1));

            // Also update cooling period if it exists
            if (coolingPeriodDate != null) {
              _updateCoolingPeriod();
            }
          }

          // If cooling period exists and mode is "before", recalculate
          // (For now, assuming "after" mode - can add mode toggle later)
        });

        // Reload products with new date
        _loadProductsForService(selectedServiceId);
      }
    } else {
      // RETURN DATE PICKER
      // CRITICAL: Must be today or future, never in the past
      final today = DateTime.now().dateOnly;
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

          // RIPPLE EFFECT: Update cooling period if mode is "after"
          if (coolingPeriodDate != null) {
            _updateCoolingPeriod();
          }
        });

        // Reload products with new date
        _loadProductsForService(selectedServiceId);
      }
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

    if (coolingDuration > 0) {
      setState(() {
        // Set the cooling period days from user profile
        coolingPeriodDays = coolingDuration;

        if (coolingMode.isAfter) {
          // TC-02: After mode - cooling starts after return
          coolingPeriodDate = returnDate.add(Duration(days: coolingDuration));
        } else {
          // TC-03: Before mode - cooling ends before pickup
          coolingPeriodDate = pickupDate.subtract(
            Duration(days: coolingDuration),
          );
        }
      });
    }
  }

  /// Helper: Update cooling period based on pickup/return date changes
  /// Supports both "before" and "after" modes
  void _updateCoolingPeriod() {
    final userCubit = context.read<UserCubit>();
    final coolingDuration =
        userCubit.state?.shopSettings.coolingPeriodDuration ?? 0;
    final coolingMode =
        userCubit.state?.shopSettings.coolingPeriodMode ??
        CoolingPeriodMode.after;

    if (coolingDuration > 0) {
      setState(() {
        if (coolingMode.isAfter) {
          // TC-10: After mode (Maintenance) - cooling starts after return
          // Formula: Cooling Date = Return Date + Duration
          coolingPeriodDate = returnDate.add(Duration(days: coolingDuration));
        } else {
          // TC-15: Before mode (Preparation) - cooling ends before pickup
          // Formula: Cooling Date = Pickup Date - Duration
          coolingPeriodDate = pickupDate.subtract(
            Duration(days: coolingDuration),
          );
        }
      });
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              //TODO: could't find the _openProductSelection method when copying code, need attention.

              // InkWell(
              //   onTap: _openProductSelection,
              //   borderRadius: BorderRadius.circular(8),
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF6132E4).withOpacity(0.08),
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(
              //         color: const Color(0xFF6132E4).withOpacity(0.18),
              //       ),
              //     ),
              //     child: Row(
              //       children: const [
              //         Icon(
              //           Icons.add,
              //           size: 16,
              //           color: Color(0xFF6132E4),
              //         ),
              //         SizedBox(width: 6),
              //         Text(
              //           'Add',
              //           style: TextStyle(
              //             fontSize: 12,
              //             fontWeight: FontWeight.w600,
              //             color: Color(0xFF6132E4),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 5),
          _buildProductSearchBar(),
          const SizedBox(height: 5),
          Expanded(child: _buildSelectedProductsTable()),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodOption(PaymentMethod method, IconData icon) {
    final isSelected = _selectedPaymentMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = method),
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
          'Payment Method',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            _buildPaymentMethodOption(PaymentMethod.gPay, Icons.qr_code),
            const SizedBox(width: 8),
            _buildPaymentMethodOption(PaymentMethod.cash, Icons.money),
          ],
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
          bloc: _form.selectProductBloc,
          listener: (context, state) {
            final hasQuery = _form.serviceSearchController.text.isNotEmpty;
            final hasFilters =
                _form.isPriceFilterEnabled.value ||
                _form.selectedSearchTypeIndex.value != 0;
            final hasAnyFilter = hasQuery || hasFilters;

            state.maybeWhen(
              loading: () {
                // While fetching, show the overlay with a spinner so the user
                // knows something is happening — do NOT remove the overlay.
                if (hasAnyFilter) {
                  _form.overlayIsLoading.value = true;
                  if (_form.searchOverlayEntry == null) {
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
                      _form.overlayIsLoading.value = false;
                      _form.overlayProducts.value = products;
                      if (_form.searchOverlayEntry == null) {
                        _showSearchOverlay();
                      }
                    } else {
                      _form.removeSearchOverlay();
                    }
                  },
              error: (_) {
                _form.overlayIsLoading.value = false;
                _form.overlayProducts.value = [];
                if (hasAnyFilter) {
                  if (_form.searchOverlayEntry == null) {
                    _showSearchOverlay();
                  }
                } else {
                  _form.removeSearchOverlay();
                }
              },
              orElse: () {
                // Error or unknown — only hide if nothing is being searched
                if (!hasAnyFilter) _form.removeSearchOverlay();
              },
            );
          },
          child: CompositedTransformTarget(
            link: _form.searchLayerLink,
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
                        valueListenable: _form.selectedSearchTypeIndex,
                        builder: (context, searchTypeIndex, _) {
                          return ValueListenableBuilder(
                            valueListenable: _form.isPriceFilterEnabled,
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

                              return TextField(
                                controller: _form.serviceSearchController,
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
                                  _onSearchChanged(value);
                                  if (value.isEmpty) {
                                    _form.removeSearchOverlay();
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
                                    final serviceIdToUse =
                                        (selectedServiceId == null ||
                                            selectedServiceId == -1)
                                        ? null
                                        : selectedServiceId;
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

                                    _form.selectProductBloc.add(
                                      SelectProductEvent.searchProducts(
                                        serviceId: serviceIdToUse,
                                        query: queryValue,
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
                        _form.removeSearchOverlay();
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
    if (_form.searchOverlayEntry != null) return;

    _form.searchOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier — tap outside to dismiss
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
          // The actual search overlay
          Positioned(
            width: 1000,
            child: CompositedTransformFollower(
              link: _form.searchLayerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                // Wrap both notifiers so the overlay rebuilds reactively
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
      isSales: selectedBookingType == BookingType.sales,
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

    // For sales mode, use sale_price if available, otherwise fall back to price
    final isSales = selectedBookingType == BookingType.sales;
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
      _form.selectedProductsNotifier.value,
    );

    // Check if this variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      // Check if incrementing would exceed available stock
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;
      final availableStock = variant.remainingStock ?? variant.stock;

      if (newQuantity > availableStock) {
        context.showSnackBar(
          'Cannot add more. Available stock: $availableStock',
          isError: true,
        );
        return; // Don't add the product
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

    _form.selectedProductsNotifier.value = products;
    log('Product added. Total selected: ${products.length}');
    setState(() {}); // Refresh to update UI
  }

  Widget _buildProductListHeader() {
    final isSales = selectedBookingType == BookingType.sales;
    final hasVariants = hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: buildHeaderCell('items', alignLeft: true)),
          const SizedBox(width: 10),
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
          // Days (only for bookings)
          if (!isSales) ...[
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6132E4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$rentalDays',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6132E4),
                    ),
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
                  width: 34,
                  height: 28,
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
                      product.quantity >=
                      (product.variant.remainingStock ??
                          product.variant.stock ??
                          999),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
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
                    onTap: () => startEditingPrice(product),
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
        width: compact ? 20 : 27,
        height: compact ? 20 : 22,
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

  /// Increment quantity of a product with stock validation
  void _incrementQuantity(ProductSelectedEntity product) {
    // Check available stock using remainingStock with fallback to stock
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    final currentQuantity = product.quantity;

    // Silently prevent increment if at max - button should already be disabled
    if (currentQuantity >= availableStock) {
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
      _quantityControllers[_quantityKey(product)]?.text = products[index]
          .quantity
          .toString();
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
        _quantityControllers[_quantityKey(product)]?.text = products[index]
            .quantity
            .toString();
      } else {
        _quantityControllers.remove(_quantityKey(product))?.dispose();
        _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
        products.removeAt(index);
      }
      _form.selectedProductsNotifier.value = products;
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
      _form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );

    if (index == -1) return;

    products[index] = products[index].copyWith(quantity: parsedQuantity);
    _quantityControllers[_quantityKey(product)]?.text = parsedQuantity
        .toString();
    _form.selectedProductsNotifier.value = products;
    _quantityFocusNodes[_quantityKey(product)]?.unfocus();
  }

  void _saveEditingPrice(ProductSelectedEntity product) {
    if (_form.editingVariantId == null) return;

    final newPrice = int.tryParse(_form.inlinePriceController.text);

    // Validate that price is not zero
    if (newPrice == null || newPrice <= 0) {
      context.showSnackBar(
        'Product price cannot be zero or empty',
        isError: true,
      );
      // Keep the field in edit mode
      return;
    }

    updateProductPrice(product, newPrice);

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
    _quantityControllers.remove(_quantityKey(product))?.dispose();
    _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
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
              final isSaleType = selectedBookingType == BookingType.sales;
              final advanceAmount = isSaleType
                  ? 0
                  : (_form.advanceAmountController.text.trim().toIntOrNull() ?? 0);
              final discountAmount =
                  _form.discountAmountController.text.trim().toIntOrNull() ?? 0;

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
                  if (isSaleType)
                    buildSummaryRow(
                      'Total amount',
                      remainingAmount > 0 ? remainingAmount : 0,
                      valueColor: const Color(0xFF6132E4),
                      isBold: true,
                    )
                  else ...[
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
                ],
              );
            },
          ),
          // const SizedBox(height: 3),

          // const SizedBox(height: 3),
          // Add customization button - Only for Dresses (not for sales)
          ValueListenableBuilder<List<ProductSelectedEntity>>(
            valueListenable: _form.selectedProductsNotifier,
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

  void _handleConfirmBooking() async {
    if (!_formKey.currentState!.validate()) {
      context.showSnackBar('Please fill all required fields', isError: true);
      return;
    }

    final products = _form.selectedProductsNotifier.value;
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

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Check if it's a sale or booking
      if (selectedBookingType == BookingType.sales) {
        // Build sales request
        final salesRequest = _buildSalesRequest();
        log('Sales Request: ${salesRequest.toJson()}');

        // Call the API to create sale
        final saleId = await getIt<CreateSaleBookingUseCase>()(
          salesRequest.toJson(),
        );

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
        final bookingId = await getIt<AddBookingUseCase>()(bookingRequest);

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
    final products = _form.selectedProductsNotifier.value;
    final additionalCharges = _form.additionalChargesNotifier.value;

    // Get staff ID from cubit
    final staffState = context.read<StaffSearchCubit>().state;
    final staffId = staffState.selectedStaff?.id;

    // If there's no client ID, we need to send client data
    ClientRequestEntity? clientData;
    if (_form.selectedClientId == null) {
      final phone1 = _form.clientPhone1Controller.text.trim().toIntOrNull();
      final phone2 = _form.clientPhone2Controller.text.trim().toIntOrNull();

      clientData = ClientRequestEntity(
        id: null,
        name: _form.clientNameController.text.trim().isEmpty
            ? null
            : _form.clientNameController.text.trim(),
        phone1: phone1,
        phone2: phone2,
      );
    }

    return BookingRequestEntity(
      clientId: _form.selectedClientId,
      staffId: staffId,
      client: clientData,
      address: _form.clientAddressController.text.trim(),
      pickupDate: pickupDate.format().appendTimeToDate(time: pickupTime),
      // If coolingPeriodDays is 0 (None), use exact return date; otherwise add cooling period days
      returnDate: coolingPeriodDays == 0
          ? returnDate.format().appendTimeToDate(time: returnTime)
          : returnDate
                .add(Duration(days: coolingPeriodDays))
                .format()
                .appendTimeToDate(time: returnTime),
      // If cooling period is None (0), do not send cooling period end date
      coolingPeriodDate: coolingPeriodDays == 0
          ? null
          : returnDate
                .add(Duration(days: coolingPeriodDays))
                .format()
                .appendTimeToDate(time: returnTime),
      advanceAmount: _form.advanceAmountController.text.trim().toIntOrNull(),
      securityAmount: _form.securityAmountController.text.trim().toIntOrNull(),
      discountAmount: _form.discountAmountController.text.trim().toIntOrNull(),
      purchaseMode: 'normal',
      paymentMethod: _form.paymentMethod,
      deliveryStatus: _form.deliveryStatus,
      products: products,
      additionalCharges: additionalCharges.isNotEmpty
          ? additionalCharges
          : null,
      description: _form.descriptionController.text.trim().isNotEmpty
          ? _form.descriptionController.text.trim()
          : null,
      returnTime: returnTime,
      sendPdfToWhatsApp: sendPdfToWhatsApp,
      runningKilometers: _form.runningKilometersController.text
          .trim(), // Added running kilometers
    );
  }

  /// Build sales request for creating a sale
  //TODO: check if RequestSaleModel or SaleRequestModel needs to be used here and rename accordingly for consistency
  RequestSalesModel _buildSalesRequest() {
    final products = _form.selectedProductsNotifier.value;
    final discount = _form.discountAmountController.text.trim().toIntOrNull() ?? 0;
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
    final finalTotal = (grossTotal - discount) > 0
        ? (grossTotal - discount)
        : 0;

    // Get staff ID from cubit
    final staffState = context.read<StaffSearchCubit>().state;
    final staffId = staffState.selectedStaff?.id;

    // Use phone1 as client_phone
    final clientPhone = _form.clientPhone1Controller.text.trim();

    return RequestSalesModel(
      staffId: staffId,
      clientPhone: clientPhone.isEmpty ? null : clientPhone,
      clientAddress: _form.clientAddressController.text.trim().isEmpty
          ? null
          : _form.clientAddressController.text.trim(),
      saleDate: pickupDate.format(), // Use pickup date as sale date
      description: _form.descriptionController.text.trim().isEmpty
          ? null
          : _form.descriptionController.text.trim(),
      sendInvoice: sendPdfToWhatsApp,
      variants: variants,
      // Sales flow has no paid field in UI; mark as fully paid by default.
      paidAmount: finalTotal,
      paymentMethod: _form.paymentMethod,
      discount: discount,
      // Default to true, or use checkbox value if past date
      decreaseStock: decreaseStockForPastDate || !_isPastDate(),
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
                              // Add "None" option
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
                                // Reload products with new cooling period
                                _loadProductsForService(selectedServiceId);
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
    required Future<void> Function() onTap,
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
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) => FocusScope.of(context).nextFocus());
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () =>
                onTap().then((_) => FocusScope.of(context).nextFocus()),
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

  Widget _buildNewTimeField({
    required String label,
    required String value,
    required Future<void> Function() onTap,
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
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
              onTap().then((_) => FocusScope.of(context).nextFocus());
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          child: InkWell(
            onTap: () =>
                onTap().then((_) => FocusScope.of(context).nextFocus()),
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
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientPhone1Controller,
                    hint: 'Client Phone (WP)',
                    isNumber: true,
                    errorText: _phoneError,
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientAddressController,
                    hint: 'Place',
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
                    nameController: _form.staffNameController,
                    errorText: _staffNameError,
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
                      controller: _form.descriptionController,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                    controller: _form.discountAmountController,
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
                        hitText: 'Type or Search name',
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
                  ], // End of name section for bookings only
                  // Phone 1 (WhatsApp) - Always enabled
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientPhone1Controller,
                    hint: 'Whatsapp number',
                    isNumber: true,
                    focusNode: _form.clientPhone1FocusNode,
                    nextFocusNode: _form.clientPhone2FocusNode,
                    errorText: _phoneError,
                    prefixSvgAsset: AppAssets.whatsAppSvg,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  // Phone 2 - Optional, only show for bookings, always enabled
                  if (selectedBookingType != BookingType.sales)
                    BookingTextFieldBuilder.buildRightPanelTextField(
                      controller: _form.clientPhone2Controller,
                      hint: 'Phone 2',
                      isNumber: true,
                      focusNode: _form.clientPhone2FocusNode,
                      nextFocusNode: _form.clientAddressFocusNode,
                      prefixIcon: Icons.phone,
                    ),
                  const SizedBox(height: _fieldSpacing),
                  // Place - Optional
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientAddressController,
                    hint: 'place',
                    focusNode: _form.clientAddressFocusNode,
                    nextFocusNode: null, // Last field
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
                  //     _form.documentsNotifier: _form.documentsNotifier,
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
                    nameController: _form.staffNameController,
                    errorText: _staffNameError,
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
                      controller: _form.descriptionController,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                      return BookingTextFieldBuilder.buildRightPanelTextField(
                        controller: _form.runningKilometersController,
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
              _form.selectedProductsNotifier,
              _form.additionalChargesNotifier,
              _form.advanceAmountController,
              _form.discountAmountController,
            ]),
            builder: (context, _) {
              final products = _form.selectedProductsNotifier.value;
              if (products.isEmpty) return const SizedBox.shrink();

              final additionalCharges = _form.additionalChargesNotifier.value;
              final isSaleType = selectedBookingType == BookingType.sales;
              final advanceAmount = isSaleType
                  ? 0
                  : (_form.advanceAmountController.text.trim().toIntOrNull() ?? 0);
              final discountAmount =
                  _form.discountAmountController.text.trim().toIntOrNull() ?? 0;

              final rentalDays = !isSaleType ? _calculateRentalDays() : 1;
              final productTotal = products.fold<int>(0, (sum, product) {
                final daysMultiplier =
                    (!isSaleType &&
                        shouldMultiplyByDays(product.variant.mainServiceType))
                    ? (rentalDays > 0 ? rentalDays : 1)
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
                              buildSummaryRow('Product total', productTotal),
                              if (additionalTotal > 0)
                                buildSummaryRow(
                                  'Additional charges',
                                  additionalTotal,
                                ),
                              if (discountAmount > 0)
                                buildSummaryRow(
                                  '- Discount',
                                  discountAmount,
                                  isNegative: true,
                                ),
                              const Divider(height: 12, thickness: 1),
                              if (!isSaleType && advanceAmount > 0)
                                buildSummaryRow(
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
          final repo = getIt<SendInvoiceUseCase>();
          await repo(id, sendPdfToWhatsApp);
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
                            final getSaleInvoice =
                                getIt<GetSaleInvoicePdfUseCase>();
                            final pdfBytes = await getSaleInvoice(id);

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
                            final pdfBytes =
                                await getIt<GetBookingInvoicePdfBytesUseCase>()(
                                  id,
                                );

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
                        style: const TextStyle(color: Colors.white),
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
                      _form.removeSearchOverlay();
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
                    controller: _form.advanceAmountController,
                    hint: 'Advance amount',
                    isNumber: true,
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
                  // Payment Method Selection - only show if advance amount has value
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _form.advanceAmountController,
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
                                      onTap: () => removeCharge(charge),
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
                  // Booked Date (optional)
                  const Text(
                    'Booked Date (Optional)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _bookedDate ?? DateTime.now(),
                        firstDate: DateTime(2015),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) setState(() => _bookedDate = picked);
                    },
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _bookedDate != null
                                  ? _bookedDate!.format()
                                  : 'Select booked date',
                              style: TextStyle(
                                fontSize: 13,
                                color: _bookedDate != null
                                    ? Colors.black87
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                          if (_bookedDate != null)
                            GestureDetector(
                              onTap: () => setState(() => _bookedDate = null),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),

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
                        _form.clientNameController.text = client.name;
                        _form.clientPhone1Controller.text = client.phone1.toString();
                        if (client.phone2 != null) {
                          _form.clientPhone2Controller.text = client.phone2
                              .toString();
                        }
                        _form.selectedClientId = client.id;
                      }
                    },
                    child: ClientSearchNameField(
                      nameController: _form.clientNameController,
                      errorText: _clientNameError,
                      hitText: 'Type or search name',
                    ),
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Client Phone
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientPhone1Controller,
                    hint: 'Client Phone',
                    isNumber: true,
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Address
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _form.clientAddressController,
                    hint: 'Place / Address',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Staff
                  const Text(
                    'Staff',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  StaffSearchNameField(
                    nameController: _form.staffNameController,
                    errorText: _staffNameError,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Payment Method
                  _buildPaymentMethodSection(),
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
                      controller: _form.descriptionController,
                      maxLines: null,
                      expands: true,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
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
                  valueListenable: _form.selectedProductsNotifier,
                  builder: (context, products, _) {
                    final total = products.fold<int>(
                      0,
                      (sum, p) => sum + (p.amount * p.quantity),
                    );
                    return Text(
                      '₹ ${total.toCurrency()}',
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
    final products = _form.selectedProductsNotifier.value;

    if (products.isEmpty) {
      context.showSnackBar('Please select at least one item', isError: true);
      return;
    }

    if (_form.clientNameController.text.trim().isEmpty) {
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
      final request = _buildOldBookingRequest();
      log('Old Booking Request: ${request.toString()}');
      await getIt<CreateOldBookingUseCase>()(request);

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
    final products = _form.selectedProductsNotifier.value;
    final totalAmount = products.fold<int>(
      0,
      (sum, p) => sum + (p.amount * p.quantity),
    );

    final staffState = context.read<StaffSearchCubit>().state;
    final staffId = staffState.selectedStaff?.id;

    return BookingRequestEntity(
      clientId: _form.selectedClientId,
      staffId: staffId,
      client: _form.selectedClientId == null
          ? ClientRequestEntity(
              id: null,
              name: _form.clientNameController.text.trim().isEmpty
                  ? null
                  : _form.clientNameController.text.trim(),
              phone1: _form.clientPhone1Controller.text.trim().toIntOrNull(),
            )
          : null,
      address: _form.clientAddressController.text.trim().isEmpty
          ? null
          : _form.clientAddressController.text.trim(),
      bookedDate: _bookedDate?.format(),
      pickupDate: pickupDate.format(),
      returnDate: returnDate.format(),
      advanceAmount: totalAmount,
      paymentMethod: _selectedPaymentMethod,
      deliveryStatus: DeliveryStatus.returned,
      bookingStatus: BookingStatus.completed,
      description: _form.descriptionController.text.trim().isEmpty
          ? null
          : _form.descriptionController.text.trim(),
      products: products,
    );
  }
}
