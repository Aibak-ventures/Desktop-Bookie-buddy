import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
// import 'package:bookie_buddy_web/core/ui/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_search_type_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/new_booking/view/new_booking_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingProductSelectionSection extends StatefulWidget {
  final SelectProductBloc selectProductBloc;
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final BookingType bookingType;
  final DateTime pickupDate;
  final DateTime returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;

  const BookingProductSelectionSection({
    super.key,
    required this.selectProductBloc,
    required this.selectedProductsNotifier,
    required this.bookingType,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupTime,
    required this.returnTime,
  });

  @override
  State<BookingProductSelectionSection> createState() =>
      _BookingProductSelectionSectionState();
}

class _BookingProductSelectionSectionState
    extends State<BookingProductSelectionSection> {
  final serviceSearchController = TextEditingController();
  final LayerLink _searchLayerLink = LayerLink();
  OverlayEntry? _searchOverlayEntry;

  // Search filter state
  final _searchTypes = ['Name', 'Category', 'Model', 'Color'];
  final _selectedSearchTypeIndex = ValueNotifier<int>(0);
  final _priceRange = ValueNotifier<RangeValues>(const RangeValues(0, 50000));
  final _maxPriceNotifier = ValueNotifier<double>(50000);
  final _isPriceFilterEnabled = ValueNotifier<bool>(false);

  int? selectedServiceId = -1;

  @override
  void dispose() {
    serviceSearchController.dispose();
    _removeSearchOverlay();
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
              Text('  Selected Products',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800)),
            ],
          ),
          _buildProductSearchBar(),
          const SizedBox(height: 6),
          Expanded(child: _buildSelectedProductsTable()),
        ],
      ),
    );
  }

  Widget _buildProductSearchBar() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocListener<SelectProductBloc, SelectProductState>(
          bloc: widget.selectProductBloc,
          listener: (context, state) {
            state.maybeWhen(
              loaded: (products, p1, p2, p3, p4, p5, isSearching, p7, p8, p9,
                  p10, p11, p12, p13, p14) {
                final hasSearchText = serviceSearchController.text.isNotEmpty;
                final hasFilters = _isPriceFilterEnabled.value ||
                    _selectedSearchTypeIndex.value != 0;

                if (hasSearchText ||
                    hasFilters ||
                    (products.isNotEmpty && isSearching)) {
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

  void _onSearchChanged() {
    final query = serviceSearchController.text.trim();
    final isSales = widget.bookingType == BookingType.sales;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
            ? null
            : selectedServiceId;

    final hasFilters =
        _isPriceFilterEnabled.value || _selectedSearchTypeIndex.value != 0;

    if (query.isEmpty && !hasFilters) {
      widget.selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          // ignore: deprecated_member_use
          pickupDate: widget.pickupDate
              .toIso8601String(), // Using provided ext format logic if available or ISO
          // I will use widget.pickupDate.format() if I can access the extension?
          // I need to import extensions.
          returnDate: widget.returnDate.toIso8601String(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
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

      widget.selectProductBloc.add(
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
          pickupDate: widget.pickupDate.toIso8601String(),
          returnDate: widget.returnDate.toIso8601String(),
          pickupTime: widget.pickupTime,
          returnTime: widget.returnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    }
  }

  void _showProductFilterBottomSheet() {
    final serviceState = context.read<ServiceBloc>().state;
    final services = serviceState.maybeWhen(
        loaded: (s) => s, orElse: () => <ServicesModel>[]);
    final selectedServiceIdNotifier =
        ValueNotifier<int>(selectedServiceId ?? -1);

    final currentProducts = widget.selectProductBloc.state.maybeWhen(
      loaded: (products,
              _,
              __,
              ___,
              ____,
              _____,
              _______,
              ________,
              _________,
              __________,
              ___________,
              ____________,
              _____________,
              ______________,
              _______________) =>
          products,
      orElse: () => <ProductModel>[],
    );

    if (currentProducts.isNotEmpty) {
      double maxProductPrice = 0;
      for (final product in currentProducts) {
        final productPrice = product.price ?? 0;
        if (productPrice > maxProductPrice)
          maxProductPrice = productPrice.toDouble();
        for (final variant in product.variants) {
          final variantPrice = variant.price ?? 0;
          if (variantPrice > maxProductPrice)
            maxProductPrice = variantPrice.toDouble();
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
      onTap: (type, index) => _selectedSearchTypeIndex.value = index,
      priceRange: _priceRange,
      minPrice: 0,
      maxPriceNotifier: _maxPriceNotifier,
      onPriceChanged: (range) => _priceRange.value = range,
      isPriceFilterEnabledNotifier: _isPriceFilterEnabled,
      onApply: (typeIndex, range, isPriceEnabled) {
        setState(() {
          selectedServiceId = selectedServiceIdNotifier.value;
        });
        _onSearchChanged(); // Re-trigger search with new filters
      },
      services: services,
      selectedServiceIdNotifier: selectedServiceIdNotifier,
    );
  }

  void _showSearchOverlay(List<ProductModel> products) {
    _removeSearchOverlay();
    _searchOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width:
            400, // Fixed width for overlay? Or dynamic? In original code it was dynamic based on MediaQuery
        // Width: MediaQuery.of(context).size.width * 0.60 - 24
        // Since we are in a widget, maybe we use CompositedTransformFollower constraints or fixed
        // I'll use a fixed reasonable width or match the text field.
        // Actually, let's use the width of the target if possible, but the search bar is flexible.
        // I will use a reasonable fixed width for now or try to match text field.
        // width: 500, // Approximate width
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
                  products.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("No products"))
                      : Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            itemCount: products.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: Colors.grey.shade200,
                            ),
                            itemBuilder: (_, i) =>
                                _buildOverlaySearchItem(products[i]),
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

  Widget _buildOverlaySearchItem(ProductModel product) {
    // Basic Item Listing
    return ListTile(
      leading: SizedBox(
        width: 40,
        height: 40,
        child: product.image != null
            ? Image.network(product.image!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.error))
            : const Icon(Icons.image),
      ),
      title: Text(product.name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      subtitle: Text("Price: ₹${product.price}",
          style: const TextStyle(fontSize: 11)),
      trailing: ElevatedButton(
        onPressed: () {
          _removeSearchOverlay();
          serviceSearchController.clear();
          _showVariantSelectionDialog(product);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            minimumSize: const Size(60, 30),
            padding: EdgeInsets.zero),
        child: const Text("Add",
            style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  Widget _buildSelectedProductsTable() {
    return Column(
      children: [
        _buildProductListHeader(),
        Expanded(
          child: ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: widget.selectedProductsNotifier,
            builder: (context, products, _) {
              if (products.isEmpty) {
                return const Center(child: Text("No items selected"));
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 4),
                itemCount: products.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) =>
                    _buildProductRow(products[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductListHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text('Items', style: _headerStyle)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: Text('Price', style: _headerStyle)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: Text('Quantity', style: _headerStyle)),
          const SizedBox(width: 4),
          Expanded(flex: 2, child: Text('Total', style: _headerStyle)),
          const SizedBox(width: 30),
        ],
      ),
    );
  }

  TextStyle get _headerStyle => const TextStyle(
      fontSize: 13,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
      color: Colors.black87);

  Widget _buildProductRow(ProductSelectedModel product) {
    final total = product.amount * product.quantity;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: product.variant.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            product.variant.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_outlined, size: 20),
                          ),
                        )
                      : const Icon(Icons.image_outlined, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.variant.name,
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('${product.variant.variantAttribute}',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            // Inline Price Editing
            child: TextFormField(
              initialValue: product.amount.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  isDense: true, border: InputBorder.none, prefixText: '₹'),
              style: const TextStyle(fontSize: 13),
              onFieldSubmitted: (val) {
                final newPrice = int.tryParse(val) ?? product.amount;
                _updateProductPrice(product, newPrice);
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => _decrementQuantity(product),
                    child: const Icon(Icons.remove_circle_outline, size: 16)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('${product.quantity}',
                      style: const TextStyle(fontSize: 13)),
                ),
                InkWell(
                    onTap: () => _incrementQuantity(product),
                    child: const Icon(Icons.add_circle_outline, size: 16)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(total.toCurrency(),
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
          IconButton(
            onPressed: () => _removeProduct(product),
            icon: const Icon(Icons.close, size: 18),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  void _showVariantSelectionDialog(ProductModel product) {
    final variants = product.variants;
    if (variants.isEmpty) {
      context.showSnackBar('No variants available', isError: true);
      return;
    }
    final selectedVariants = widget.selectedProductsNotifier.value;
    showSizeAmountDialog(
        context: context,
        isSales: widget.bookingType == BookingType.sales,
        alreadySelectedVariants: selectedVariants,
        mainServiceType: product.mainServiceType ?? MainServiceType.other,
        productImageUrl: product.image ?? '',
        availableVariants: variants,
        initialAmount: null,
        initialQuantity: null,
        onConfirm: (id, size, amount, quantity) {
          final attribute = size ??
              (variants.first.attribute.isEmpty
                  ? product.model
                  : variants.first.attribute);
          final products = List<ProductSelectedModel>.from(
              widget.selectedProductsNotifier.value);
          final existingIndex =
              products.indexWhere((p) => p.variant.variantId == id);

          if (existingIndex != -1) {
            final existing = products[existingIndex];
            products[existingIndex] =
                existing.copyWith(quantity: existing.quantity + quantity);
          } else {
            products.add(ProductSelectedModel(
                variant: ProductInfoModel(
                    id: id,
                    variantId: id,
                    productId: product.id,
                    name: product.name,
                    image: product.image,
                    amount: amount.toInt(),
                    category: product.category,
                    color: product.color,
                    model: product.model,
                    mainServiceType: product.mainServiceType,
                    variantAttribute: attribute,
                    measurements: [],
                    quantity: quantity),
                quantity: quantity,
                amount: amount.toInt()));
          }
          widget.selectedProductsNotifier.value = products;
        });
  }

  void _updateProductPrice(ProductSelectedModel product, int newPrice) {
    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      widget.selectedProductsNotifier.value = products;
    }
  }

  void _incrementQuantity(ProductSelectedModel product) {
    if (product.quantity >= product.variant.quantity) {
      context.showSnackBar('Max stock reached', isError: true);
      return;
    }
    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      products[index] =
          products[index].copyWith(quantity: products[index].quantity + 1);
      widget.selectedProductsNotifier.value = products;
    }
  }

  void _decrementQuantity(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    final index = products
        .indexWhere((p) => p.variant.variantId == product.variant.variantId);
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index] =
            products[index].copyWith(quantity: products[index].quantity - 1);
      } else {
        products.removeAt(index);
      }
      widget.selectedProductsNotifier.value = products;
    }
  }

  void _removeProduct(ProductSelectedModel product) {
    final products =
        List<ProductSelectedModel>.from(widget.selectedProductsNotifier.value);
    products
        .removeWhere((p) => p.variant.variantId == product.variant.variantId);
    widget.selectedProductsNotifier.value = products;
  }
}
