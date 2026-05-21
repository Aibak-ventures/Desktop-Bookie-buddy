part of '../pages/new_booking_screen.dart';

extension ProductSearchBuilders on NewBookingScreenState {
  // Update search type labels when the active service changes
  void _updateSearchTypesForService(int? serviceId) {
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    if (serviceId == null || serviceId == -1) {
      _currentServiceType = null;
      _searchTypes = ['Name', 'Category', 'Model', 'Color'];
    } else {
      final service = services.firstWhere(
        (s) => s.id == serviceId,
        orElse: () => services.first,
      );
      _currentServiceType = MainServiceType.fromString(service.mainServiceName);

      final categoryLabel = _currentServiceType.categoryFieldLabel;
      final secondaryLabel =
          _currentServiceType.secondaryAttributeLabel ?? 'Color';

      if (_currentServiceType.isMultiVariantProductType) {
        final variantLabel = _currentServiceType.variantAttributeLabel;
        _searchTypes = ['Name', categoryLabel, secondaryLabel, variantLabel];
      } else {
        _searchTypes = ['Name', categoryLabel, secondaryLabel, 'Color'];
      }
    }
  }

  void _removeSearchOverlay() {
    _searchOverlayEntry?.remove();
    _searchOverlayEntry = null;
    _showAllProductsOnSearchFocus = false;
    _overlayProducts.value = [];
    _overlayIsLoading.value = false;
  }

