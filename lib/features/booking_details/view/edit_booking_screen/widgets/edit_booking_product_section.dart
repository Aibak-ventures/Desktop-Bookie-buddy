import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_vehicle_customization_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/customization_expansion_tile.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_search_type_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/add_booking/models/measurement_value_model/measurement_value_model.dart';
import 'package:bookie_buddy_web/features/add_booking/view/add_customization_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/controller/edit_booking_form_state_controller.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/components/edit_booking_product_list_tile.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookingProductSection extends StatefulWidget {
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final EditBookingFormStateController formController;
  final DateTime pickupDate;
  final DateTime returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;

  const EditBookingProductSection({
    super.key,
    required this.selectedProductsNotifier,
    required this.formController,
    required this.pickupDate,
    required this.returnDate,
    this.pickupTime,
    this.returnTime,
  });

  @override
  State<EditBookingProductSection> createState() =>
      _EditBookingProductSectionState();
}

class _EditBookingProductSectionState extends State<EditBookingProductSection> {
  late SelectProductBloc _selectProductBloc;
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;

  int? selectedServiceId = -1; // -1 means "All Services"
  final serviceSearchController = TextEditingController();

  // Product search filter state
  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);
  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Initialize SelectProductBloc
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );

    // Load services
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceBloc>().add(const ServiceEvent.loadServices());
    });
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    serviceSearchController.dispose();
    _selectProductBloc.close();
    _selectedSearchTypeIndex.dispose();
    _priceRange.dispose();
    _maxPriceNotifier.dispose();
    _isPriceFilterEnabled.dispose();
    super.dispose();
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
  }

  void _showProductFilterBottomSheet() {
    // Calculate max price from current product list
    final currentProducts = _selectProductBloc.state.maybeWhen(
      loaded: (
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
      ) =>
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

    showSearchTypeBottomSheet(
      context: context,
      searchTypes: _searchTypes,
      selectedSearchTypeIndex: _selectedSearchTypeIndex,
      onTap: (type, index) {
        _selectedSearchTypeIndex.value = index;
      },
      priceRange: _priceRange,
      minPrice: 0,
      maxPriceNotifier: _maxPriceNotifier,
      onPriceChanged: (range) {
        _priceRange.value = range;
      },
      isPriceFilterEnabledNotifier: _isPriceFilterEnabled,
      onApply: (typeIndex, range, isPriceEnabled) {
        _applyProductFilters(typeIndex, range, isPriceEnabled);
      },
    );
  }

  void _applyProductFilters(
      int searchTypeIndex, RangeValues priceRange, bool isPriceEnabled) {
    final searchTerm = serviceSearchController.text.trim();

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
        searchType = 'color';
        break;
    }

    // Check if any filter is applied
    final hasAnyFilter =
        searchTerm.isNotEmpty || isPriceEnabled || searchTypeIndex != 0;

    // Trigger search with filters
    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: searchTerm.isEmpty ? null : searchTerm,
          type: searchType,
          startPrice: isPriceEnabled ? priceRange.start.toInt() : null,
          endPrice: isPriceEnabled ? priceRange.end.toInt() : null,
          pickupDate: widget.pickupDate.format(),
          returnDate: widget.returnDate.format(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
          useAvailableProductsApi: true,
          isSales: false,
        ),
      );
    } else {
      // No filters applied, load all products
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          pickupDate: widget.pickupDate.format(),
          returnDate: widget.returnDate.format(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
          useAvailableProductsApi: true,
          isSales: false,
        ),
      );
    }
  }

  void _onSearchChanged() {
    final query = serviceSearchController.text.trim();
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
            ? null
            : selectedServiceId;

    if (query.isEmpty) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: widget.pickupDate.format(),
          returnDate: widget.returnDate.format(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
          useAvailableProductsApi: true,
          isSales: false,
        ),
      );
    } else {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: query,
          type: 'name',
          pickupDate: widget.pickupDate.format(),
          returnDate: widget.returnDate.format(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
          useAvailableProductsApi: true,
          isSales: false,
        ),
      );
    }
  }

  void _loadProductsForService(int? serviceId) {
    final serviceIdToUse =
        (serviceId == null || serviceId == -1) ? null : serviceId;

    _selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: widget.pickupDate.format(),
        returnDate: widget.returnDate.format(),
        pickupTime: widget.pickupTime,
        returnTime: widget.returnTime,
        useAvailableProductsApi: true,
        isSales: false,
      ),
    );
  }

  void _showSearchOverlay(List<ProductModel> products) {
    _removeSearchOverlay();

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.45,
        child: CompositedTransformFollower(
          link: _searchLayerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 44),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 320),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with close button
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Search Results (${products.length})',
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
                  // Product list
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: products.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (_, i) =>
                          _buildProductSearchItem(products[i]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  Widget _buildProductSearchItem(ProductModel product) {
    return _ProductSearchItem(
      product: product,
      onAddProduct: (selectedVariant) {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _addProductWithVariant(product, selectedVariant);
      },
    );
  }

  void _addProductWithVariant(
      ProductModel product, ProductVariantModel variant) {
    // Convert ProductVariantModel to ProductInfoModel
    final productInfo = ProductInfoModel(
      id: variant.id,
      productId: product.id,
      variantId: variant.id,
      name: product.name,
      image: product.image,
      mainServiceType: product.mainServiceType,
      variantAttribute: variant.attribute,
      color: product.color,
      category: product.category,
      model: product.model,
      quantity: 1,
      amount: variant.price ?? product.price ?? 0,
      measurements: const [],
      stock: variant.remainingStock ?? variant.stock,
    );

    // Create a new ProductSelectedModel
    final newProduct = ProductSelectedModel(
      variant: productInfo,
      quantity: 1,
      amount: variant.price ?? product.price ?? 0,
      measurements: [],
    );

    // Update the selected products list
    final existingProducts = widget.selectedProductsNotifier.value;
    final updatedProducts = <ProductSelectedModel>[];

    // Add all existing products
    updatedProducts.addAll(existingProducts);

    // Check if this variant is already selected
    final existingIndex = updatedProducts.indexWhere(
      (p) => p.variant.id == variant.id,
    );

    if (existingIndex != -1) {
      // Update existing product quantity
      final existing = updatedProducts[existingIndex];
      updatedProducts[existingIndex] =
          existing.copyWith(quantity: existing.quantity + 1);
    } else {
      // Add new product
      updatedProducts.add(newProduct);
    }

    widget.selectedProductsNotifier.value = updatedProducts;
  }

  void _showProductDialog(ProductModel product) async {
    _removeSearchOverlay();

    // Check if mainServiceType is null
    if (product.mainServiceType == null) {
      // Show error message if mainServiceType is missing
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product service type is not available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Get already selected variants for this product
    final alreadySelected = widget.selectedProductsNotifier.value
        .where((p) => p.variant.productId == product.id)
        .toList();

    showSizeAmountDialog(
      context: context,
      mainServiceType: product.mainServiceType!, // Now safe to use ! operator
      productImageUrl: product.image ?? '',
      availableVariants: product.variants,
      alreadySelectedVariants: alreadySelected,
      initialAmount: product.price?.toString(),
      isSales: false,
      onConfirm: (variantId, size, amount, quantity) {
        // Find the selected variant
        final selectedVariant = product.variants.firstWhere(
          (v) => v.id == variantId,
          orElse: () => product.variants.first,
        );

        // Convert ProductVariantModel to ProductInfoModel
        final productInfo = ProductInfoModel(
          id: selectedVariant.id,
          productId: product.id,
          variantId: selectedVariant.id,
          name: product.name,
          image: product.image,
          mainServiceType: product.mainServiceType,
          variantAttribute: selectedVariant.attribute,
          color: product.color,
          category: product.category,
          model: product.model,
          quantity: quantity,
          amount: int.tryParse(amount) ?? 0,
          measurements: const [],
          stock: selectedVariant.remainingStock ?? selectedVariant.stock,
        );

        // Create a new ProductSelectedModel
        final newProduct = ProductSelectedModel(
          variant: productInfo,
          quantity: quantity,
          amount: int.tryParse(amount) ?? 0,
          measurements: [],
        );

        // Update the selected products list
        final existingProducts = widget.selectedProductsNotifier.value;
        final updatedProducts = <ProductSelectedModel>[];

        // Add all existing products
        updatedProducts.addAll(existingProducts);

        // Check if this variant is already selected
        final existingIndex = updatedProducts.indexWhere(
          (p) => p.variant.id == selectedVariant.id,
        );

        if (existingIndex != -1) {
          // Update existing product
          updatedProducts[existingIndex] = newProduct;
        } else {
          // Add new product
          updatedProducts.add(newProduct);
        }

        widget.selectedProductsNotifier.value = updatedProducts;
      },
    );
  }

  void _updateProductMeasurement(
    ProductSelectedModel model,
    List<MeasurementValueModel> result,
  ) {
    widget.selectedProductsNotifier.value =
        widget.selectedProductsNotifier.value.map((e) {
      if (e.variant.variantId == model.variant.variantId) {
        return e.copyWith(measurements: result);
      }
      return e;
    }).toList();
  }

  Widget? _buildCustomization(
    BuildContext context,
    ProductSelectedModel model,
  ) {
    final product = model.variant;
    final measurements = model.measurements;

    if (!product.mainServiceType.isDress &&
        !product.mainServiceType.isVehicle) {
      return null;
    }

    return CustomizationExpansionTile(
      expansionTitle: product.mainServiceType.isVehicle ? 'More Details' : null,
      measurements: measurements,
      onButtonTap: () async {
        if (product.mainServiceType.isVehicle) {
          final result = await showVehicleCustomizationDialog(
            context,
            measurements.firstOrNull,
          );
          if (result != null) {
            _updateProductMeasurement(model, [result]);
          }
          return;
        }

        final result = await Navigator.push<List<MeasurementValueModel>>(
          context,
          MaterialPageRoute(
            builder: (_) =>
                AddCustomizationScreen(addedMeasurements: measurements),
          ),
        );
        if (result != null) {
          _updateProductMeasurement(model, result);
        }
      },
    );
  }

  void _removeProduct(ProductSelectedModel productModel) {
    final currentList = widget.selectedProductsNotifier.value;

    widget.selectedProductsNotifier.value = currentList
        .where((item) => item.variant.id != productModel.variant.id)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10, height: 20),
              Text(
                '  Product Selection',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          _buildProductSearchBar(),
          const SizedBox(height: 6),
          Expanded(child: _buildSelectedProductsSection()),
        ],
      ),
    );
  }

  Widget _buildProductSearchBar() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocListener<SelectProductBloc, SelectProductState>(
          bloc: _selectProductBloc,
          listener: (context, state) {
            state.maybeWhen(
              loaded: (products, p1, p2, p3, p4, p5, isSearching, p7, p8, p9,
                  p10, p11, p12, p13, p14) {
                final hasSearchText = serviceSearchController.text.isNotEmpty;
                final hasFilters = _isPriceFilterEnabled.value ||
                    _selectedSearchTypeIndex.value != 0;

                if (products.isNotEmpty &&
                    (hasSearchText || hasFilters || isSearching)) {
                  _showSearchOverlay(products);
                } else {
                  _removeSearchOverlay();
                }
              },
              orElse: () => _removeSearchOverlay(),
            );
          },
          child: CompositedTransformTarget(
            link: _searchLayerLink,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  // Service Category Dropdown
                  serviceState.maybeWhen(
                    loaded: (services) {
                      return Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: selectedServiceId,
                            hint: const Text(
                              'Select Service',
                              style:
                                  TextStyle(fontSize: 13, fontFamily: 'Inter'),
                            ),
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontFamily: 'Inter',
                            ),
                            items: [
                              // "All Services" option
                              const DropdownMenuItem<int>(
                                value: -1,
                                child: Row(
                                  children: [
                                    Icon(Icons.apps,
                                        size: 14, color: Color(0xFF6132E4)),
                                    SizedBox(width: 6),
                                    Text(
                                      'All Services',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6132E4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Regular service options
                              ...services.map((service) {
                                return DropdownMenuItem<int>(
                                  value: service.id,
                                  child: Text(
                                    service.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }).toList(),
                            ],
                            onChanged: (id) {
                              if (id != null) {
                                setState(() => selectedServiceId = id);
                                _loadProductsForService(id);
                                serviceSearchController.clear();
                                _removeSearchOverlay();
                              }
                            },
                          ),
                        ),
                      );
                    },
                    orElse: () => const SizedBox(
                      width: 100,
                      height: 34,
                      child: Center(
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Search TextField
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: serviceSearchController,
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search products',
                          hintStyle: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Inter',
                            color: Color(0xFF8C8C8C),
                          ),
                          prefixIcon: Icon(Icons.search, size: 18),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
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
                      onPressed: _showProductFilterBottomSheet,
                      icon: Icon(
                        Icons.tune,
                        color: Colors.grey.shade700,
                        size: 20,
                      ),
                      tooltip: 'Filter',
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

  Widget _buildSelectedProductsSection() {
    return ValueListenableBuilder(
      valueListenable: widget.selectedProductsNotifier,
      builder: (context, selectedProducts, _) {
        if (selectedProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text(
                  'No products selected',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Search and select products above',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Item',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Quantity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Price',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Total',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Space for delete button
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Product list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: selectedProducts.length,
                itemBuilder: (context, index) {
                  final productModel = selectedProducts[index];
                  return _buildProductRow(productModel, index);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductRow(ProductSelectedModel productModel, int index) {
    final variant = productModel.variant;
    final total = productModel.amount * productModel.quantity;
    final availableQty =
        variant.stock ?? 999; // Default to high number if stock not provided
    final isLowStock = availableQty <= 3;
    final canEdit = !widget.formController.isReturnDateBeforeCurrentDate;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Item with image and name
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    // Product image
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: variant.image != null && variant.image!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                variant.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Icon(
                                  Icons.image,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            )
                          : Icon(Icons.image, color: Colors.grey.shade400),
                    ),
                    const SizedBox(width: 12),
                    // Product name and color
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            variant.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              fontFamily: 'Inter',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (variant.color != null)
                            Text(
                              variant.color!,
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

              // Quantity with variant badge and +/- controls
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Variant badge (circular)
                    if (variant.variantAttribute != null)
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0D4FF),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          variant.variantAttribute!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6132E4),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    if (variant.variantAttribute != null)
                      const SizedBox(width: 4),

                    // Decrease button
                    if (canEdit)
                      InkWell(
                        onTap: productModel.quantity > 1
                            ? () => _decrementQuantity(productModel)
                            : null,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: productModel.quantity > 1
                                ? Colors.grey.shade200
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 12,
                            color: productModel.quantity > 1
                                ? Colors.black87
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    if (canEdit) const SizedBox(width: 4),

                    // Quantity
                    Text(
                      '${productModel.quantity}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    if (canEdit) const SizedBox(width: 4),

                    // Increase button
                    if (canEdit)
                      InkWell(
                        onTap: productModel.quantity < availableQty
                            ? () => _incrementQuantity(productModel)
                            : null,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            color: productModel.quantity < availableQty
                                ? const Color(0xFF6132E4).withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 12,
                            color: productModel.quantity < availableQty
                                ? const Color(0xFF6132E4)
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Available quantity
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isLowStock
                          ? Colors.red.shade50
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$availableQty left',
                      style: TextStyle(
                        fontSize: 11,
                        color: isLowStock ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ),

              // Price
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '₹${productModel.amount}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),

              // Total
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    '₹${total.toString().replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},',
                        )}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),

              // Delete button
              SizedBox(
                width: 40,
                child: canEdit
                    ? IconButton(
                        onPressed: () => _removeProduct(productModel),
                        icon: const Icon(Icons.close, size: 18),
                        color: Colors.grey.shade500,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),

          // Customization section (if applicable)
          if (_buildCustomization(context, productModel) != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: _buildCustomization(context, productModel)!,
            ),
        ],
      ),
    );
  }

  void _incrementQuantity(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      final updatedProduct = product.copyWith(quantity: product.quantity + 1);
      products[index] = updatedProduct;
      widget.selectedProductsNotifier.value = products;
    }
  }

  void _decrementQuantity(ProductSelectedModel product) {
    if (product.quantity <= 1) return;

    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      final updatedProduct = product.copyWith(quantity: product.quantity - 1);
      products[index] = updatedProduct;
      widget.selectedProductsNotifier.value = products;
    }
  }
}

// Stateful widget for overlay search item with variant selection
class _ProductSearchItem extends StatefulWidget {
  final ProductModel product;
  final Function(ProductVariantModel) onAddProduct;

  const _ProductSearchItem({
    required this.product,
    required this.onAddProduct,
  });

  @override
  State<_ProductSearchItem> createState() => _ProductSearchItemState();
}

class _ProductSearchItemState extends State<_ProductSearchItem> {
  ProductVariantModel? selectedVariant;

  @override
  void initState() {
    super.initState();

    // For non-multi-variant products, auto-select the first variant
    // For multi-variant products (dress, costume, gadgets), user must explicitly select
    if (!widget.product.mainServiceType.isMultiVariantProductType &&
        widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    } else {
      selectedVariant = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final price = widget.product.price ?? 0;
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
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.color ?? 'Black',
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

          // Variants section - Flexible with horizontal scroll
          Expanded(
            child: SizedBox(
              height: 40,
              child: variants.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: variants.map((variant) {
                          final isSelected = selectedVariant?.id == variant.id;
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
          ),

          const SizedBox(width: 12),
          // Divider
          Container(
            width: 1,
            height: 30,
            color: const Color(0xFFA6A6A6),
          ),
          const SizedBox(width: 12),

          // Price section - Fixed width
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'rent price',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
                ),
                Text(
                  '₹$price',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          // Add button - Fixed width
          GestureDetector(
            onTap: () {
              // For multi-variant products, require explicit selection
              // For non-multi-variant products, use first variant automatically
              final variantToAdd = selectedVariant ??
                  (!widget.product.mainServiceType.isMultiVariantProductType &&
                          widget.product.variants.isNotEmpty
                      ? widget.product.variants.first
                      : null);

              if (variantToAdd != null) {
                widget.onAddProduct(variantToAdd);
              }
            },
            child: Container(
              width: 80,
              height: 36,
              decoration: BoxDecoration(
                color: (selectedVariant != null ||
                        !widget
                            .product.mainServiceType.isMultiVariantProductType)
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
          color: isSelected ? const Color(0xFFE0D4FF) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}
