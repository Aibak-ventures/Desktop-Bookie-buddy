part of '../pages/edit_new_booking_screen.dart';

extension EditBookingSearchHandler on EditNewBookingScreenState {
  // ===== Search/Overlay Lifecycle Methods =====

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
  }

  void _showSearchOverlay() {
    if (_searchOverlayEntry != null) return;

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => ProductSearchOverlayPopup(
        layerLink: _searchLayerLink,
        isLoading: _overlayIsLoading,
        products: _overlayProducts,
        onDismiss: () {
          serviceSearchController.clear();
          _removeSearchOverlay();
        },
        itemBuilder: (product, index, itemCount) => _buildOverlaySearchItem(
          product,
          index: index,
          itemCount: itemCount,
        ),
      ),
    );

    Overlay.of(context).insert(_searchOverlayEntry!);
  }

  // ===== UI Building Methods =====

  Widget _buildProductSearchBar() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocListener<SelectProductBloc, SelectProductState>(
          bloc: _selectProductBloc,
          listener: (context, state) {
            // Update existing products' stock from availability API
            state.maybeWhen(
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
                    if (widget.bookingId != null && products.isNotEmpty) {
                      _syncSelectedProductStock(products);
                    }

                    // Reactive overlay update â€" show/hide overlay based on search state
                    final hasSearchText =
                        serviceSearchController.text.isNotEmpty;
                    final hasFilters =
                        _isPriceFilterEnabled.value ||
                        _selectedSearchTypeIndex.value != 0;
                    final hasAnyFilter = hasSearchText || hasFilters;

                    if (hasAnyFilter || (products.isNotEmpty && isSearching)) {
                      _overlayIsLoading.value = false;
                      _overlayProducts.value = products;
                      if (_searchOverlayEntry == null) _showSearchOverlay();
                    } else {
                      _removeSearchOverlay();
                    }
                  },
              loading: () {
                final hasQuery = serviceSearchController.text.isNotEmpty;
                final hasFilters =
                    _isPriceFilterEnabled.value ||
                    _selectedSearchTypeIndex.value != 0;
                if (hasQuery || hasFilters) {
                  _overlayIsLoading.value = true;
                  if (_searchOverlayEntry == null) _showSearchOverlay();
                }
              },
              orElse: () {
                final hasQuery = serviceSearchController.text.isNotEmpty;
                if (!hasQuery) _removeSearchOverlay();
              },
            );
          },
          child: ProductListSearchBarWidget(
            controller: serviceSearchController,
            layerLink: _searchLayerLink,
            focusNode: _productSearchFocusNode,
            overlayProducts: _overlayProducts,
            getOverlayItemFocusNode: _getOverlayItemFocusNode,
            clientNameFocusNode: _clientNameFocusNode,
            onChanged: (value) {
              _onSearchChanged();
              if (value.isEmpty) _removeSearchOverlay();
            },
            onFilterTap: () {
              _removeSearchOverlay();
              _showProductFilterBottomSheet();
            },
          ),
        );
      },
    );
  }

  /// Builds search item for the overlay - requires variant selection before adding
  Widget _buildOverlaySearchItem(
    ProductEntity product, {
    required int index,
    required int itemCount,
  }) {
    return OverlaySearchItem(
      product: product,
      isSales: selectedBookingType == BookingType.sales,
      focusNode: _getOverlayItemFocusNode(index),
      nextFocusNode: index + 1 < itemCount
          ? _getOverlayItemFocusNode(index + 1)
          : _clientNameFocusNode,
      onAddProduct: (selectedVariant) {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _addProductFromSearchWithVariant(product, selectedVariant);
        _clientNameFocusNode.requestFocus();
      },
      onArrowDown: index + 1 < itemCount
          ? () {
              final nextNode = _getOverlayItemFocusNode(index + 1);
              nextNode.requestFocus();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final ctx = nextNode.context;
                if (ctx != null && ctx.mounted) {
                  Scrollable.ensureVisible(
                    ctx,
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    alignment: 0.15,
                  );
                }
              });
            }
          : null,
      onArrowUp: () {
        if (index > 0) {
          final prevNode = _getOverlayItemFocusNode(index - 1);
          prevNode.requestFocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final ctx = prevNode.context;
            if (ctx != null && ctx.mounted) {
              Scrollable.ensureVisible(
                ctx,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                alignment: 0.15,
              );
            }
          });
        } else {
          _productSearchFocusNode.requestFocus();
        }
      },
      onEscape: () {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _productSearchFocusNode.requestFocus();
      },
      onImageTap: (imageUrl, title) {
        _removeSearchOverlay();
        ZoomableImageDialog.show(context, imageUrl: imageUrl, title: title);
      },
    );
  }

  FocusNode _getOverlayItemFocusNode(int index) {
    return _overlayItemFocusNodes.putIfAbsent(index, FocusNode.new);
  }

  void _showProductFilterBottomSheet() {
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
      ) => products,
      orElse: () => <ProductEntity>[],
    );

    if (currentProducts.isNotEmpty) {
      double maxProductPrice = 0;
      for (final product in currentProducts) {
        final productPrice = product.price ?? 0;
        if (productPrice > maxProductPrice) {
          maxProductPrice = productPrice.toDouble();
        }
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

    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => ProductFilterDialog(
        services: services,
        searchTypes: _searchTypes,
        initialServiceId: selectedServiceId,
        initialSearchTypeIndex: _selectedSearchTypeIndex.value,
        initialPriceRange: _priceRange.value,
        initialMaxPrice: _maxPriceNotifier.value,
        initialIsPriceFilterEnabled: _isPriceFilterEnabled.value,
        onApply: ({
          required serviceId,
          required searchTypeIndex,
          required priceRange,
          required maxPrice,
          required isPriceFilterEnabled,
        }) {
          rebuild(() {
            selectedServiceId = serviceId;
            _selectedSearchTypeIndex.value = searchTypeIndex;
            _priceRange.value = priceRange;
            _maxPriceNotifier.value = maxPrice;
            _isPriceFilterEnabled.value = isPriceFilterEnabled;
          });
          _applyProductFilters(searchTypeIndex, priceRange, isPriceFilterEnabled);
        },
      ),
    );
  }
  // ===== Filter Application Logic =====

  /// Apply product filters based on selection
  void _applyProductFilters(
    int searchTypeIndex,
    RangeValues _priceRange,
    bool isPriceEnabled,
  ) {
    _isPriceFilterEnabled.value = isPriceEnabled;
    final searchTerm = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;

    final searchType = BookingSearchRules.resolveSearchType(searchTypeIndex);
    final hasAnyFilter =
        searchTerm.isNotEmpty || isPriceEnabled || searchTypeIndex != 0;

    final effectiveReturnDate = BookingDateCalculator.effectiveReturnDateStr(
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectivePickupDate = BookingDateCalculator.effectivePickupDateStr(
      pickupDate: pickupDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectivePickupTime = BookingDateCalculator.effectivePickupTime(
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectiveReturnTime = BookingDateCalculator.effectiveReturnTime(
      returnDate: returnDate,
      returnTime: returnTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );

    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: searchTerm.isEmpty ? null : searchTerm,
          type: searchType,
          startPrice: isPriceEnabled ? _priceRange.start.toInt() : null,
          endPrice: isPriceEnabled ? _priceRange.end.toInt() : null,
          pickupDate: effectivePickupDate,
          returnDate: effectiveReturnDate,
          pickupTime: effectivePickupTime,
          returnTime: effectiveReturnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    } else {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          pickupDate: effectivePickupDate,
          returnDate: effectiveReturnDate,
          pickupTime: effectivePickupTime,
          returnTime: effectiveReturnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
        ),
      );
    }
  }

  void _onSearchChanged() {
    final query = serviceSearchController.text.trim();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final effectiveReturnDate = BookingDateCalculator.effectiveReturnDateStr(
      returnDate: returnDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectivePickupDate = BookingDateCalculator.effectivePickupDateStr(
      pickupDate: pickupDate,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectivePickupTime = BookingDateCalculator.effectivePickupTime(
      pickupDate: pickupDate,
      pickupTime: pickupTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );
    final effectiveReturnTime = BookingDateCalculator.effectiveReturnTime(
      returnDate: returnDate,
      returnTime: returnTime,
      mode: coolingPeriodMode,
      coolingDays: coolingPeriodDays,
      isBooking: isBooking,
    );

    final hasFilters =
        _isPriceFilterEnabled.value || _selectedSearchTypeIndex.value != 0;

    if (query.isEmpty && !hasFilters) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: effectivePickupDate,
          returnDate: effectiveReturnDate,
          pickupTime: effectivePickupTime,
          returnTime: effectiveReturnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
          bookingId: widget.bookingId,
        ),
      );
    } else {
      final searchType =
          BookingSearchRules.resolveSearchType(_selectedSearchTypeIndex.value);
      _selectProductBloc.add(
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
          pickupDate: effectivePickupDate,
          returnDate: effectiveReturnDate,
          pickupTime: effectivePickupTime,
          returnTime: effectiveReturnTime,
          useAvailableProductsApi: !isSales,
          isSales: isSales,
          bookingId: widget.bookingId,
        ),
      );
    }
  }

  void _syncSelectedProductStock(List<ProductEntity> freshProducts) {
    final currentProducts = selectedProductsNotifier.value;
    if (currentProducts.isEmpty) return;
    final updatedProducts = ProductMapper.syncStockFromAvailability(
      currentProducts: currentProducts,
      freshProducts: freshProducts,
    );
    if (updatedProducts.toString() != currentProducts.toString()) {
      selectedProductsNotifier.value = updatedProducts;
    }
  }

  void _addProductFromSearchWithVariant(
    ProductEntity product,
    ProductVariantEntity variant,
  ) {
    final result = SelectedProductsManager.addOrIncrementFromVariant(
      currentProducts: selectedProductsNotifier.value,
      product: product,
      variant: variant,
      bookingType: selectedBookingType,
    );

    if (result.hasError) {
      context.showSnackBar(result.errorMessage!, isError: true);
      return;
    }

    selectedProductsNotifier.value = result.products;
    rebuild();
  }
}
