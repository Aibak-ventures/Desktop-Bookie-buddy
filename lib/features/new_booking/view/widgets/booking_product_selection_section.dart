import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/screens/select_service_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/select_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingProductSelectionSection extends StatefulWidget {
  final ValueNotifier<List<ProductSelectedModel>> selectedProductsNotifier;
  final String pickupDate;
  final String returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final bool isSales;

  const BookingProductSelectionSection({
    super.key,
    required this.selectedProductsNotifier,
    required this.pickupDate,
    required this.returnDate,
    this.pickupTime,
    this.returnTime,
    this.isSales = false,
  });

  @override
  State<BookingProductSelectionSection> createState() =>
      _BookingProductSelectionSectionState();
}

class _BookingProductSelectionSectionState
    extends State<BookingProductSelectionSection> {
  final searchController = TextEditingController();
  String selectedCategory = 'All Categories';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with count and add button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder<List<ProductSelectedModel>>(
                valueListenable: widget.selectedProductsNotifier,
                builder: (context, products, _) {
                  return Text(
                    'Select Products (${products.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  );
                },
              ),
              ElevatedButton.icon(
                onPressed: _openProductSelection,
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Products'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search and filter row
          _buildSearchRow(),
          const SizedBox(height: 16),
          // Product table header
          _buildTableHeader(),
          const SizedBox(height: 8),
          // Product list
          ValueListenableBuilder<List<ProductSelectedModel>>(
            valueListenable: widget.selectedProductsNotifier,
            builder: (context, products, _) {
              if (products.isEmpty) {
                return _buildEmptyState();
              }
              return Column(
                children: products
                    .map((product) => _buildProductRow(product))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        // Category dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCategory,
              isDense: true,
              icon:
                  Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
              items: ['All Categories', 'Lehenga', 'Saree', 'Sherwani', 'Suit']
                  .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Search field
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search product name',
                hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Filter button
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.tune, color: Colors.grey.shade600, size: 20),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Items',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Variants',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
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
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Price / Item',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
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
              ),
            ),
          ),
          const SizedBox(width: 40), // Space for delete button
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              'No products selected',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _openProductSelection,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Products'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductRow(ProductSelectedModel product) {
    final variant = product.variant;
    final total = product.amount * product.quantity;
    final availableQty = variant.quantity;
    final isLowStock = availableQty <= 3;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          // Item with image
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
                  child: variant.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomNetworkImage(
                            imageUrl: variant.image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(Icons.image, color: Colors.grey.shade400),
                ),
                const SizedBox(width: 12),
                // Product name and details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        variant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (variant.category != null)
                        Text(
                          variant.category!,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Variant size
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                // child: Text(
                //   variant.size ?? '-',
                //   style: const TextStyle(fontSize: 12),
                // ),
              ),
            ),
          ),
          // Available quantity
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isLowStock ? Colors.red.shade50 : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$availableQty left',
                  style: TextStyle(
                    fontSize: 11,
                    color: isLowStock ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          // Quantity with +/- buttons
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${product.quantity}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => _incrementQuantity(product),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.add,
                          size: 14, color: AppColors.purple),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Price per item with edit
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.amount.toCurrency(),
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () => _editPrice(product),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: AppColors.purple,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Total
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                total.toCurrency(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Delete button
          SizedBox(
            width: 40,
            child: IconButton(
              onPressed: () => _removeProduct(product),
              icon: const Icon(Icons.close, size: 18),
              color: Colors.grey.shade500,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  void _openProductSelection() async {
    // Navigate to SelectServiceScreen first, then to SelectProductScreen
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SelectServiceScreen(
          onServiceSelected: (service, ctx) async {
            final result = await Navigator.push<List<ProductSelectedModel>>(
              ctx,
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
                    serviceId: service.id,
                    pickupDate: widget.pickupDate,
                    returnDate: widget.returnDate,
                    pickupTime: widget.pickupTime,
                    returnTime: widget.returnTime,
                    preSelectedData: widget.selectedProductsNotifier.value,
                    isSales: widget.isSales,
                    useAvailableProductsApi: !widget.isSales,
                  ),
                ),
              ),
            );

            if (result != null) {
              widget.selectedProductsNotifier.value = result;
            }
            if (ctx.mounted) Navigator.pop(ctx); // Close service screen
          },
        ),
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

  void _editPrice(ProductSelectedModel product) async {
    final controller = TextEditingController(text: product.amount.toString());

    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Price'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Price',
            prefixText: '₹ ',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPrice = int.tryParse(controller.text);
              if (newPrice != null && newPrice > 0) {
                Navigator.pop(context, newPrice);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null) {
      final products = List<ProductSelectedModel>.from(
          widget.selectedProductsNotifier.value);
      final index = products
          .indexWhere((p) => p.variant.variantId == product.variant.variantId);
      if (index != -1) {
        final updatedProduct = product.copyWith(amount: result);
        products[index] = updatedProduct;
        widget.selectedProductsNotifier.value = products;
      }
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
