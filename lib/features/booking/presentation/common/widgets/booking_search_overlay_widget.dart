import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/search_overlay_result_widget.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared helper to create and insert a search overlay for product searching.
/// Used by both [NewBookingScreen] and [EditNewBookingScreen].
class BookingSearchOverlayHelper {
  BookingSearchOverlayHelper._();

  /// Shows the search overlay attached to the [form.searchLayerLink].
  ///
  /// [form] – shared form controllers holding overlay state.
  /// [context] – the widget's BuildContext for inserting into the Overlay.
  /// [isSales] – whether the current mode is sales (affects product price display).
  /// [onAddProduct] – callback when a product variant is selected from the overlay.
  /// [scrollController] – optional scroll controller for pagination support.
  static void showSearchOverlay({
    required BookingFormControllers form,
    required BuildContext context,
    required bool isSales,
    required void Function(ProductEntity product, dynamic variant) onAddProduct,
    ScrollController? scrollController,
  }) {
    // Guard: only insert once; subsequent updates go through the ValueNotifiers
    if (form.searchOverlayEntry != null) return;

    form.searchOverlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Transparent barrier — tap outside to dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                form.serviceSearchController.clear();
                form.removeSearchOverlay();
              },
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
          ),
          // The actual search overlay
          Positioned(
            width: 1000,
            child: CompositedTransformFollower(
              link: form.searchLayerLink,
              showWhenUnlinked: false,
              offset: const Offset(0, 44),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(10),
                // Wrap both notifiers so the overlay rebuilds reactively
                child: _SearchOverlayContent(
                  form: form,
                  isSales: isSales,
                  onAddProduct: onAddProduct,
                  scrollController: scrollController,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(form.searchOverlayEntry!);
  }
}

class _SearchOverlayContent extends StatefulWidget {
  final BookingFormControllers form;
  final bool isSales;
  final void Function(ProductEntity product, dynamic variant) onAddProduct;
  final ScrollController? scrollController;

  const _SearchOverlayContent({
    required this.form,
    required this.isSales,
    required this.onAddProduct,
    this.scrollController,
  });

  @override
  State<_SearchOverlayContent> createState() => _SearchOverlayContentState();
}

class _SearchOverlayContentState extends State<_SearchOverlayContent> {
  int _highlightedIndex = -1;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    final productList = widget.form.overlayProducts.value;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.numpad2) {
      setState(() {
        if (_highlightedIndex < productList.length - 1) {
          _highlightedIndex++;
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.numpad8) {
      setState(() {
        if (_highlightedIndex > 0) {
          _highlightedIndex--;
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.numpadEnter) {
      if (_highlightedIndex >= 0 &&
          _highlightedIndex < productList.length) {
        widget.form.removeSearchOverlay();
        widget.form.serviceSearchController.clear();
        widget.onAddProduct(
          productList[_highlightedIndex],
          null,
        );
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      widget.form.serviceSearchController.clear();
      widget.form.removeSearchOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (_, event) {
        _handleKeyEvent(event);
        return KeyEventResult.handled;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: widget.form.overlayIsLoading,
        builder: (context, isLoading, _) {
          return ValueListenableBuilder<List<ProductEntity>>(
            valueListenable: widget.form.overlayProducts,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.form.serviceSearchController.clear();
                              widget.form.removeSearchOverlay();
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
                          controller: widget.scrollController,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                          ),
                          itemCount: productList.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color: Colors.grey.shade200,
                          ),
                          itemBuilder: (_, i) => Container(
                            color: _highlightedIndex == i
                                ? Colors.purple.withValues(alpha: 0.1)
                                : null,
                            child: OverlaySearchItem(
                              product: productList[i],
                              isSales: widget.isSales,
                              onAddProduct: (selectedVariant) {
                                widget.form.removeSearchOverlay();
                                widget.form.serviceSearchController.clear();
                                widget.onAddProduct(
                                  productList[i],
                                  selectedVariant,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
