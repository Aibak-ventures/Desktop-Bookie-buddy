import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/booking_product_helpers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/old_new_booking/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductListTableWidget extends StatefulWidget {
  final ValueNotifier<List<ProductSelectedEntity>> selectedProductsNotifier;
  final BookingType selectedBookingType;
  final int effectiveRentalDays;
  final int manualExtraRentalDays;
  final FocusNode clientNameFocusNode;
  final VoidCallback onIncrementRentalDays;
  final VoidCallback onDecrementRentalDays;
  /// When false, the Days column shows the count only (no +/− controls).
  final bool showDayControls;

  const ProductListTableWidget({
    super.key,
    required this.selectedProductsNotifier,
    required this.selectedBookingType,
    required this.effectiveRentalDays,
    required this.manualExtraRentalDays,
    required this.clientNameFocusNode,
    required this.onIncrementRentalDays,
    required this.onDecrementRentalDays,
    this.showDayControls = true,
  });

  @override
  State<ProductListTableWidget> createState() => _ProductListTableWidgetState();
}

class _ProductListTableWidgetState extends State<ProductListTableWidget> {
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();
  final Map<int, TextEditingController> _quantityControllers = {};
  final Map<int, FocusNode> _quantityFocusNodes = {};

  @override
  void dispose() {
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _quantityFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProductListHeader(),
        Expanded(child: _buildSelectedProductsList()),
      ],
    );
  }

  Widget _buildProductListHeader() {
    final isSales = widget.selectedBookingType == BookingType.sales;
    final isOldBooking = widget.selectedBookingType == BookingType.oldBooking;
    final hasVariants = _hasAnyProductWithVariants();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 3, child: _buildHeaderCell('items', alignLeft: true)),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: _buildHeaderCell('Specifications')),
          const SizedBox(width: 4),
          if (hasVariants) ...[
            Expanded(child: _buildHeaderCell('Variants')),
            const SizedBox(width: 4),
          ],
          if (!isOldBooking) ...[
            Expanded(child: _buildHeaderCell('Available')),
            const SizedBox(width: 4),
          ],
          Expanded(child: _buildHeaderCell('Quantity')),
          const SizedBox(width: 4),
          if (!isSales) ...[
            Expanded(child: _buildHeaderCell('Days')),
            const SizedBox(width: 4),
          ],
          Expanded(child: _buildHeaderCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(child: _buildHeaderCell('Total')),
          const SizedBox(width: 50), // Matches row close button area
        ],
      ),
    );
  }

  bool _hasAnyProductWithVariants() {
    final products = widget.selectedProductsNotifier.value;
    return products.any((product) {
      final mainServiceType = product.variant.mainServiceType;
      return mainServiceType.isMultiVariantProductType &&
          (product.variant.variantAttribute?.isNotEmpty ?? false);
    });
  }

  Widget _buildHeaderCell(String title, {bool alignLeft = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
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
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3436),
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSelectedProductsList() {
    return ValueListenableBuilder<List<ProductSelectedEntity>>(
      valueListenable: widget.selectedProductsNotifier,
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
          itemCount: products.length,
          itemBuilder: (context, index) => _buildProductRow(products[index]),
        );
      },
    );
  }

  bool _shouldMultiplyByDays(MainServiceType? serviceType) {
    return PaymentCalculator.shouldMultiplyByDays(serviceType);
  }

  Widget _buildProductRow(ProductSelectedEntity product) {
    final isSales = widget.selectedBookingType == BookingType.sales;
    final isOldBooking = widget.selectedBookingType == BookingType.oldBooking;
    final rentalDays = !isSales ? widget.effectiveRentalDays : 0;
    final imageUrl = product.variant.thumbnailImage ?? product.variant.image;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    final effectiveDaysMultiplier =
        (!isSales && _shouldMultiplyByDays(product.variant.mainServiceType))
        ? (rentalDays > 0 ? rentalDays : 1)
        : 1;
    final hasVariants = _hasAnyProductWithVariants();

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
                MouseRegion(
                  cursor: hasImage
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  child: GestureDetector(
                    onTap: hasImage
                        ? () => ZoomableImageDialog.show(
                            context,
                            imageUrl: imageUrl,
                            title: product.variant.name,
                          )
                        : null,
                    child: Container(
                      width: 48,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade200),
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: !hasImage
                          ? const Icon(
                              Icons.image_not_supported,
                              size: 20,
                              color: Colors.grey,
                            )
                          : Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                margin: const EdgeInsets.all(3),
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.zoom_in,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
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
          // Available Badge
          if (!isOldBooking) ...[
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1C1FD300),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF27AE60),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${product.variant.remainingStock ?? product.variant.stock} left',
                        style: const TextStyle(
                          fontSize: 12,
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
          ],
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
                  width: 25,
                  height: 20,
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
                      !isOldBooking &&
                      product.quantity >=
                          (product.variant.remainingStock ??
                              product.variant.stock ??
                              999),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Days column (only for bookings/custom/old booking)
          if (!isSales) ...[
            Expanded(
              child: widget.showDayControls
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildQuantityBtn(
                          icon: Icons.remove,
                          onTap: widget.onDecrementRentalDays,
                          isDisabled: widget.manualExtraRentalDays == 0,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$rentalDays',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),
                        _buildQuantityBtn(
                          icon: Icons.add,
                          onTap: widget.onIncrementRentalDays,
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        '$rentalDays',
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
          // Price / item
          Expanded(
            child: _editingVariantId == product.variant.variantId
                ? Center(
                    child: SizedBox(
                      width: 80,
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
                    onTap: () => _startEditingPrice(product),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.amount}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2D3436),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: Color(0xFF6132E4),
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
                  fontWeight: FontWeight.w700,
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
        width: compact ? 20 : 18,
        height: compact ? 20 : 18,
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey.shade300
              : const Color(0xFFF3F0FF),
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

  void _focusNextProductRowOrClient(ProductSelectedEntity product) {
    final products = widget.selectedProductsNotifier.value;
    final currentIndex = products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (currentIndex != -1 && currentIndex + 1 < products.length) {
      final nextProduct = products[currentIndex + 1];
      _getQuantityFocusNode(_quantityKey(nextProduct)).requestFocus();
      return;
    }
    widget.clientNameFocusNode.requestFocus();
  }

  void _incrementQuantity(ProductSelectedEntity product) {
    final updatedProducts = SelectedProductsManager.incrementQuantity(
      currentProducts: widget.selectedProductsNotifier.value,
      product: product,
      bookingType: widget.selectedBookingType,
    );
    if (identical(updatedProducts, widget.selectedProductsNotifier.value)) {
      return;
    }

    widget.selectedProductsNotifier.value = updatedProducts;
    final index = updatedProducts.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index != -1) {
      _quantityControllers[_quantityKey(product)]?.text =
          updatedProducts[index].quantity.toString();
    }
  }

  void _decrementQuantity(ProductSelectedEntity product) {
    final currentProducts = widget.selectedProductsNotifier.value;
    final updatedProducts = SelectedProductsManager.decrementQuantity(
      currentProducts: currentProducts,
      product: product,
    );
    if (identical(updatedProducts, currentProducts)) return;

    final removedItem = updatedProducts.length < currentProducts.length &&
        !updatedProducts.any(
          (item) =>
              BookingProductHelpers.productKey(item) ==
              BookingProductHelpers.productKey(product),
        );
    if (removedItem) {
      _quantityControllers.remove(_quantityKey(product))?.dispose();
      _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
    } else {
      final index = updatedProducts.indexWhere(
        (item) =>
            BookingProductHelpers.productKey(item) ==
            BookingProductHelpers.productKey(product),
      );
      if (index != -1) {
        _quantityControllers[_quantityKey(product)]?.text =
            updatedProducts[index].quantity.toString();
      }
    }
    widget.selectedProductsNotifier.value = updatedProducts;
  }

  void _saveTypedQuantity(ProductSelectedEntity product, String value) {
    final parsedQuantity = int.tryParse(value.trim());

    if (parsedQuantity == null || parsedQuantity <= 0) {
      _quantityControllers[_quantityKey(product)]?.text =
          product.quantity.toString();
      context.showSnackBar('Quantity must be greater than 0', isError: true);
      return;
    }

    final result = SelectedProductsManager.setQuantity(
      currentProducts: widget.selectedProductsNotifier.value,
      product: product,
      quantity: parsedQuantity,
      bookingType: widget.selectedBookingType,
    );

    if (result.hasError) {
      _quantityControllers[_quantityKey(product)]?.text =
          product.quantity.toString();
      context.showSnackBar(result.errorMessage!, isError: true);
      return;
    }

    _quantityControllers[_quantityKey(product)]?.text =
        parsedQuantity.toString();
    widget.selectedProductsNotifier.value = result.products;
    _quantityFocusNodes[_quantityKey(product)]?.unfocus();
    final updatedIndex = result.products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (updatedIndex != -1) {
      _focusNextProductRowOrClient(result.products[updatedIndex]);
    }
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

    _updateProductPrice(product, newPrice);

    setState(() {
      _editingVariantId = null;
      _inlinePriceController.clear();
      _inlinePriceFocusNode.unfocus();
    });
    _focusNextProductRowOrClient(product);
  }

  void _removeProduct(ProductSelectedEntity product) {
    final products = widget.selectedProductsNotifier.value;
    _quantityControllers.remove(_quantityKey(product))?.dispose();
    _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
    widget.selectedProductsNotifier.value = SelectedProductsManager.removeProduct(
      currentProducts: products,
      product: product,
    );
  }

  void _updateProductPrice(ProductSelectedEntity product, int newPrice) {
    widget.selectedProductsNotifier.value =
        SelectedProductsManager.updateProductPrice(
      currentProducts: widget.selectedProductsNotifier.value,
      product: product,
      newPrice: newPrice,
    );
  }

  String _getVariantDisplayText(ProductSelectedEntity product) {
    final mainServiceType = product.variant.mainServiceType;
    if (mainServiceType.isMultiVariantProductType) {
      return product.variant.variantAttribute?.isNotEmpty ?? false
          ? product.variant.variantAttribute!
          : '-';
    }
    return '';
  }

  String _getProductSpecifications(ProductSelectedEntity product) {
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
}
