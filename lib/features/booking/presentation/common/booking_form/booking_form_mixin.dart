import 'dart:developer';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/additional_charges_entity/additional_charges_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_form_controllers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/booking_form/booking_type_enum.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_info_entity/product_info_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/check_variant_availability_usecase.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/select_product_bloc/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shared methods for booking form screens (new booking and edit booking).
///
/// Implementing class must provide [form] — the shared [BookingFormControllers].
mixin BookingFormMixin<T extends StatefulWidget> on State<T> {
  BookingFormControllers get form;

  bool hasAnyProductWithVariants() {
    final products = form.selectedProductsNotifier.value;
    return products.any((product) {
      final mainServiceType = product.variant.mainServiceType;
      // Only show variants column if product is multi-variant type and has variant attribute
      return mainServiceType.isMultiVariantProductType &&
          (product.variant.variantAttribute?.isNotEmpty ?? false);
    });
  }

  bool shouldMultiplyByDays(MainServiceType? type) {
    return type.isDressType;
  }

  void startEditingPrice(ProductSelectedEntity product) {
    setState(() {
      form.editingVariantId = product.variant.variantId;
      form.inlinePriceController.text = product.amount.toString();
      // Schedule focus request for next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        form.inlinePriceFocusNode.requestFocus();
      });
    });
  }

  void updateProductPrice(ProductSelectedEntity product, int newPrice) {
    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(amount: newPrice);
      form.selectedProductsNotifier.value = products;
    }
  }

  void removeCharge(AdditionalChargesEntity charge) {
    final charges = List<AdditionalChargesEntity>.from(
      form.additionalChargesNotifier.value,
    );
    charges.remove(charge);
    form.additionalChargesNotifier.value = charges;
  }

  int quantityKey(ProductSelectedEntity product) {
    return product.variant.variantId ?? product.variant.id;
  }

  TextEditingController getQuantityController(ProductSelectedEntity product) {
    final key = quantityKey(product);
    final focusNode = getQuantityFocusNode(key);
    final controller = form.quantityControllers.putIfAbsent(
      key,
      () => TextEditingController(text: product.quantity.toString()),
    );
    if (!focusNode.hasFocus && controller.text != product.quantity.toString()) {
      controller.text = product.quantity.toString();
    }
    return controller;
  }

  FocusNode getQuantityFocusNode(int key) {
    return form.quantityFocusNodes.putIfAbsent(key, FocusNode.new);
  }

  void incrementQuantity(ProductSelectedEntity product) {
    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;
    final currentQuantity = product.quantity;

    if (currentQuantity >= availableStock) {
      context.showSnackBar(
        'Cannot add more. Available stock: $availableStock',
        isError: true,
      );
      return;
    }

    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      products[index] = products[index].copyWith(
        quantity: products[index].quantity + 1,
      );

      final key = quantityKey(product);
      form.quantityControllers[key]?.text = products[index].quantity.toString();

      form.selectedProductsNotifier.value = products;
    }
  }

  void decrementQuantity(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index] = products[index].copyWith(
          quantity: products[index].quantity - 1,
        );
        final key = quantityKey(product);
        form.quantityControllers[key]?.text = products[index].quantity
            .toString();
      } else {
        final key = quantityKey(product);
        form.quantityControllers.remove(key)?.dispose();
        form.quantityFocusNodes.remove(key)?.dispose();
        products.removeAt(index);
      }
      form.selectedProductsNotifier.value = products;
    }
  }

  void saveTypedQuantity(ProductSelectedEntity product, String value) {
    final parsedQuantity = int.tryParse(value.trim());

    if (parsedQuantity == null || parsedQuantity <= 0) {
      final key = quantityKey(product);
      form.quantityControllers[key]?.text = product.quantity.toString();
      context.showSnackBar('Quantity must be greater than 0', isError: true);
      return;
    }

    final availableStock =
        product.variant.remainingStock ?? product.variant.stock ?? 999;

    if (parsedQuantity > availableStock) {
      final key = quantityKey(product);
      form.quantityControllers[key]?.text = product.quantity.toString();
      context.showSnackBar(
        'Quantity cannot be greater than available stock ($availableStock)',
        isError: true,
      );
      return;
    }

    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );
    final index = products.indexWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );

    if (index == -1) return;

    products[index] = products[index].copyWith(quantity: parsedQuantity);
    final key = quantityKey(product);
    form.quantityControllers[key]?.text = parsedQuantity.toString();
    form.selectedProductsNotifier.value = products;
    form.quantityFocusNodes[key]?.unfocus();
  }

  void removeProduct(ProductSelectedEntity product) {
    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );
    products.removeWhere(
      (p) => p.variant.variantId == product.variant.variantId,
    );
    form.selectedProductsNotifier.value = products;
  }

  void addProductFromSearchWithVariant({
    required ProductEntity product,
    required ProductVariantEntity variant,
    required bool isSales,
  }) {
    // For sales mode, use sale_price if available, otherwise fall back to price
    final productSalePriceInt = isSales && product.salePrice != null
        ? (double.tryParse(product.salePrice!)?.toInt())
        : null;
    final price = isSales
        ? (variant.salePrice ??
              productSalePriceInt ??
              variant.price ??
              product.price ??
              0)
        : (variant.price ?? product.price ?? 0);

    final products = List<ProductSelectedEntity>.from(
      form.selectedProductsNotifier.value,
    );

    // Check if this variant already exists
    final existingIndex = products.indexWhere(
      (p) => p.variant.variantId == variant.id,
    );

    if (existingIndex != -1) {
      // Check if incrementing would exceed available stock
      final existing = products[existingIndex];
      final newQuantity = existing.quantity + 1;
      final availableStock = variant.remainingStock ?? variant.stock;

      if (newQuantity > availableStock) {
        context.showSnackBar(
          'Cannot add more. Available stock: $availableStock',
          isError: true,
        );
        return;
      }

      // Increment quantity
      products[existingIndex] = existing.copyWith(quantity: newQuantity);
    } else {
      // Add new product with selected variant
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
            measurements: [],
            quantity: 1,
            stock: variant.stock,
            remainingStock: variant.remainingStock,
          ),
          quantity: 1,
          amount: price,
        ),
      );
    }

    form.selectedProductsNotifier.value = products;
  }

  void saveEditingPrice(ProductSelectedEntity product) {
    if (form.editingVariantId == null) return;

    final newPrice = int.tryParse(form.inlinePriceController.text);
    if (newPrice == null || newPrice <= 0) {
      context.showSnackBar(
        'Product price cannot be zero or empty',
        isError: true,
      );
      return;
    }

    updateProductPrice(product, newPrice);

    setState(() {
      form.editingVariantId = null;
      form.inlinePriceController.clear();
      form.inlinePriceFocusNode.unfocus();
    });
  }

  void updateSearchTypesForService(int? serviceId) {
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    if (serviceId == null || serviceId == -1) {
      form.currentServiceType = null;
      form.searchTypes = ['Name', 'Category', 'Model', 'Color'];
    } else {
      final service = services.firstWhere(
        (s) => s.id == serviceId,
        orElse: () => services.first,
      );
      form.currentServiceType = MainServiceType.fromString(
        service.mainServiceName,
      );

      final categoryLabel = form.currentServiceType.categoryFieldLabel;
      final secondaryLabel =
          form.currentServiceType.secondaryAttributeLabel ?? 'Color';

      if (form.currentServiceType.isMultiVariantProductType) {
        final variantLabel = form.currentServiceType.variantAttributeLabel;
        form.searchTypes = [
          'Name',
          categoryLabel,
          secondaryLabel,
          variantLabel,
        ];
      } else {
        form.searchTypes = ['Name', categoryLabel, secondaryLabel, 'Color'];
      }
    }
  }

  void onSearchChanged(BookingType bookingType, [String? newValue]) {
    final query = (newValue ?? form.serviceSearchController.text)
        .trim()
        .toLowerCase();
    final isSales = bookingType == BookingType.sales;
    final serviceIdToUse =
        (form.selectedServiceId == null || form.selectedServiceId == -1)
        ? null
        : form.selectedServiceId;

    final hasSearchQuery = query.isNotEmpty;
    final hasPriceFilter = form.isPriceFilterEnabled.value;
    final hasAnyFilter = hasSearchQuery || hasPriceFilter;

    if (!hasAnyFilter) {
      loadProductsForService(bookingType, form.selectedServiceId);
    } else {
      String? searchType;
      switch (form.selectedSearchTypeIndex.value) {
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
          if (form.currentServiceType != null) {
            if (form.currentServiceType.isMultiVariantProductType) {
              if (form.currentServiceType == MainServiceType.dress ||
                  form.currentServiceType == MainServiceType.costume) {
                searchType = 'size';
              } else if (form.currentServiceType == MainServiceType.gadgets) {
                searchType = 'serial_number';
              } else {
                searchType = 'variant';
              }
            } else {
              searchType = 'color';
            }
          } else {
            searchType = 'color';
          }
          break;
      }
      searchType ??= 'name';

      form.selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: hasSearchQuery ? query : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: hasPriceFilter
              ? form.priceRange.value.start.round()
              : null,
          endPrice: hasPriceFilter ? form.priceRange.value.end.round() : null,
          pickupDate: form.pickupDate.format(),
          returnDate: form.returnDate.format(),
          pickupTime: form.pickupTime,
          returnTime: form.returnTime,
          useAvailableProductsApi: bookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }

  void showLocalFilteredResults(BookingType bookingType, String rawQuery) {
    if (!mounted) return;
    final q = rawQuery.toLowerCase();

    form.selectProductBloc.state.maybeWhen(
      loaded:
          (
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
          ) {
            final filtered = products.where((p) {
              final matchesName = p.name.toLowerCase().contains(q);
              final matchesCategory =
                  p.category?.toLowerCase().contains(q) ?? false;
              final matchesModel = p.model?.toLowerCase().contains(q) ?? false;
              final matchesVariant = p.variants.any(
                (v) => v.attribute.toLowerCase().contains(q),
              );
              return matchesName ||
                  matchesCategory ||
                  matchesModel ||
                  matchesVariant;
            }).toList();

            form.overlayProducts.value = filtered;
            form.overlayIsLoading.value = false;

            if (form.searchOverlayEntry == null) {
              showSearchOverlay();
            }
          },
      orElse: () {},
    );
  }

  void showSearchOverlay() {
    // This is typically called by the screen to show the actual entry.
    // If the screen implements it, it will override this.
  }

  void initializeCoolingPeriod(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final coolingDuration =
        userCubit.state?.shopSettings.coolingPeriodDuration ?? 0;

    if (coolingDuration > 0) {
      setState(() {
        form.coolingPeriodDays = coolingDuration;
      });
    }
  }

  void updateCoolingPeriod(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    final coolingDuration =
        userCubit.state?.shopSettings.coolingPeriodDuration ?? 0;

    if (coolingDuration > 0) {
      setState(() {
        form.coolingPeriodDays = coolingDuration;
      });
    }
  }

  void applyProductFilters(
    BookingType bookingType,
    int searchTypeIndex,
    RangeValues priceRange,
    bool isPriceEnabled,
  ) {
    form.selectedSearchTypeIndex.value = searchTypeIndex;
    form.priceRange.value = priceRange;
    form.isPriceFilterEnabled.value = isPriceEnabled;

    onSearchChanged(bookingType);
  }

  void loadProductsForService(BookingType bookingType, int? serviceId) {
    final isSales = bookingType == BookingType.sales;
    final serviceIdToUse = (serviceId == null || serviceId == -1)
        ? null
        : serviceId;

    final effectiveReturnDate = bookingType == BookingType.booking
        ? form.returnDate.add(Duration(days: form.coolingPeriodDays)).format()
        : form.returnDate.format();

    form.selectProductBloc.add(
      SelectProductEvent.loadProducts(
        serviceId: serviceIdToUse,
        pickupDate: form.pickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: form.pickupTime,
        returnTime: form.returnTime,
        useAvailableProductsApi: bookingType == BookingType.booking,
        isSales: isSales,
      ),
    );

    checkSelectedProductsAvailability();
  }

  void checkSelectedProductsAvailability() async {
    final selectedProducts = form.selectedProductsNotifier.value;
    if (selectedProducts.isEmpty) return;

    final variantIds = selectedProducts
        .map((p) => p.variant.variantId)
        .whereType<int>()
        .toList();
    if (variantIds.isEmpty) return;

    try {
      final notFoundIds = await getIt<CheckVariantAvailabilityUseCase>()(
        variantIds: variantIds,
        pickupDate: form.pickupDate.format(),
        returnDate: form.returnDate.format(),
        pickupTime: form.pickupTime,
        returnTime: form.returnTime,
      );

      if (notFoundIds.isNotEmpty && mounted) {
        log('Unavailable products: $notFoundIds');
      }
    } catch (e) {
      log('Error checking availability: $e');
    }
  }

  int calculateRentalDays() {
    final pickupDateTime = DateTime(
      form.pickupDate.year,
      form.pickupDate.month,
      form.pickupDate.day,
      form.pickupTime?.hour ?? 23,
      form.pickupTime?.minute ?? 59,
    );

    final returnDateTime = DateTime(
      form.returnDate.year,
      form.returnDate.month,
      form.returnDate.day,
      form.returnTime?.hour ?? 0,
      form.returnTime?.minute ?? 0,
    );

    if (!returnDateTime.isAfter(pickupDateTime)) return 1;

    final hours = returnDateTime.difference(pickupDateTime).inMinutes / 60;
    return hours <= 24 ? 1 : (hours / 24).ceil();
  }

  void addAdditionalCharge() async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    final result = await showDialog<AdditionalChargesEntity>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Charge', style: TextStyle(fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'e.g., Delivery',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Amount',
                prefixText: '₹ ',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final amount = int.tryParse(amountController.text);

              if (name.isEmpty) {
                context.showSnackBar('Please enter charge name', isError: true);
                return;
              }

              if (amount == null || amount <= 0) {
                context.showSnackBar(
                  'Please enter a valid amount greater than 0',
                  isError: true,
                );
                return;
              }

              Navigator.pop(
                context,
                AdditionalChargesEntity(name: name, amount: amount),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6132E4),
            ),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result != null) {
      final charges = List<AdditionalChargesEntity>.from(
        form.additionalChargesNotifier.value,
      );
      charges.add(result);
      form.additionalChargesNotifier.value = charges;
    }
  }

  Widget buildSummaryRow(
    String label,
    int amount, {
    Color? valueColor,
    bool isBold = false,
    bool isNegative = false,
  }) {
    final isTotalPayable = label == 'Total payable';
    final isPaid = label == 'Paid';
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
    } else if (isPaid) {
      labelSize = 15;
      valueSize = 15;
      labelWeight = FontWeight.w500;
      valueWeight = FontWeight.w600;
      valueColor = const Color(0xFF1AB000);
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
            isNegative
                ? '- ₹ ${amount.toCurrency()}'
                : '₹ ${amount.toCurrency()}',
            style: TextStyle(
              fontSize: valueSize,
              fontFamily: 'Inter',
              fontWeight: valueWeight,
              color: valueColor ?? const Color(0xFF3E3E3E),
            ),
          ),
        ],
      ),
    );
  }

  void onClientNameChanged() {
    final selectedClient = context.read<ClientCubit>().state.selectedClient;
    if (selectedClient != null && form.selectedClientId != null) {
      final currentName = form.clientNameController.text.trim();
      final selectedClientName = selectedClient.name.trim();

      if (currentName != selectedClientName) {
        setState(() {
          form.selectedClientId = null;
        });
        context.read<ClientCubit>().clearSelected();
      }
    }
  }

  void onClientPhoneChanged() {
    final selectedClient = context.read<ClientCubit>().state.selectedClient;
    if (selectedClient != null && form.selectedClientId != null) {
      final currentPhone1 = form.clientPhone1Controller.text.trim();
      final currentPhone2 = form.clientPhone2Controller.text.trim();
      final selectedPhone1 = selectedClient.phone1.toString().trim();
      final selectedPhone2 = selectedClient.phone2?.toString().trim() ?? '';

      if (currentPhone1 != selectedPhone1 || currentPhone2 != selectedPhone2) {
        setState(() {
          form.selectedClientId = null;
        });
        context.read<ClientCubit>().clearSelected();
      }
    }
  }

  void handleSearchOverlayScroll(ScrollController scrollController) {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels < position.maxScrollExtent - 180) return;

    form.selectProductBloc.state.maybeWhen(
      loaded:
          (
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
          ) {
            if (isPaginating || nextPageUrl == null) return;
            if (isSearching) {
              form.selectProductBloc.add(
                const SelectProductEvent.loadNextSearchResults(),
              );
            } else {
              form.selectProductBloc.add(
                const SelectProductEvent.loadNextPageProducts(),
              );
            }
          },
      orElse: () {},
    );
  }

  bool hasUnsavedChanges() {
    if (form.selectedProductsNotifier.value.isNotEmpty) return true;
    if (form.clientNameController.text.trim().isNotEmpty) return true;
    if (form.clientPhone1Controller.text.trim().isNotEmpty) return true;
    if (form.clientAddressController.text.trim().isNotEmpty) return true;
    if (form.advanceAmountController.text.trim().isNotEmpty) return true;
    if (form.additionalChargesNotifier.value.isNotEmpty) return true;
    if (form.documentsNotifier.value.isNotEmpty) return true;
    if (form.descriptionController.text.trim().isNotEmpty) return true;
    return false;
  }

  Future<void> handleBackNavigation({VoidCallback? onClose}) async {
    form.removeSearchOverlay();
    if (hasUnsavedChanges()) {
      final shouldDiscard = await showDiscardDialog(context);
      if (shouldDiscard == true) {
        if (!mounted) return;
        if (onClose != null) {
          onClose();
        } else {
          Navigator.of(context).pop();
        }
      }
    } else {
      if (onClose != null) {
        onClose();
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  void resetForm() {
    form.clientNameController.clear();
    form.clientPhone1Controller.clear();
    form.clientPhone2Controller.clear();
    form.clientAddressController.clear();
    form.staffNameController.clear();
    form.selectedStaffId = null;
    form.selectedClientId = null;
    form.advanceAmountController.clear();
    form.securityAmountController.clear();
    form.discountAmountController.clear();
    form.descriptionController.clear();
    form.selectedProductsNotifier.value = [];
    form.additionalChargesNotifier.value = [];
    form.documentsNotifier.value = [];
    form.serviceSearchController.clear();
    context.read<StaffSearchCubit>().clearSelectedStaff();
    context.read<ClientCubit>().clearSelected();
  }

  Widget buildHeaderCell(String title, {bool alignLeft = false}) {
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
}

extension CoolingPeriodModeX on CoolingPeriodMode? {
  bool get isAfter => this == CoolingPeriodMode.after;
  bool get isBefore => this == CoolingPeriodMode.before;
}
