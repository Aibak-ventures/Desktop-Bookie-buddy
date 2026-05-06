import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:flutter/material.dart';

/// Reusable overlay popup for product search results.
/// Used by both new-booking and edit-booking screens.
///
/// The parent screen owns the [OverlayEntry]; this widget is the builder content.
class ProductSearchOverlayPopup extends StatelessWidget {
  final LayerLink layerLink;
  final ValueNotifier<bool> isLoading;
  final ValueNotifier<List<ProductEntity>> products;
  final VoidCallback onDismiss;
  final ScrollController? scrollController;
  final Widget Function(ProductEntity product, int index, int itemCount)
  itemBuilder;

  const ProductSearchOverlayPopup({
    super.key,
    required this.layerLink,
    required this.isLoading,
    required this.products,
    required this.onDismiss,
    required this.itemBuilder,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const SizedBox.expand(),
          ),
        ),
        Positioned(
          width: 1000,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 44),
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(10),
              child: ValueListenableBuilder<bool>(
                valueListenable: isLoading,
                builder: (context, isLoadingVal, _) {
                  return ValueListenableBuilder<List<ProductEntity>>(
                    valueListenable: products,
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
                            _buildHeader(context, isLoadingVal, productList),
                            _buildBody(isLoadingVal, productList),
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
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isLoadingVal,
    List<ProductEntity> productList,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
          if (isLoadingVal)
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
            onTap: onDismiss,
            child: Icon(Icons.close, size: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(bool isLoadingVal, List<ProductEntity> productList) {
    if (isLoadingVal) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 36),
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
              style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    if (productList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
              style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
            ),
          ],
        ),
      );
    }

    return Flexible(
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: productList.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Colors.grey.shade200),
        itemBuilder: (_, i) =>
            itemBuilder(productList[i], i, productList.length),
      ),
    );
  }
}
