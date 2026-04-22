import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/features/sales/presentation/bloc/save_sales_cubit/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/sales/presentation/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_form_app_bar.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_form_date_section.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/presentation/common/widgets/account_selection_field.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_form_product_list_header.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_form_product_table_row.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_form_summary_section.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_product_filter_dialog.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_search_overlay_item.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/widgets/staff_search_name_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSalesScreen extends StatefulWidget {
  final SaleDetailsEntity saleDetails;

  const EditSalesScreen({required this.saleDetails, super.key});

  @override
  State<EditSalesScreen> createState() => _EditSalesScreenState();
}

class _EditSalesScreenState extends State<EditSalesScreen> {
  final _formController = AddOrEditSalesFormStateController();
  late final Listenable _totalAmountListener;

  // Product search
  late SelectProductBloc _selectProductBloc;
  final _serviceSearchController = TextEditingController();
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;
  final _overlayProducts = ValueNotifier<List<ProductEntity>>([]);
  final _overlayIsLoading = ValueNotifier<bool>(false);

  // Inline price editing
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();

  // Filter state
  final _isPriceFilterEnabled = ValueNotifier<bool>(false);
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 10000));
  final _maxPriceNotifier = ValueNotifier<double>(10000);
  int? _selectedServiceId = -1;
  MainServiceType? _currentServiceType;
  List<String> _searchTypes = ['Name', 'Category', 'Model', 'Color'];

  static const double _fieldSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    _formController.setInitialValues(widget.saleDetails, context);
    _initializeStaff();
    _totalAmountListener = Listenable.merge([
      _formController.discountController,
      _formController.selectedProductsNotifier,
    ]);
    _selectProductBloc = SelectProductBloc(
      getAvailableProducts: getIt.get(),
      getProducts: getIt.get(),
      searchAndFilterProducts: getIt.get(),
    );
  }

  void _initializeStaff() {
    if (widget.saleDetails.staffId != null) {
      final existingStaff = StaffEntity(
        id: widget.saleDetails.staffId!,
        name: widget.saleDetails.staffName ?? 'Staff Name',
        phoneNumber: '',
      );
      context.read<StaffSearchCubit>().getAllStaffs(
        widget.saleDetails.staffId,
        existingStaff,
      );
    } else {
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
                SalesFormAppBar(
                  invoiceId: widget.saleDetails.invoiceId,
                  onBack: _handleBackNavigation,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SalesFormDateSection(
                                formController: _formController,
                                onSelectDate: () => _selectSaleDate(context),
                              ),
                              const SizedBox(height: 16),
                              Expanded(child: _buildProductsSection()),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(width: 340, child: _buildRightSidePanel()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
            color: Colors.black.withValues(alpha: 0.02),
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
            builder: (context, products, _) => Text(
              'Products (${products.length})',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
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
            _overlayIsLoading.value = true;
            if (_searchOverlayEntry == null &&
                _serviceSearchController.text.isNotEmpty) {
              _showSearchOverlay();
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
                final hasSearchText = _serviceSearchController.text.isNotEmpty;
                if (hasSearchText) {
                  _overlayProducts.value = products;
                  _overlayIsLoading.value = false;
                  if (_searchOverlayEntry == null) _showSearchOverlay();
                } else {
                  _removeSearchOverlay();
                }
              },
          orElse: () {
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
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                    onChanged: (value) {
                      _onSearchChanged();
                      if (value.isEmpty) _removeSearchOverlay();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
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
                    _showProductFilterDialog();
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

  Widget _buildSelectedProductsTable() {
    return Column(
      children: [
        const SalesFormProductListHeader(),
        Expanded(child: _buildSelectedProductsList()),
      ],
    );
  }

  Widget _buildSelectedProductsList() {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
      valueListenable: _formController.selectedProductsNotifier,
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
                  ElevatedButton.icon(
                    onPressed: _openProductSelector,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Product'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6132E4),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
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
          itemBuilder: (context, index) => SalesFormProductTableRow(
            product: products[index],
            isEditing: _editingVariantId == products[index].variant.variantId,
            inlinePriceController: _inlinePriceController,
            inlinePriceFocusNode: _inlinePriceFocusNode,
            onStartEditing: () => _startEditingPrice(products[index]),
            onSaveEditing: () => _saveEditingPrice(products[index]),
            onIncrement: () => _incrementQuantity(products[index]),
            onDecrement: () => _decrementQuantity(products[index]),
            onRemove: () => _removeProduct(products[index]),
          ),
        );
      },
    );
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
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _formController.clientPhoneController,
                    hint: 'Client Phone (WP)',
                    isNumber: true,
                    prefixIcon: Icons.phone,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _formController.placeController,
                    hint: 'Place',
                    prefixIcon: Icons.location_on,
                  ),
                  const SizedBox(height: _fieldSpacing),
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
                  BookingTextFieldBuilder.buildRightPanelTextField(
                    controller: _formController.discountController,
                    hint: 'Discount amount',
                    isNumber: true,
                  ),
                  const SizedBox(height: _fieldSpacing),
                  const SizedBox(height: _fieldSpacing),
                  ValueListenableBuilder<AccountEntity?>(
                    valueListenable: _formController.selectedAccountNotifier,
                    builder: (context, selectedAccount, _) =>
                        AccountSelectionField(
                          selectedAccount: selectedAccount,
                          onChanged: (account) {
                            _formController.selectedAccountNotifier.value =
                                account;
                          },
                          initialAccountId: widget.saleDetails.accountId,
                        ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Container(
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
                SalesFormSummarySection(
                  formController: _formController,
                  totalAmountListener: _totalAmountListener,
                  onSave: _handleUpdateSale,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- Search Overlay ----
  void _onSearchChanged() {
    final query = _serviceSearchController.text.trim();
    if (query.isEmpty) return;
    _applyProductFilters();
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
  }

  void _applyProductFilters() {
    final searchTerm = _serviceSearchController.text.trim();
    final searchTypesList = ['name', 'category', 'model', 'color'];

    String searchType;
    final searchTypeIndex = _selectedSearchTypeIndex.value;
    if (_currentServiceType != null && searchTypeIndex == 3) {
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

    final hasSearchQuery = searchTerm.isNotEmpty;
    final isPriceEnabled = _isPriceFilterEnabled.value;

    if (hasSearchQuery || isPriceEnabled) {
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

  void _showProductFilterDialog() {
    // Calculate max price from current product list
    final currentProducts = _selectProductBloc.state.maybeWhen(
      loaded:
          (
            products,
            p1,
            p2,
            p3,
            p4,
            p5,
            p6,
            p7,
            p8,
            p9,
            p10,
            p11,
            p12,
            p13,
            p14,
          ) => products,
      orElse: () => <ProductEntity>[],
    );

    double maxProductPrice = _maxPriceNotifier.value;
    for (final product in currentProducts) {
      final productPrice = (product.price ?? 0).toDouble();
      if (productPrice > maxProductPrice) maxProductPrice = productPrice;
      for (final variant in product.variants) {
        final variantPrice = (variant.salePrice ?? variant.price ?? 0)
            .toDouble();
        if (variantPrice > maxProductPrice) maxProductPrice = variantPrice;
      }
    }
    if (maxProductPrice > _maxPriceNotifier.value) {
      _maxPriceNotifier.value = maxProductPrice;
      _priceRange.value = RangeValues(0, maxProductPrice);
    }

    showDialog<SalesFilterResult>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => SalesProductFilterDialog(
        initialServiceId: _selectedServiceId,
        initialServiceType: _currentServiceType,
        initialSearchTypes: _searchTypes,
        initialSearchTypeIndex: _selectedSearchTypeIndex.value,
        initialIsPriceFilterEnabled: _isPriceFilterEnabled.value,
        initialPriceRange: _priceRange.value,
        initialMaxPrice: _maxPriceNotifier.value,
      ),
    ).then((result) {
      if (result == null) return;
      setState(() {
        _selectedServiceId = result.serviceId;
        _currentServiceType = result.serviceType;
        _searchTypes = result.searchTypes;
        _selectedSearchTypeIndex.value = result.searchTypeIndex;
        _isPriceFilterEnabled.value = result.isPriceFilterEnabled;
        _priceRange.value = result.priceRange;
        _maxPriceNotifier.value = result.maxPrice;
      });
      _applyProductFilters();
    });
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
                  builder: (context, isLoading, _) =>
                      ValueListenableBuilder<List<ProductEntity>>(
                        valueListenable: _overlayProducts,
                        builder: (context, productList, _) => Container(
                          constraints: const BoxConstraints(maxHeight: 450),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    itemCount: productList.length,
                                    separatorBuilder: (_, __) => Divider(
                                      height: 1,
                                      color: Colors.grey.shade200,
                                    ),
                                    itemBuilder: (_, i) =>
                                        SalesSearchOverlayItem(
                                          product: productList[i],
                                          onAddProduct: (variant) {
                                            _removeSearchOverlay();
                                            _serviceSearchController.clear();
                                            _addProductFromSearchWithVariant(
                                              productList[i],
                                              variant,
                                            );
                                          },
                                        ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  // ---- Product mutations ----
  void _addProductFromSearchWithVariant(
    ProductEntity product,
    ProductVariantEntity variant,
  ) {
    final productSalePriceInt = product.salePrice != null
        ? (double.tryParse(product.salePrice!)?.toInt())
        : null;
    final price =
        variant.salePrice ??
        productSalePriceInt ??
        variant.price ??
        product.price ??
        0;

    final products = List<ProductSelectedEntity>.from(
      _formController.selectedProductsNotifier.value,
    );
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;
      final availableStock = variant.remainingStock ?? variant.stock;
      if (availableStock > 0 && newQuantity > availableStock) {
        context.showSnackBar(
          'Cannot add more. Only $availableStock items available in stock',
          isError: true,
        );
        return;
      }
      products[existingIndex] = existing.copyWith(quantity: newQuantity);
    } else {
      final availableStock = variant.remainingStock ?? variant.stock;
      if (availableStock == 0) {
        context.showSnackBar('This item is out of stock', isError: true);
        return;
      }
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
            quantity: 1,
            stock: variant.stock,
            remainingStock: variant.remainingStock,
          ),
          quantity: 1,
          amount: price,
        ),
      );
    }

    _formController.selectedProductsNotifier.value = products;
    context.showSnackBar('Product added successfully', isError: false);
  }

  void _incrementQuantity(ProductSelectedEntity product) {
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    if (product.quantity >= availableStock) {
      context.showSnackBar(
        'Cannot add more. Only $availableStock items available in stock',
        isError: true,
      );
      return;
    }
    _updateProductList((products, index) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );
    }, product);
  }

  void _decrementQuantity(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      _formController.selectedProductsNotifier.value,
    );
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

  void _removeProduct(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      _formController.selectedProductsNotifier.value,
    );
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    _formController.selectedProductsNotifier.value = products;
  }

  void _startEditingPrice(ProductSelectedEntity product) {
    setState(() {
      _editingVariantId = product.variant.variantId;
      _inlinePriceController.text = product.amount.toString();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _inlinePriceFocusNode.requestFocus();
      });
    });
  }

  void _saveEditingPrice(ProductSelectedEntity product) {
    if (_editingVariantId == null) return;
    final newPrice = int.tryParse(_inlinePriceController.text);
    if (newPrice == null || newPrice <= 0) {
      context.showSnackBar(
        'Product price cannot be zero or empty',
        isError: true,
      );
      return;
    }
    _updateProductList(
      (products, index) =>
          products[index] = products[index].copyWith(amount: newPrice),
      product,
    );
    setState(() {
      _editingVariantId = null;
      _inlinePriceController.clear();
      _inlinePriceFocusNode.unfocus();
    });
  }

  void _updateProductList(
    void Function(List<ProductSelectedEntity> products, int index) update,
    ProductSelectedEntity product,
  ) {
    final products = List<ProductSelectedEntity>.from(
      _formController.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      update(products, index);
      _formController.selectedProductsNotifier.value = products;
    }
  }

  void _openProductSelector() {
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
        context.showSnackBar(
          'Please use the search bar to add products',
          isError: false,
        );
      },
    );
  }

  // ---- Save / navigation ----
  void _handleUpdateSale() {
    final req = _formController.buildRequest(
      saleDetails: widget.saleDetails,
      context: context,
    );
    if (req == null) return;

    log(
      'Sale update request: id=${req.id}, staffId=${req.staffId}, '
      'products=${req.products?.length ?? 0}\n'
      'req: ${req.toString()}',
    );

    context.read<SaveSalesCubit>().saveSales(
      salesRequest: req,
      isEditMode: true,
    );
  }

  Future<void> _selectSaleDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _formController.saleDateController.text.isEmpty
          ? DateTime.now()
          : _formController.saleDateController.text.parseToDateTime(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: Color(0xFF6132E4)),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      _formController.saleDateController.text = picked.format();
    }
  }

  Future<void> _handleBackNavigation() async {
    if (_hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true && mounted) Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handlePop(bool didPop, dynamic result) async {
    if (didPop) return;
    if (_hasUnsavedChanges()) {
      final discard = await showDiscardDialog(context);
      if ((discard ?? false) && context.mounted) {
        Navigator.pop(context, result);
      }
    } else {
      if (context.mounted) Navigator.pop(context, result);
    }
  }

  bool _hasUnsavedChanges() {
    final products = _formController.selectedProductsNotifier.value;
    final discountText = _formController.discountController.text.trim();

    final dateChanged =
        _formController.saleDateController.text !=
        widget.saleDetails.saleDate.formatToUiDate();
    final phoneChanged =
        _formController.clientPhoneController.text.trim() !=
        widget.saleDetails.clientPhone.toString();
    final placeChanged =
        _formController.placeController.text.trim() !=
        (widget.saleDetails.address.isNotNullOrEmpty
            ? widget.saleDetails.address
            : '');
    final descChanged =
        _formController.descriptionController.text.trim() !=
        widget.saleDetails.description;
    final discountChanged =
        (discountText.isNotEmpty ? discountText.toIntOrNull() ?? 0 : 0) !=
        widget.saleDetails.discountAmount;
    final accountChanged =
        _formController.selectedAccountNotifier.value?.id !=
        widget.saleDetails.accountId;
    final productsChanged =
        products.length != widget.saleDetails.products.length;

    return dateChanged ||
        phoneChanged ||
        placeChanged ||
        descChanged ||
        discountChanged ||
        accountChanged ||
        productsChanged;
  }
}
