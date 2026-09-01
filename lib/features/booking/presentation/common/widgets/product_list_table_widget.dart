import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_helpers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/payment_calculator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/selected_products_manager.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
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

  /// When set to a product key, auto-focuses that product's quantity field.
  final ValueNotifier<int?>? focusTargetProductKey;

  /// Called when navigation reaches the end of the product list.
  final VoidCallback? onNavigateToClientDetails;

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
    this.focusTargetProductKey,
    this.onNavigateToClientDetails,
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

  /// Row-level focus nodes for keyboard navigation
  final Map<int, FocusNode> _rowFocusNodes = {};

  /// Element focus nodes for each product row: [qtyMinus, qtyPlus, daysMinus, daysPlus, price]
  final Map<int, List<FocusNode>> _rowElementFocusNodes = {};

  /// Tracks active sub-element index within a row: 0=qtyMinus, 1=qtyInput, 2=qtyPlus, 3=daysMinus, 4=daysPlus, 5=price
  final Map<int, int> _rowActiveElement = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.focusTargetProductKey?.addListener(_onFocusTargetChanged);
  }

  @override
  void dispose() {
    widget.focusTargetProductKey?.removeListener(_onFocusTargetChanged);
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    for (final controller in _quantityControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _quantityFocusNodes.values) {
      focusNode.dispose();
    }
    for (final node in _rowFocusNodes.values) node.dispose();
    for (final nodes in _rowElementFocusNodes.values) {
      for (final node in nodes) node.dispose();
    }
    _scrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  void _onFocusTargetChanged() {
    final targetKey = widget.focusTargetProductKey?.value;
    if (targetKey == null) return;
    final products = widget.selectedProductsNotifier.value;
    final index = products.indexWhere((p) => _quantityKey(p) == targetKey);
    if (index == -1) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _rowActiveElement[targetKey] = 1;
      _getQuantityFocusNode(targetKey).requestFocus();
    });
    // Also scroll to the target product
    final targetProduct = widget.selectedProductsNotifier.value
        .where((p) => _quantityKey(p) == targetKey)
        .firstOrNull;
    if (targetProduct != null) {
      _scrollToProduct(targetProduct);
    }
    widget.focusTargetProductKey?.value = null;
  }

  /// Minimum width the table needs to lay out its columns without
  /// overflowing. Below this, the table scrolls horizontally instead of
  /// squeezing its columns.
  static const double _minTableWidth = 1000;
  final ScrollController _horizontalScrollController = ScrollController();

  /// Column flex ratios, shared between the header and every data row so
  /// cells stay aligned. `_flexColumn` is the "standard" column width;
  /// `_flexSlNo` is deliberately half of it since Sl. No. only ever needs
  /// to fit a couple of digits.
  static const int _flexSlNo = 1;
  static const int _flexColumn = 2;
  static const int _flexItems = 6;
  static const int _flexSpecifications = 4;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth < _minTableWidth
            ? _minTableWidth
            : constraints.maxWidth;
        return Scrollbar(
          controller: _horizontalScrollController,
          child: SingleChildScrollView(
            controller: _horizontalScrollController,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: tableWidth,
              height: constraints.maxHeight,
              child: Column(
                children: [
                  _buildProductListHeader(),
                  Expanded(child: _buildSelectedProductsList()),
                ],
              ),
            ),
          ),
        );
      },
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
          Expanded(flex: _flexSlNo, child: _buildHeaderCell('Sl. No.')),
          const SizedBox(width: 4),
          Expanded(
            flex: _flexItems,
            child: _buildHeaderCell('items', alignLeft: true),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: _flexSpecifications,
            child: _buildHeaderCell('Specifications'),
          ),
          const SizedBox(width: 4),
          if (hasVariants) ...[
            Expanded(flex: _flexColumn, child: _buildHeaderCell('Variants')),
            const SizedBox(width: 4),
          ],
          if (!isOldBooking) ...[
            Expanded(flex: _flexColumn, child: _buildHeaderCell('Available')),
            const SizedBox(width: 4),
          ],
          Expanded(flex: _flexColumn, child: _buildHeaderCell('Quantity')),
          const SizedBox(width: 4),
          if (!isSales) ...[
            Expanded(flex: _flexColumn, child: _buildHeaderCell('Days')),
            const SizedBox(width: 4),
          ],
          Expanded(flex: _flexColumn, child: _buildHeaderCell('Price / item')),
          const SizedBox(width: 4),
          Expanded(flex: _flexColumn, child: _buildHeaderCell('Total')),
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
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: products.length,
          itemBuilder: (context, index) =>
              _buildProductRow(products[index], index + 1),
        );
      },
    );
  }

  Widget _buildProductRow(ProductSelectedEntity product, int serialNumber) {
    final isSales = widget.selectedBookingType == BookingType.sales;
    final isOldBooking = widget.selectedBookingType == BookingType.oldBooking;
    final rentalDays = !isSales ? widget.effectiveRentalDays : 0;
    final imageUrl = product.variant.thumbnailImage ?? product.variant.productImage;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;
    // On click open the original (OG) image, not the thumbnail.
    final fullImageUrl =
        product.variant.productImage ?? product.variant.thumbnailImage;
    final effectiveDaysMultiplier =
        PaymentCalculator.getDaysMultiplierForProduct(
          bookingType: widget.selectedBookingType,
          effectiveRentalDays: rentalDays,
          product: product,
        );

    final hasVariants = _hasAnyProductWithVariants();
    final productKey = _quantityKey(product);

    return Focus(
      focusNode: _getRowFocusNode(productKey),
      onKeyEvent: (_, event) => _handleRowKeyEvent(product, event),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            // Serial number
            Expanded(
              flex: _flexSlNo,
              child: Text(
                '$serialNumber',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 4),
            // Item Name & Image
            Expanded(
              flex: _flexItems,
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
                              imageUrl: fullImageUrl ?? imageUrl,
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
              flex: _flexSpecifications,
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
                flex: _flexColumn,
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
                flex: _flexColumn,
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
                          product.variant.remainingStock != null
                              ? '${product.variant.remainingStock} left'
                              : product.variant.stock != null
                              ? '${product.variant.stock} left'
                              : '-',
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
              flex: _flexColumn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Focus(
                    focusNode: _getRowElementFocusNode(productKey, 0),
                    onKeyEvent: (_, event) {
                      if (event is KeyDownEvent &&
                          (event.logicalKey == LogicalKeyboardKey.enter ||
                              event.logicalKey ==
                                  LogicalKeyboardKey.numpadEnter)) {
                        _decrementQuantity(product);
                        return KeyEventResult.handled;
                      }
                      return KeyEventResult.ignored;
                    },
                    child: _buildQuantityBtn(
                      icon: Icons.remove,
                      onTap: () => _decrementQuantity(product),
                      compact: true,
                    ),
                  ),
                  const SizedBox(width: 3),
                  SizedBox(
                    width: 25,
                    height: 20,
                    child: TextField(
                      controller: _getQuantityController(product),
                      focusNode: _getQuantityFocusNode(productKey),
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
                          borderSide: const BorderSide(
                            color: Color(0xFF6132E4),
                          ),
                        ),
                      ),
                      onSubmitted: (value) => _saveTypedQuantity(
                        product,
                        value,
                        advanceToPrice: true,
                      ),
                      onTapOutside: (_) => _saveTypedQuantity(
                        product,
                        _getQuantityController(product).text,
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Focus(
                    focusNode: _getRowElementFocusNode(productKey, 1),
                    onKeyEvent: (_, event) {
                      if (event is KeyDownEvent &&
                          (event.logicalKey == LogicalKeyboardKey.enter ||
                              event.logicalKey ==
                                  LogicalKeyboardKey.numpadEnter)) {
                        _incrementQuantity(product);
                        return KeyEventResult.handled;
                      }
                      return KeyEventResult.ignored;
                    },
                    child: _buildQuantityBtn(
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
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            // Days column (only for bookings/custom/old booking)
            if (!isSales) ...[
              Expanded(
                flex: _flexColumn,
                child: widget.showDayControls
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Focus(
                            focusNode: _getRowElementFocusNode(productKey, 2),
                            onKeyEvent: (_, event) {
                              if (event is KeyDownEvent &&
                                  (event.logicalKey ==
                                          LogicalKeyboardKey.enter ||
                                      event.logicalKey ==
                                          LogicalKeyboardKey.numpadEnter)) {
                                widget.onDecrementRentalDays();
                                return KeyEventResult.handled;
                              }
                              return KeyEventResult.ignored;
                            },
                            child: _buildQuantityBtn(
                              icon: Icons.remove,
                              onTap: widget.onDecrementRentalDays,
                              isDisabled: widget.manualExtraRentalDays == 0,
                            ),
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
                          Focus(
                            focusNode: _getRowElementFocusNode(productKey, 3),
                            onKeyEvent: (_, event) {
                              if (event is KeyDownEvent &&
                                  (event.logicalKey ==
                                          LogicalKeyboardKey.enter ||
                                      event.logicalKey ==
                                          LogicalKeyboardKey.numpadEnter)) {
                                widget.onIncrementRentalDays();
                                return KeyEventResult.handled;
                              }
                              return KeyEventResult.ignored;
                            },
                            child: _buildQuantityBtn(
                              icon: Icons.add,
                              onTap: widget.onIncrementRentalDays,
                            ),
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
              flex: _flexColumn,
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
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
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
                  : Focus(
                      focusNode: _getRowElementFocusNode(productKey, 4),
                      onKeyEvent: (_, event) {
                        if (event is KeyDownEvent &&
                            (event.logicalKey == LogicalKeyboardKey.enter ||
                                event.logicalKey ==
                                    LogicalKeyboardKey.numpadEnter)) {
                          _startEditingPrice(product);
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: GestureDetector(
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
            ),
            const SizedBox(width: 4),
            // Total
            Expanded(
              flex: _flexColumn,
              child: Center(
                child: Text(
                  ((product.amount * product.quantity) *
                          effectiveDaysMultiplier)
                      .toCurrency(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3436),
                  ),
                ),
              ),
            ),
            // Remove — replaced by a badge once the item has been returned
            SizedBox(
              width: 50,
              child: _isReturned(product)
                  ? const Tooltip(
                      message: 'Returned items can no longer be edited',
                      child: Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Colors.green,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black87,
                      ),
                      onPressed: () => _removeProduct(product),
                    ),
            ),
          ],
        ),
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
          color: isDisabled ? Colors.grey.shade300 : const Color(0xFFF3F0FF),
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
    return product.variant.id;
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
      final nextKey = _quantityKey(nextProduct);
      _rowActiveElement[nextKey] = 0;
      _getRowElementFocusNode(nextKey, 0).requestFocus();
      _scrollToProduct(nextProduct);
      return;
    }
    widget.onNavigateToClientDetails?.call();
  }

  FocusNode _getRowFocusNode(int productKey) {
    return _rowFocusNodes.putIfAbsent(productKey, FocusNode.new);
  }

  FocusNode _getRowElementFocusNode(int productKey, int elementIndex) {
    final nodes = _rowElementFocusNodes.putIfAbsent(
      productKey,
      () => List.generate(5, (_) => FocusNode()),
    );
    return nodes[elementIndex];
  }

  void _scrollToProduct(ProductSelectedEntity product) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final key = _quantityKey(product);
      final context = _rowFocusNodes[key]?.context;
      if (context != null && context.mounted) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          alignment: 0.15,
        );
      }
    });
  }

  void _focusElementInRow(ProductSelectedEntity product, int elementIndex) {
    final key = _quantityKey(product);
    _rowActiveElement[key] = elementIndex;
    switch (elementIndex) {
      case 0:
        _getRowElementFocusNode(key, 0).requestFocus();
      case 1:
        _getQuantityFocusNode(key).requestFocus();
      case 2:
        _getRowElementFocusNode(key, 1).requestFocus();
      case 3:
        _getRowElementFocusNode(key, 2).requestFocus();
      case 4:
        _getRowElementFocusNode(key, 3).requestFocus();
      case 5:
        _startEditingPrice(product);
    }
    _scrollToProduct(product);
  }

  void _focusPrevProductRow(ProductSelectedEntity product) {
    final products = widget.selectedProductsNotifier.value;
    final key = _quantityKey(product);
    final currentIndex = products.indexWhere(
      (item) => _quantityKey(item) == key,
    );
    if (currentIndex > 0) {
      final prev = products[currentIndex - 1];
      final active = _rowActiveElement[key] ?? 1;
      _focusElementInRow(prev, active.clamp(0, 5));
    }
  }

  void _focusNextProductRow(ProductSelectedEntity product) {
    final products = widget.selectedProductsNotifier.value;
    final key = _quantityKey(product);
    final currentIndex = products.indexWhere(
      (item) => _quantityKey(item) == key,
    );
    if (currentIndex != -1 && currentIndex + 1 < products.length) {
      final next = products[currentIndex + 1];
      final active = _rowActiveElement[key] ?? 1;
      _focusElementInRow(next, active.clamp(0, 5));
      return;
    }
    widget.onNavigateToClientDetails?.call();
  }

  /// Element ids that can actually receive focus in a row, in visual
  /// left-to-right order. The days controls (3 = minus, 4 = plus) only exist
  /// for bookings when [ProductListTableWidget.showDayControls] is true — on the
  /// edit screen and for sales they're absent, so left/right navigation must
  /// skip them instead of focusing a node that isn't in the tree.
  /// Ids: 0 qtyMinus, 1 qtyInput, 2 qtyPlus, 3 daysMinus, 4 daysPlus, 5 price.
  List<int> _navigableElements() {
    final isSales = widget.selectedBookingType == BookingType.sales;
    final hasDays = !isSales && widget.showDayControls;
    return [0, 1, 2, if (hasDays) 3, if (hasDays) 4, 5];
  }

  KeyEventResult _handleRowKeyEvent(
    ProductSelectedEntity product,
    KeyEvent event,
  ) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = _quantityKey(product);
    final products = widget.selectedProductsNotifier.value;
    final currentIndex = products.indexWhere(
      (item) => _quantityKey(item) == key,
    );

    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
        event.logicalKey == LogicalKeyboardKey.numpad6) {
      final elements = _navigableElements();
      final idx = elements.indexOf(_rowActiveElement[key] ?? 1);
      if (idx != -1 && idx + 1 < elements.length) {
        _focusElementInRow(product, elements[idx + 1]);
      } else if (currentIndex != -1 && currentIndex + 1 < products.length) {
        _focusElementInRow(products[currentIndex + 1], elements.first);
      } else {
        widget.onNavigateToClientDetails?.call();
      }
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
        event.logicalKey == LogicalKeyboardKey.numpad4) {
      final elements = _navigableElements();
      final idx = elements.indexOf(_rowActiveElement[key] ?? 1);
      if (idx > 0) {
        _focusElementInRow(product, elements[idx - 1]);
      } else if (currentIndex > 0) {
        _focusElementInRow(products[currentIndex - 1], elements.last);
      } else {
        // Stay at the first element of first row
        _focusElementInRow(product, elements.first);
      }
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.numpad2) {
      // On the quantity input or the days stepper, Up/Down adjust the value
      // (Up = increase, Down = decrease) instead of moving between rows.
      final active = _rowActiveElement[key] ?? 1;
      if (active == 1) {
        _decrementQuantity(product);
        return KeyEventResult.handled;
      }
      if (active == 3 || active == 4) {
        widget.onDecrementRentalDays();
        return KeyEventResult.handled;
      }
      _focusNextProductRow(product);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.numpad8) {
      final active = _rowActiveElement[key] ?? 1;
      if (active == 1) {
        _incrementQuantity(product);
        return KeyEventResult.handled;
      }
      if (active == 3 || active == 4) {
        widget.onIncrementRentalDays();
        return KeyEventResult.handled;
      }
      _focusPrevProductRow(product);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  void _incrementQuantity(ProductSelectedEntity product) {
    // An item that already came back is settled — it can't be
    // re-priced, re-counted or dropped from the booking.
    if (_isReturned(product)) return;
    final updatedProducts = SelectedProductsManager.incrementQuantity(
      currentProducts: widget.selectedProductsNotifier.value,
      product: product,
      bookingType: widget.selectedBookingType,
    );
    if (identical(updatedProducts, widget.selectedProductsNotifier.value)) {
      // Increment was blocked (out of / exceeds available stock) — tell the user
      // instead of silently doing nothing.
      final availableStock =
          product.variant.remainingStock ?? product.variant.stock ?? 0;
      context.showSnackBar(
        'Cannot add more. Available stock: $availableStock',
        isError: true,
      );
      return;
    }

    widget.selectedProductsNotifier.value = updatedProducts;
    final index = updatedProducts.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (index != -1) {
      _quantityControllers[_quantityKey(product)]?.text = updatedProducts[index]
          .quantity
          .toString();
    }
  }

  void _decrementQuantity(ProductSelectedEntity product) {
    // An item that already came back is settled — it can't be
    // re-priced, re-counted or dropped from the booking.
    if (_isReturned(product)) return;
    final currentProducts = widget.selectedProductsNotifier.value;
    final updatedProducts = SelectedProductsManager.decrementQuantity(
      currentProducts: currentProducts,
      product: product,
    );
    if (identical(updatedProducts, currentProducts)) return;

    final removedItem =
        updatedProducts.length < currentProducts.length &&
        !updatedProducts.any(
          (item) =>
              BookingProductHelpers.productKey(item) ==
              BookingProductHelpers.productKey(product),
        );
    if (removedItem) {
      _quantityControllers.remove(_quantityKey(product))?.dispose();
      _quantityFocusNodes.remove(_quantityKey(product))?.dispose();
      _removeRowFocusNodes(_quantityKey(product));
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

  void _saveTypedQuantity(
    ProductSelectedEntity product,
    String value, {
    bool advanceToPrice = false,
  }) {
    final parsedQuantity = int.tryParse(value.trim());

    if (parsedQuantity == null || parsedQuantity <= 0) {
      _quantityControllers[_quantityKey(product)]?.text = product.quantity
          .toString();
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
      _quantityControllers[_quantityKey(product)]?.text = product.quantity
          .toString();
      context.showSnackBar(result.errorMessage!, isError: true);
      return;
    }

    _quantityControllers[_quantityKey(product)]?.text = parsedQuantity
        .toString();
    widget.selectedProductsNotifier.value = result.products;
    _quantityFocusNodes[_quantityKey(product)]?.unfocus();
    final updatedIndex = result.products.indexWhere(
      (item) =>
          BookingProductHelpers.productKey(item) ==
          BookingProductHelpers.productKey(product),
    );
    if (updatedIndex != -1 && advanceToPrice) {
      // After confirming the quantity with Enter, move focus to the price field
      // so the user can review/edit it before continuing to the next row /
      // client. (Tapping outside just saves without grabbing focus.)
      _rowActiveElement[_quantityKey(product)] = 5;
      _startEditingPrice(result.products[updatedIndex]);
    }
  }

  void _startEditingPrice(ProductSelectedEntity product) {
    // An item that already came back is settled — it can't be
    // re-priced, re-counted or dropped from the booking.
    if (_isReturned(product)) return;
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

  /// Whether this line item has already been marked returned by a (partial)
  /// return — such rows are read-only.
  bool _isReturned(ProductSelectedEntity product) =>
      product.variant.deliveryStatus.isReturned;

  void _removeRowFocusNodes(int key) {
    _rowFocusNodes.remove(key)?.dispose();
    _rowElementFocusNodes.remove(key)?.forEach((n) => n.dispose());
    _rowActiveElement.remove(key);
  }

  void _removeProduct(ProductSelectedEntity product) {
    // An item that already came back is settled — it can't be
    // re-priced, re-counted or dropped from the booking.
    if (_isReturned(product)) return;
    final products = widget.selectedProductsNotifier.value;
    final key = _quantityKey(product);
    _quantityControllers.remove(key)?.dispose();
    _quantityFocusNodes.remove(key)?.dispose();
    _removeRowFocusNodes(key);
    widget.selectedProductsNotifier.value =
        SelectedProductsManager.removeProduct(
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
