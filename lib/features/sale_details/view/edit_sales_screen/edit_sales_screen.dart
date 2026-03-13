import 'dart:developer';

import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
// import 'package:bookie_buddy_web/features/service/view_model/bloc/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Edit Sales Screen - Dedicated screen for editing existing sales
class EditSalesScreen extends StatefulWidget {
  final SaleDetailsModel saleDetails;

  const EditSalesScreen({
    required this.saleDetails,
    super.key,
  });

  @override
  State<EditSalesScreen> createState() => _EditSalesScreenState();
}

class _EditSalesScreenState extends State<EditSalesScreen> {
  // Form controller to manage state
  final _formController = AddOrEditSalesFormStateController();
  late final Listenable _totalAmountListener;

  // Product search
  late SelectProductBloc _selectProductBloc;
  final _serviceSearchController = TextEditingController();
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;
  // Reactive overlay state — updated without recreating the OverlayEntry
  final _overlayProducts = ValueNotifier<List<ProductModel>>([]);
  final _overlayIsLoading = ValueNotifier<bool>(false);

  // Inline editing state
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();

  // Filter state
  final _isPriceFilterEnabled = ValueNotifier<bool>(false);
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 10000));
  final _maxPriceNotifier = ValueNotifier<double>(10000);
  int? _selectedServiceId = -1; // -1 means "All Services"
  MainServiceType? _currentServiceType;
  List<String> _searchTypes = ['Name', 'Category', 'Model', 'Color'];

  // Field spacing constant
  static const double _fieldSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    // Initialize with sale details
    _formController.setInitialValues(widget.saleDetails, context);

    // Initialize staff selection in cubit
    _initializeStaff();

    _totalAmountListener = Listenable.merge([
      _formController.discountController,
      _formController.selectedProductsNotifier,
    ]);

    // Initialize SelectProductBloc for product search
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );
  }

  void _initializeStaff() {
    // Load all staffs and select the current staff from sale details
    if (widget.saleDetails.staffId != null) {
      final existingStaff = StaffModel(
        id: widget.saleDetails.staffId!,
        name: widget.saleDetails.staffName ?? 'Staff Name',
        phoneNumber: '',
      );

      // Load all staffs and pre-select the existing staff
      context.read<StaffSearchCubit>().getAllStaffs(
            widget.saleDetails.staffId,
            existingStaff,
          );
    } else {
      // No staff assigned, just load all staffs
      context.read<StaffSearchCubit>()
        ..clearSelectedStaff()
        ..getAllStaffs();
    }
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    _formController.dispose();
    _serviceSearchController.dispose();
    _selectProductBloc.close();
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    _isPriceFilterEnabled.dispose();
    _selectedSearchTypeIndex.dispose();
    _priceRange.dispose();
    _maxPriceNotifier.dispose();
    _overlayProducts.dispose();
    _overlayIsLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: _handlePop,
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SizedBox(
            height: screenHeight,
            child: Form(
              key: _formController.formKey,
              child: Column(
                children: [
                  // Header with back button
                  _buildHeader(),
                  // Main content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Side: Date + Products
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildDateSelectionSection(),
                                const SizedBox(height: 16),
                                Expanded(child: _buildProductsSection()),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Right Side: Details Panel
                          SizedBox(
                            width: 340,
                            child: _buildRightSidePanel(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  // ---- Header with Back Button ----
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          InkWell(
            onTap: _handleBackNavigation,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Title with Sale ID Badge
          Text(
            'Edit Sale',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF6132E4).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF6132E4).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.receipt_long,
                  color: const Color(0xFF6132E4),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  '#${widget.saleDetails.invoiceId}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6132E4),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  // ---- Handle Back Navigation ----
  Future<void> _handleBackNavigation() async {
    if (_hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true) {
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
    }
  }

  // ---- Date Selection Section ----
  Widget _buildDateSelectionSection() {
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
          const Text(
            'Sale date',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: 400,
            child: _buildDateField(
              label: 'Sale date',
              value: _formController.saleDateController.text.isEmpty
                  ? DateTime.now().format()
                  : _formController.saleDateController.text
                      .parseToDateTime()
                      .format(),
              onTap: () => _selectSaleDate(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
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
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: const Color(0xFF9A76E8)),
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
                Icon(Icons.keyboard_arrow_down,
                    size: 18, color: Colors.grey.shade500),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---- Products Section ----
  Widget _buildProductsSection() {
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
          ValueListenableBuilder(
            valueListenable: _formController.selectedProductsNotifier,
            builder: (context, products, _) {
              return Text(
                'Products (${products.length})',
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

  Widget _buildProductSearchBar() {
    return BlocListener<SelectProductBloc, SelectProductState>(
      bloc: _selectProductBloc,
      listener: (context, state) {
        state.maybeWhen(
          loading: () {
            // Show spinner immediately — insert overlay once
            _overlayIsLoading.value = true;
            if (_searchOverlayEntry == null &&
                _serviceSearchController.text.isNotEmpty) {
              _showSearchOverlay();
            }
          },
          loaded: (products, p1, p2, p3, p4, p5, isSearching, p7, p8, p9, p10,
              p11, p12, p13, p14) {
            final hasSearchText = _serviceSearchController.text.isNotEmpty;
            if (hasSearchText) {
              _overlayProducts.value = products;
              _overlayIsLoading.value = false;
              if (_searchOverlayEntry == null) {
                _showSearchOverlay();
              }
            } else {
              _removeSearchOverlay();
            }
          },
          orElse: () {
            // Only remove if there is no active query (avoids tearing down during debounce)
            if (_serviceSearchController.text.isEmpty) {
              _removeSearchOverlay();
            }
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
                  child: TextFormField(
                    controller: _serviceSearchController,
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
                          horizontal: 12, vertical: 14),
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
  }

  void _onSearchChanged() {
    final query = _serviceSearchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    // Apply filters when searching
    _applyProductFilters();
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
  }

  /// Apply product filters based on selection
  void _applyProductFilters() {
    final searchTerm = _serviceSearchController.text.trim();
    final searchTypesList = ['name', 'category', 'model', 'color'];

    // Get the correct search type based on current service
    String searchType;
    final searchTypeIndex = _selectedSearchTypeIndex.value;

    if (_currentServiceType != null && searchTypeIndex == 3) {
      // For 4th option (index 3), use dynamic type based on service
      if (_currentServiceType!.isMultiVariantProductType) {
        if (_currentServiceType == MainServiceType.dress ||
            _currentServiceType == MainServiceType.costume) {
          searchType = 'size';
        } else if (_currentServiceType == MainServiceType.gadgets) {
          searchType = 'serial_number';
        } else {
          searchType = 'variant';
        }
      } else {
        searchType = 'color';
      }
    } else {
      searchType = searchTypesList[searchTypeIndex];
    }

    // Check if any filter is applied
    final hasSearchQuery = searchTerm.isNotEmpty;
    final isPriceEnabled = _isPriceFilterEnabled.value;
    final hasAnyFilter = hasSearchQuery || isPriceEnabled;

    // Trigger search with filters
    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: _selectedServiceId == -1 ? null : _selectedServiceId,
          query: hasSearchQuery ? searchTerm : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: isPriceEnabled ? _priceRange.value.start.round() : null,
          endPrice: isPriceEnabled ? _priceRange.value.end.round() : null,
          pickupDate: _formController.saleDateController.text,
          returnDate: _formController.saleDateController.text,
          isSales: true,
          useAvailableProductsApi: false,
        ),
      );
    }
  }

  /// Show product filter bottom sheet
  void _showProductFilterBottomSheet() {
    // Calculate max price from current product list
    final currentProducts = _selectProductBloc.state.maybeWhen(
      loaded: (products, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13,
              p14) =>
          products,
      orElse: () => <ProductModel>[],
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
          final variantPrice = variant.salePrice ?? variant.price ?? 0;
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

    // Setup local state for dialog
    final isPriceFilterEnabledWidgetNotifier =
        ValueNotifier(_isPriceFilterEnabled.value);
    final tempSelectedSearchTypeIndex =
        ValueNotifier<int>(_selectedSearchTypeIndex.value);
    final tempPriceRange = ValueNotifier<RangeValues>(_priceRange.value);
    final tempMaxPriceNotifier = ValueNotifier<double>(_maxPriceNotifier.value);
    final maxPriceController = TextEditingController(
      text: _maxPriceNotifier.value.toInt().toString(),
    );

    final searchTypes = ['Name', 'Category', 'Model', 'Color'];

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 600,
          ),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                      BlocBuilder<ServiceBloc, ServiceState>(
                        builder: (context, serviceState) {
                          List<ServicesModel> services = [];
                          serviceState.whenOrNull(loaded: (s) => services = s);

                          // Filter out material services for sales
                          services = services
                              .where((s) => !s.mainServiceName
                                  .toLowerCase()
                                  .contains('material'))
                              .toList();

                          if (services.isEmpty) {
                            return const SizedBox.shrink();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                              StatefulBuilder(
                                builder: (context, setStateDialog) {
                                  // Combine "All Services" (-1) and actual services
                                  final allOptions = [
                                    {'id': -1, 'name': 'All Services'},
                                    ...services.map(
                                        (s) => {'id': s.id, 'name': s.name})
                                  ];

                                  return Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: allOptions.map((option) {
                                      final id = option['id'] as int;
                                      final name = option['name'] as String;
                                      final isSelected =
                                          _selectedServiceId == id;

                                      return InkWell(
                                        onTap: () {
                                          setStateDialog(() {
                                            _selectedServiceId = id;
                                            // Update search types when service changes
                                            if (id == -1) {
                                              _currentServiceType = null;
                                              _searchTypes = [
                                                'Name',
                                                'Category',
                                                'Model',
                                                'Color'
                                              ];
                                            } else {
                                              final service =
                                                  services.firstWhere(
                                                (s) => s.id == id,
                                                orElse: () => services.first,
                                              );
                                              _currentServiceType =
                                                  MainServiceType.fromString(
                                                      service.mainServiceName);

                                              // Update search types based on service-specific field labels
                                              final categoryLabel =
                                                  _currentServiceType!
                                                      .categoryFieldLabel;
                                              final secondaryLabel =
                                                  _currentServiceType!
                                                          .secondaryAttributeLabel ??
                                                      'Color';

                                              // Update search types based on whether the service has variants
                                              if (_currentServiceType!
                                                  .isMultiVariantProductType) {
                                                final variantLabel =
                                                    _currentServiceType!
                                                        .variantAttributeLabel;
                                                _searchTypes = [
                                                  'Name',
                                                  categoryLabel,
                                                  secondaryLabel,
                                                  variantLabel
                                                ];
                                              } else {
                                                _searchTypes = [
                                                  'Name',
                                                  categoryLabel,
                                                  secondaryLabel,
                                                  'Color'
                                                ];
                                              }
                                            }

                                            // Reset search type index if out of bounds
                                            if (_selectedSearchTypeIndex
                                                    .value >=
                                                _searchTypes.length) {
                                              _selectedSearchTypeIndex.value =
                                                  0;
                                            }
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xFF6132E4)
                                                : Colors.grey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                                              0xFF6132E4)
                                                          .withOpacity(0.3),
                                                      blurRadius: 8,
                                                      offset:
                                                          const Offset(0, 4),
                                                    ),
                                                  ]
                                                : null,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (isSelected)
                                                const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 6),
                                                  child: Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              Text(
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
                            ],
                          );
                        },
                      ),

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
                            children: searchTypes.asMap().entries.map((entry) {
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
                                              color: const Color(0xFF6132E4)
                                                  .withOpacity(0.3),
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

                      const SizedBox(height: 24),
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
                                activeTrackColor:
                                    const Color(0xFF6132E4).withOpacity(0.3),
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
                                    // Set Max Price Section
                                    const Text(
                                      'Set Max Price',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D2D2D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 42,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: TextField(
                                              controller: maxPriceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                hintText: 'Enter max price',
                                                prefixText: '₹ ',
                                                border: InputBorder.none,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 12,
                                                ),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            final newMax = double.tryParse(
                                              maxPriceController.text.trim(),
                                            );
                                            if (newMax != null && newMax > 0) {
                                              tempMaxPriceNotifier.value =
                                                  newMax;
                                              tempPriceRange.value =
                                                  RangeValues(
                                                0,
                                                newMax,
                                              );
                                              maxPriceController.clear();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 12,
                                            ),
                                            backgroundColor:
                                                const Color(0xFF6132E4),
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text(
                                            'Set',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // Price Display
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
                                              color: Colors.grey.shade100,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              '₹${range.start.round()}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
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
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF6132E4)
                                                      .withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(0xFF6132E4)
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              '₹${range.end.round()}',
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
                                        valueListenable: tempMaxPriceNotifier,
                                        builder:
                                            (context, currentMaxPrice, child) =>
                                                SliderTheme(
                                          data: SliderThemeData(
                                            activeTrackColor:
                                                const Color(0xFF6132E4),
                                            inactiveTrackColor:
                                                Colors.grey.shade200,
                                            thumbColor: const Color(0xFF6132E4),
                                            overlayColor:
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.2),
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
                                            onChanged: (RangeValues newRange) {
                                              tempPriceRange.value = newRange;
                                            },
                                          ),
                                        ),
                                      ),
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
                          tempMaxPriceNotifier.value = _maxPriceNotifier.value;
                          maxPriceController.text =
                              _maxPriceNotifier.value.toInt().toString();
                          tempPriceRange.value =
                              RangeValues(0, tempMaxPriceNotifier.value);
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
                            _selectedSearchTypeIndex.value =
                                tempSelectedSearchTypeIndex.value;
                            _priceRange.value = tempPriceRange.value;
                            _maxPriceNotifier.value =
                                tempMaxPriceNotifier.value;
                            _isPriceFilterEnabled.value =
                                isPriceFilterEnabledWidgetNotifier.value;
                          });

                          Navigator.of(context).pop();

                          // Trigger Application
                          _applyProductFilters();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF6132E4),
                          foregroundColor: Colors.white,
                          elevation: 0,
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

  Widget _buildSelectedProductsTable() {
    return Column(
      children: [
        _buildProductListHeader(),
        Expanded(child: _buildSelectedProductsList()),
      ],
    );
  }

  Widget _buildProductListHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildHeaderCell('items', alignLeft: true),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: _buildHeaderCell('Specifications'),
          ),
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
        color: Colors
            .grey.shade50, // Changed from 0xFFF9F9F9 to avoid any highlight
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
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800, // Changed to standard grey
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSelectedProductsList() {
    return ValueListenableBuilder<List<ProductSelectedModel>>(
      valueListenable: _formController.selectedProductsNotifier,
      builder: (context, products, _) {
        if (products.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 48, color: Colors.grey.shade200),
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
                  ElevatedButton.icon(
                    onPressed: () => _openProductSelector(),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
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

  Widget _buildProductRow(ProductSelectedModel product) {
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
                    image: product.variant.image != null &&
                            product.variant.image!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.variant.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.variant.image == null ||
                          product.variant.image!.isEmpty
                      ? const Icon(Icons.image_not_supported,
                          size: 20, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
                // Text
                Expanded(
                  child: Text(
                    product.variant.name ?? '',
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
          // Specifications
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
          // Quantity Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQuantityBtn(
                    icon: Icons.remove,
                    onTap: () => _decrementQuantity(product)),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '${product.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                _buildQuantityBtn(
                    icon: Icons.add, onTap: () => _incrementQuantity(product)),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // Price / item
          Expanded(
            child: Center(
              child: _editingVariantId == product.variant.variantId
                  ? ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: SizedBox(
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
                                horizontal: 8, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  const BorderSide(color: Color(0xFF6132E4)),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              '${product.amount}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2D3436),
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.edit_outlined,
                              size: 16, color: Color(0xFF6132E4)),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 4),
          // Total
          Expanded(
            child: Center(
              child: Text(
                '${product.amount * product.quantity}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3436),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF6132E4)),
      ),
    );
  }

  String _getProductSpecifications(ProductSelectedModel product) {
    final List<String> specs = [];

    if (product.variant.category != null &&
        product.variant.category!.isNotEmpty) {
      specs.add(product.variant.category!);
    }

    if (product.variant.model != null && product.variant.model!.isNotEmpty) {
      specs.add(product.variant.model!);
    }

    if (product.variant.color != null && product.variant.color!.isNotEmpty) {
      if (!specs.contains(product.variant.color)) {
        specs.add(product.variant.color!);
      }
    }

    return specs.isNotEmpty ? specs.join(' • ') : '-';
  }

  void _incrementQuantity(ProductSelectedModel product) {
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    if (product.quantity >= availableStock) {
      context.showSnackBar(
        'Cannot add more. Only $availableStock items available in stock',
        isError: true,
      );
      return;
    }
    final products = List<ProductSelectedModel>.from(
        _formController.selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );
      _formController.selectedProductsNotifier.value = products;
    }
  }

  void _decrementQuantity(ProductSelectedModel product) {
    final products = List<ProductSelectedModel>.from(
        _formController.selectedProductsNotifier.value);
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
      _formController.selectedProductsNotifier.value = products;
    }
  }

  void _removeProduct(ProductSelectedModel product) {
    final products = List<ProductSelectedModel>.from(
        _formController.selectedProductsNotifier.value);
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    _formController.selectedProductsNotifier.value = products;
  }

  void _startEditingPrice(ProductSelectedModel product) {
    setState(() {
      _editingVariantId = product.variant.variantId;
      _inlinePriceController.text = product.amount.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _inlinePriceFocusNode.requestFocus();
      });
    });
  }

  void _saveEditingPrice(ProductSelectedModel product) {
    if (_editingVariantId == null) return;

    final newPrice = int.tryParse(_inlinePriceController.text);

    if (newPrice == null || newPrice <= 0) {
      context.showSnackBar(
        'Product price cannot be zero or empty',
        isError: true,
      );
      return;
    }

    _updateProductPrice(product, newPrice);

    setState(() {
      _editingVariantId = null;
      _inlinePriceController.clear();
      _inlinePriceFocusNode.unfocus();
    });
  }

  void _updateProductPrice(ProductSelectedModel product, int newPrice) {
    final products = List<ProductSelectedModel>.from(
        _formController.selectedProductsNotifier.value);
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      _formController.selectedProductsNotifier.value = products;
    }
  }

  void _openProductSelector() {
    // Show variant selection dialog for adding new products
    showSizeAmountDialog(
      context: context,
      isSales: true,
      alreadySelectedVariants: _formController.selectedProductsNotifier.value,
      mainServiceType: MainServiceType.costume,
      productImageUrl: '',
      availableVariants: [],
      initialAmount: null,
      initialQuantity: null,
      onConfirm: (id, size, amount, quantity) {
        // This would require full product search integration
        // For now, show a message
        context.showSnackBar(
          'Please use the search bar to add products',
          isError: false,
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
                _serviceSearchController.clear();
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
                    return ValueListenableBuilder<List<ProductModel>>(
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
                                    horizontal: 12, vertical: 8),
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
                                        _serviceSearchController.clear();
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 36),
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
                                      vertical: 32, horizontal: 16),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.search_off_rounded,
                                          size: 48,
                                          color: Colors.grey.shade300),
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
                                        'Try adjusting your search',
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
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
  Widget _buildOverlaySearchItem(ProductModel product) {
    return _OverlaySearchItem(
      product: product,
      onAddProduct: (selectedVariant) {
        _removeSearchOverlay();
        _serviceSearchController.clear();
        _addProductFromSearchWithVariant(product, selectedVariant);
      },
    );
  }

  /// Add product from search with specific variant
  void _addProductFromSearchWithVariant(
      ProductModel product, ProductVariantModel variant) {
    // EditSalesScreen is always in sales mode — prefer sale_price over rent price
    final productSalePriceInt = product.salePrice != null
        ? (double.tryParse(product.salePrice!)?.toInt())
        : null;
    final price = variant.salePrice ?? productSalePriceInt ?? variant.price ?? product.price ?? 0;

    final products = List<ProductSelectedModel>.from(
        _formController.selectedProductsNotifier.value);

    // Check if this variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      // Check stock before incrementing quantity
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;
      final availableStock = variant.remainingStock ?? variant.stock ?? 0;
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
      final availableStock = variant.remainingStock ?? variant.stock ?? 0;
      if (availableStock == 0) {
        context.showSnackBar('This item is out of stock', isError: true);
        return;
      }
      // Add new product with selected variant
      final attribute =
          variant.attribute.isEmpty ? (product.model ?? '') : variant.attribute;

      products.add(ProductSelectedModel(
        variant: ProductInfoModel(
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
          quantity: 1,
          stock: variant.stock,
          remainingStock: variant.remainingStock,
        ),
        quantity: 1,
        amount: price,
      ));
    }

    _formController.selectedProductsNotifier.value = products;
    context.showSnackBar('Product added successfully', isError: false);
  }

  // ---- Right Side Panel ----
  Widget _buildRightSidePanel() {
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
                  // Client Phone
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _formController.clientPhoneController,
                    hint: 'Client Phone (WP)',
                    isNumber: true,
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Place
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _formController.placeController,
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
                    nameController: _formController.staffNameController,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Notes
                  Container(
                    height: 80,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _formController.descriptionController,
                      maxLines: null,
                      expands: true,
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
                    controller: _formController.discountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),

                  // Payment Method
                  _buildPaymentMethodSection(),
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

  // ---- Payment Method Section ----
  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 4),
        ValueListenableBuilder(
          valueListenable: _formController.paymentMethodNotifier,
          builder: (context, paymentMethod, child) => Row(
            children: [
              _buildPaymentMethodOption(
                  PaymentMethod.gPay, Icons.qr_code, paymentMethod),
              const SizedBox(width: 8),
              _buildPaymentMethodOption(
                  PaymentMethod.cash, Icons.money, paymentMethod),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(
      PaymentMethod method, IconData icon, PaymentMethod selectedMethod) {
    final isSelected = selectedMethod == method;
    return Expanded(
      child: InkWell(
        onTap: () => _formController.paymentMethodNotifier.value = method,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
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
                color:
                    isSelected ? const Color(0xFF6132E4) : Colors.grey.shade700,
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

  // ---- Summary Section ----
  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 242, 254),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: [
          // Summary rows
          ListenableBuilder(
            listenable: _totalAmountListener,
            builder: (context, _) {
              final products = _formController.selectedProductsNotifier.value;
              final discountAmount = _formController.discountController.text
                      .trim()
                      .toIntOrNull() ??
                  0;

              final productTotal = products.fold<int>(
                0,
                (sum, product) =>
                    sum + (product.amount * product.variant.quantity),
              );
              final totalPayable = productTotal - discountAmount;

              return Column(
                children: [
                  _buildSummaryRow('Product total', productTotal),
                  if (discountAmount > 0)
                    _buildSummaryRow('- Discount', discountAmount,
                        isNegative: true),
                  const Divider(height: 6),
                  _buildSummaryRow(
                    'Total payable',
                    totalPayable > 0 ? totalPayable : 0,
                    valueColor: const Color(0xFFD30000),
                    isBold: true,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          // Update button
          SizedBox(
            width: double.infinity,
            height: 39,
            child: BlocConsumer<SaveSalesCubit, SaveSalesState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: (message) {
                    context.showSnackBar('Sale updated successfully!');
                    Navigator.of(context).pop(true);
                  },
                  failure: (failure) {
                    context.showSnackBar(
                      failure,
                      isError: true,
                    );
                  },
                );
              },
              builder: (context, state) {
                final isSaving = state.maybeMap(
                  orElse: () => false,
                  saving: (_) => true,
                );
                return ElevatedButton(
                  onPressed: isSaving ? null : _handleUpdateSale,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6132E4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey.shade400,
                  ),
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Update Sale',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                );
              },
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

  // ---- Handle Update Sale ----
  void _handleUpdateSale() {
    final req = _formController.buildRequest(
      saleDetails: widget.saleDetails,
      context: context,
    );
    if (req == null) return;

    // 📊 DETAILED LOGGING FOR DEBUGGING
    log('\n' + '=' * 80);
    log('📤 SALES UPDATE REQUEST DATA');
    log('=' * 80);
    log('Sale ID: ${req.id}');
    log('Staff ID: ${req.staffId}');
    log('Client Phone: ${req.clientPhone}');
    log('Address: ${req.address}');
    log('Sale Date: ${req.saleDate}');
    log('Description: ${req.description}');
    log('Discount: ${req.discountAmount}');
    log('Payment Method: ${req.paymentMethod?.value}');
    log('\n--- PRODUCTS/VARIANTS (${req.products?.length ?? 0}) ---');
    if (req.products == null || req.products!.isEmpty) {
      log('⚠️ WARNING: Products list is NULL or EMPTY!');
      log('This will clear all products on backend!');
    } else {
      req.products!.asMap().forEach((index, product) {
        final variantJson = product.toCustomJson(includeMeasurement: false);
        log('Variant ${index + 1}: ${variantJson}');
        log('  - ID: ${variantJson['id']}');
        log('  - Quantity: ${variantJson['quantity']}');
        log('  - Amount: ${variantJson['amount']}');
      });
    }
    log('\n🔍 FULL JSON BEING SENT TO BACKEND:');
    final jsonData = req.toJson();
    log('{\n  "sale_date": "${jsonData['sale_date']}",');
    log('  "staff_id": ${jsonData['staff_id']},');
    log('  "client_phone": "${jsonData['client_phone']}",');
    log('  "client_address": "${jsonData['client_address']}",');
    log('  "description": "${jsonData['description']}",');
    log('  "discount": ${jsonData['discount']},');
    log('  "payment_method": "${jsonData['payment_method']}",');
    log('  "variants": ${jsonData['variants']}');
    log('}');
    log('\n📋 Compare with Postman format:');
    log('Postman uses: "variants": [{"id": 645, "quantity": 1, "amount": 2500}]');
    log('We are sending: "variants": ${jsonData['variants']}');
    log('=' * 80 + '\n');

    context.read<SaveSalesCubit>().saveSales(
          salesRequest: req,
          isEditMode: true,
        );
  }

  // ---- Sale Date Picker ----
  Future<void> _selectSaleDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _formController.saleDateController.text.isEmpty
          ? DateTime.now()
          : _formController.saleDateController.text.parseToDateTime(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
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
      _formController.saleDateController.text = picked.format();
    }
  }

  // -------- Discard Changes Helpers --------
  void _handlePop(bool didPop, dynamic result) async {
    if (didPop) return;
    if (_hasUnsavedChanges()) {
      final discard = await showDiscardDialog(context);
      if (discard ?? false) {
        if (context.mounted) Navigator.pop(context, result);
      }
    } else {
      if (context.mounted) Navigator.pop(context, result);
    }
  }

  bool _hasUnsavedChanges() {
    final products = _formController.selectedProductsNotifier.value;
    final discountText = _formController.discountController.text.trim();

    // Compare with original values
    final dateChanged = _formController.saleDateController.text !=
        widget.saleDetails.saleDate.formatToUiDate();

    final phoneChanged = _formController.clientPhoneController.text.trim() !=
        widget.saleDetails.clientPhone.toString();

    final placeChanged = _formController.placeController.text.trim() !=
        (widget.saleDetails.address.isNotNullOrEmpty
            ? widget.saleDetails.address
            : '');

    final descChanged = _formController.descriptionController.text.trim() !=
        widget.saleDetails.description;

    final discountChanged =
        (discountText.isNotEmpty ? discountText.toIntOrNull() ?? 0 : 0) !=
            widget.saleDetails.discountAmount;

    final paymentChanged = _formController.paymentMethodNotifier.value !=
        widget.saleDetails.paymentMethod;

    final productsChanged =
        products.length != widget.saleDetails.products.length;

    return dateChanged ||
        phoneChanged ||
        placeChanged ||
        descChanged ||
        discountChanged ||
        paymentChanged ||
        productsChanged;
  }
}

// ==================== Search Overlay Widgets ====================

/// Search result item widget shown in overlay
class _OverlaySearchItem extends StatefulWidget {
  final ProductModel product;
  final Function(ProductVariantModel) onAddProduct;

  const _OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
  });

  @override
  State<_OverlaySearchItem> createState() => _OverlaySearchItemState();
}

class _OverlaySearchItemState extends State<_OverlaySearchItem> {
  ProductVariantModel? selectedVariant;

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
      final hasVisibleChip =
          widget.product.variants.any((v) => v.attribute.isNotEmpty);
      if (!hasVisibleChip && widget.product.variants.isNotEmpty) {
        selectedVariant = widget.product.variants.first;
      } else {
        selectedVariant = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // EditSalesScreen is always in sales mode — prefer sale_price over rent price
    final price = widget.product.salePrice != null
        ? (double.tryParse(widget.product.salePrice!)?.toInt() ?? widget.product.price ?? 0)
        : (widget.product.price ?? 0);
    final variants = widget.product.variants;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 50,
              height: 40,
              color: Colors.grey.shade100,
              child: widget.product.image != null &&
                      widget.product.image!.isNotEmpty
                  ? Image.network(
                      widget.product.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.image_outlined,
                        size: 20,
                        color: Colors.grey.shade400,
                      ),
                    )
                  : Icon(Icons.image_outlined,
                      size: 20, color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 10),

          // Product Info - Fixed width
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.color ?? 'color',
                  style: const TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          // Divider
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
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
                          }).toList(),
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
                          fontSize: 12, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (widget.product.model != null &&
                      widget.product.model!.isNotEmpty)
                    Text(
                      '${widget.product.mainServiceType.secondaryAttributeLabel ?? "Model"}: ${widget.product.model}',
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
          const SizedBox(width: 12),

          // Price section - Fixed width (equal to button)
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'price',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
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
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
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
                      color: Colors.grey.shade600),
                ),
                Text(
                  selectedVariant != null
                      ? '${selectedVariant!.remainingStock ?? selectedVariant!.stock ?? 0}'
                      : (variants.isNotEmpty
                          ? '${variants.first.remainingStock ?? variants.first.stock ?? 0}'
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
        padding:
            isShortText ? null : const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isShortText ? null : BorderRadius.circular(8),
          color: isSelected ? const Color(0xFFF3F0FF) : const Color(0xFFF8F7FF),
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