  void _handleSearchOverlayScroll() {
    if (!_searchResultsScrollController.hasClients) return;
    final position = _searchResultsScrollController.position;
    if (position.pixels < position.maxScrollExtent - 180) return;
    _selectProductBloc.state.maybeWhen(
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
              _selectProductBloc.add(
                const SelectProductEvent.loadNextSearchResults(),
              );
            } else {
              _selectProductBloc.add(
                const SelectProductEvent.loadNextPageProducts(),
              );
            }
          },
      orElse: () {},
    );
  }

  void _searchAllProductsForOverlay() {
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    _showAllProductsOnSearchFocus = true;
    _overlayIsLoading.value = true;
    if (_searchOverlayEntry == null) {
      _showSearchOverlay();
    }

    _selectProductBloc.add(
      SelectProductEvent.searchProducts(
        serviceId: serviceIdToUse,
        query: '',
        type: 'name',
        startPrice: _isPriceFilterEnabled.value
            ? _priceRange.value.start.round()
            : null,
        endPrice: _isPriceFilterEnabled.value
            ? _priceRange.value.end.round()
            : null,
        pickupDate: pickupDate.format(),
        returnDate: effectiveReturnDate,
        pickupTime: pickupTime,
        returnTime: returnTime,
        useAvailableProductsApi: isBooking,
        isSales: isSales,
      ),
    );
  }

  void _onSearchChanged([String? newValue]) {
    final query = (newValue ?? serviceSearchController.text)
        .trim()
        .toLowerCase();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;
    final serviceIdToUse =
        (selectedServiceId == null || selectedServiceId == -1)
        ? null
        : selectedServiceId;

    final hasSearchQuery = query.isNotEmpty;
    final hasPriceFilter = _isPriceFilterEnabled.value;
    final hasAnyFilter = hasSearchQuery || hasPriceFilter;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    if (!hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: serviceIdToUse,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    } else {
      final searchType = BookingSearchRules.resolveSearchType(
            _selectedSearchTypeIndex.value,
            serviceType: _currentServiceType,
          ) ??
          'name';

      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: serviceIdToUse,
          query: hasSearchQuery ? query : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: hasPriceFilter ? _priceRange.value.start.round() : null,
          endPrice: hasPriceFilter ? _priceRange.value.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }

  /// Perform a quick local filter on the currently loaded products
  /// and show results immediately in the overlay.
  void _showLocalFilteredResults(String rawQuery) {
    final q = rawQuery.toLowerCase();

    final currentProducts = _selectProductBloc.state.maybeWhen(
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
          ) => products,
      orElse: () => <ProductEntity>[],
    );

    if (currentProducts.isEmpty) return;

    final filtered = currentProducts.where((p) {
      final name = p.name.toLowerCase();
      final color = p.color?.toLowerCase() ?? '';
      final category = p.category?.toLowerCase() ?? '';
      final model = p.model?.toLowerCase() ?? '';
      final variantMatch = p.variants.any(
        (v) => v.attribute.toLowerCase().contains(q),
      );

      return name.contains(q) ||
          color.contains(q) ||
          category.contains(q) ||
          model.contains(q) ||
          variantMatch;
    }).toList();

    _overlayIsLoading.value = false;
    _overlayProducts.value = filtered;
    if (_searchOverlayEntry == null) {
      _showSearchOverlay();
    }
  }

  Widget _buildProductSearchBar() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        return BlocListener<SelectProductBloc, SelectProductState>(
          bloc: _selectProductBloc,
          listener: (context, state) {
            final hasQuery =
                serviceSearchController.text.isNotEmpty ||
                _showAllProductsOnSearchFocus;
            final hasFilters =
                _isPriceFilterEnabled.value ||
                _selectedSearchTypeIndex.value != 0;
            final hasAnyFilter = hasQuery || hasFilters;

            state.maybeWhen(
              loading: () {
                if (hasAnyFilter) {
                  _overlayIsLoading.value = true;
                  if (_searchOverlayEntry == null) {
                    _showSearchOverlay();
                  }
                }
              },
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
                    if (hasAnyFilter || (products.isNotEmpty && isSearching)) {
                      _overlayIsLoading.value = false;
                      _overlayProducts.value = products;
                      if (_searchOverlayEntry == null) {
                        _showSearchOverlay();
                      }
                    } else {
                      _removeSearchOverlay();
                    }
                  },
              error: (_) {
                _overlayIsLoading.value = false;
                _overlayProducts.value = [];
                if (hasAnyFilter) {
                  if (_searchOverlayEntry == null) {
                    _showSearchOverlay();
                  }
                } else {
                  _removeSearchOverlay();
                }
              },
              orElse: () {
                if (!hasAnyFilter) _removeSearchOverlay();
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
            selectedSearchTypeIndex: _selectedSearchTypeIndex,
            isPriceFilterEnabled: _isPriceFilterEnabled,
            searchTypes: _searchTypes,
            onTap: () {
              if (serviceSearchController.text.trim().isEmpty) {
                _searchAllProductsForOverlay();
              }
            },
            onChanged: (value) {
              if (value.trim().isNotEmpty && _showAllProductsOnSearchFocus) {
                _showAllProductsOnSearchFocus = false;
              }
              _onSearchChanged(value);
              if (value.isEmpty) {
                _removeSearchOverlay();
              } else if (value.trim().length == 1) {
                _showLocalFilteredResults(value.trim());
              }
            },
            onFilterTap: () {
              _removeSearchOverlay();
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
              services = services
                  .where(
                    (s) => !s.mainServiceName.toLowerCase().contains(
                      'material',
                    ),
                  )
                  .toList();
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
                  computeSearchTypes: (serviceId) {
                    _updateSearchTypesForService(serviceId);
                    return _searchTypes;
                  },
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
                      _updateSearchTypesForService(serviceId);
                    });
                    _applyProductFilters(
                      searchTypeIndex,
                      priceRange,
                      isPriceFilterEnabled,
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showSearchOverlay() {
    if (_searchOverlayEntry != null) return;

    _searchOverlayEntry = OverlayEntry(
      builder: (context) => ProductSearchOverlayPopup(
        layerLink: _searchLayerLink,
        isLoading: _overlayIsLoading,
        products: _overlayProducts,
        scrollController: _searchResultsScrollController,
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
        _addProductFromSearchWithVariant(product, selectedVariant);
        _removeSearchOverlay();
        serviceSearchController.clear();
        _clientNameFocusNode.requestFocus();
      },
      onArrowDown: () {
        if (index + 1 < itemCount) {
          _getOverlayItemFocusNode(index + 1).requestFocus();
        }
      },
      onArrowUp: () {
        if (index > 0) {
          _getOverlayItemFocusNode(index - 1).requestFocus();
        } else {
          _productSearchFocusNode.requestFocus();
        }
      },
      onEscape: () {
        _removeSearchOverlay();
        serviceSearchController.clear();
        _productSearchFocusNode.requestFocus();
      },
      onImageTap: (imageUrl, title) async {
        final cachedProducts = List<ProductEntity>.from(_overlayProducts.value);
        _removeSearchOverlay();
        await ZoomableImageDialog.show(
          context,
          imageUrl: imageUrl,
          title: title,
        );
        if (mounted && cachedProducts.isNotEmpty) {
          _overlayProducts.value = cachedProducts;
          _showSearchOverlay();
        }
      },
    );
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
    setState(() {});
  }

  FocusNode _getOverlayItemFocusNode(int index) {
    return _overlayItemFocusNodes.putIfAbsent(index, FocusNode.new);
  }

  void _applyProductFilters(
    int searchTypeIndex,
    RangeValues priceRange,
    bool isPriceEnabled,
  ) {
    _isPriceFilterEnabled.value = isPriceEnabled;
    final searchTerm = serviceSearchController.text.trim().toLowerCase();
    final isSales = selectedBookingType == BookingType.sales;
    final isBooking = selectedBookingType == BookingType.booking;

    final effectiveReturnDate = isBooking && coolingPeriodMode.isAfter
        ? returnDate.add(Duration(days: coolingPeriodDays)).format()
        : returnDate.format();

    final searchType =
        BookingSearchRules.resolveSearchType(
          searchTypeIndex,
          serviceType: _currentServiceType,
        ) ??
        'name';

    final hasSearchQuery = searchTerm.isNotEmpty;
    final hasAnyFilter = hasSearchQuery || isPriceEnabled;

    if (hasAnyFilter) {
      _selectProductBloc.add(
        SelectProductEvent.searchProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          query: hasSearchQuery ? searchTerm : null,
          type: hasSearchQuery ? searchType : null,
          startPrice: isPriceEnabled ? priceRange.start.round() : null,
          endPrice: isPriceEnabled ? priceRange.end.round() : null,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    } else {
      _selectProductBloc.add(
        SelectProductEvent.loadProducts(
          serviceId: selectedServiceId == -1 ? null : selectedServiceId,
          pickupDate: pickupDate.format(),
          returnDate: effectiveReturnDate,
          pickupTime: pickupTime,
          returnTime: returnTime,
          useAvailableProductsApi: selectedBookingType == BookingType.booking,
          isSales: isSales,
        ),
      );
    }
  }
}
