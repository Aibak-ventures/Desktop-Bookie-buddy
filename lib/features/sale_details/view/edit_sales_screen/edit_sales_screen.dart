import 'dart:developer';

import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/models/sale_details_model/sale_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/core/ui/screens/success_animation_screen.dart';
import 'package:bookie_buddy_web/core/ui/widgets/staff_search_name_field.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/view_model/cubit_save_sales/save_sales_cubit.dart';
import 'package:bookie_buddy_web/features/add_or_edit_sales/views/controllers/add_or_edit_sales_form_state_controller.dart';
import 'package:bookie_buddy_web/features/new_booking/helpers/booking_text_field_builder.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:bookie_buddy_web/src/di/injection.dart';
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

  // Inline editing state
  int? _editingVariantId;
  final _inlinePriceController = TextEditingController();
  final _inlinePriceFocusNode = FocusNode();

  // Field spacing constant
  static const double _fieldSpacing = 8.0;

  @override
  void initState() {
    super.initState();
    // Initialize with sale details
    _formController.setInitialValues(widget.saleDetails, context);

    _totalAmountListener = Listenable.merge([
      _formController.discountController,
      _formController.selectedProductsNotifier,
    ]);

    // Initialize SelectProductBloc for product search
    _selectProductBloc = SelectProductBloc(
      repository: getIt<ProductRepository>(),
    );
  }

  @override
  void dispose() {
    _removeSearchOverlay();
    _formController.dispose();
    _serviceSearchController.dispose();
    _selectProductBloc.close();
    _inlinePriceController.dispose();
    _inlinePriceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: _handlePop,
      child: Container(
        color: const Color(0xFFF5F6FA),
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
    );
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
                  'ID: ${widget.saleDetails.id}',
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
    return CompositedTransformTarget(
      link: _searchLayerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
    );
  }

  void _onSearchChanged() {
    final query = _serviceSearchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    _selectProductBloc.add(
      SelectProductEvent.searchProducts(
        serviceId: null,
        query: query,
        type: 'name',
        pickupDate: _formController.saleDateController.text,
        returnDate: _formController.saleDateController.text,
        isSales: true,
      ),
    );
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
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
              children: [
                _buildQuantityBtn(
                    icon: Icons.remove,
                    onTap: () => _decrementQuantity(product)),
                const SizedBox(width: 6),
                Text(
                  '${product.quantity}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
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
                              horizontal: 8, vertical: 0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey.shade400),
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
                        const Icon(Icons.edit_outlined,
                            size: 16, color: Color(0xFF6132E4)),
                      ],
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SuccessAnimationScreen(
                          text: 'Sale updated successfully!',
                          afterSuccess: () {
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          },
                        ),
                      ),
                    );
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
    log('Sales Update Request: $req');
    if (req == null) return;
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
