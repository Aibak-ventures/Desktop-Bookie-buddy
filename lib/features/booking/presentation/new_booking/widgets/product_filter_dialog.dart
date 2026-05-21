part of '../pages/new_booking_screen.dart';

extension ProductFilterDialogBuilders on NewBookingScreenState {
  void _showProductFilterBottomSheet() {
    // Calculate max price from current product list
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

    // Get services for filter
    final servicesState = context.read<ServiceBloc>().state;
    List<ServiceEntity> services = [];
    servicesState.whenOrNull(loaded: (s) => services = s);

    // Filter out material services for booking/sales
    services = services
        .where((s) => !s.mainServiceName.toLowerCase().contains('material'))
        .toList();

    // Setup local state for dialog
    final isPriceFilterEnabledWidgetNotifier = ValueNotifier(
      _isPriceFilterEnabled.value,
    );
    final tempSelectedServiceId = ValueNotifier<int?>(selectedServiceId);
    final tempSelectedSearchTypeIndex = ValueNotifier<int>(
      _selectedSearchTypeIndex.value,
    );
    final tempPriceRange = ValueNotifier<RangeValues>(_priceRange.value);
    final tempMaxPriceNotifier = ValueNotifier<double>(_maxPriceNotifier.value);
    final maxPriceController = TextEditingController(
      text: _maxPriceNotifier.value.toInt().toString(),
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 500,
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6132E4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Color(0xFF6132E4),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Search & Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Selection Section
                      const Text(
                        'Category (Service)',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<int?>(
                        valueListenable: tempSelectedServiceId,
                        builder: (context, selectedId, _) {
                          final allOptions = [
                            {'id': -1, 'name': 'All Services'},
                            ...services.map(
                              (s) => {'id': s.id, 'name': s.name},
                            ),
                          ];

                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: allOptions.map((option) {
                              final id = option['id'] as int;
                              final name = option['name'] as String;
                              final isSelected =
                                  selectedId == id ||
                                  (selectedId == null && id == -1);

                              return InkWell(
                                onTap: () {
                                  tempSelectedServiceId.value = id;
                                  if (id == -1) {
                                    _currentServiceType = null;
                                    _searchTypes = [
                                      'Name',
                                      'Category',
                                      'Model',
                                      'Color',
                                    ];
                                  } else {
                                    final service = services.firstWhere(
                                      (s) => s.id == id,
                                      orElse: () => services.first,
                                    );
                                    _currentServiceType =
                                        MainServiceType.fromString(
                                          service.mainServiceName,
                                        );

                                    final categoryLabel = _currentServiceType
                                        .categoryFieldLabel;
                                    final secondaryLabel =
                                        _currentServiceType
                                            .secondaryAttributeLabel ??
                                        'Color';

                                    if (_currentServiceType
                                        .isMultiVariantProductType) {
                                      final variantLabel = _currentServiceType
                                          .variantAttributeLabel;
                                      _searchTypes = [
                                        'Name',
                                        categoryLabel,
                                        secondaryLabel,
                                        variantLabel,
                                      ];
                                    } else {
                                      _searchTypes = [
                                        'Name',
                                        categoryLabel,
                                        secondaryLabel,
                                        'Color',
                                      ];
                                    }
                                  }
                                  if (tempSelectedSearchTypeIndex.value >=
                                      _searchTypes.length) {
                                    tempSelectedSearchTypeIndex.value = 0;
                                  }
                                  final currentIndex =
                                      tempSelectedSearchTypeIndex.value;
                                  tempSelectedSearchTypeIndex.value = -1;
                                  tempSelectedSearchTypeIndex.value =
                                      currentIndex;
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF6132E4)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF6132E4,
                                              ).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.grey.shade700,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Search Type Section
                      const Text(
                        'Search Type',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 12),
                      ValueListenableBuilder<int>(
                        valueListenable: tempSelectedSearchTypeIndex,
                        builder: (context, selectedIndex, child) {
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _searchTypes.asMap().entries.map((entry) {
                              final index = entry.key;
                              final type = entry.value;
                              final isSelected = selectedIndex == index;
                              return InkWell(
                                onTap: () =>
                                    tempSelectedSearchTypeIndex.value = index,
                                borderRadius: BorderRadius.circular(12),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF6132E4)
                                        : Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6132E4)
                                          : Colors.grey.shade300,
                                      width: 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: const Color(
                                                0xFF6132E4,
                                              ).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isSelected)
                                        const Padding(
                                          padding: EdgeInsets.only(right: 6),
                                          child: Icon(
                                            Icons.check_circle_rounded,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      Text(
                                        type,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey.shade700,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      const Divider(height: 1),
                      const SizedBox(height: 24),

                      // Price Filter Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price Range',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                              fontFamily: 'Inter',
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: isPriceFilterEnabledWidgetNotifier,
                            builder: (context, isEnabled, child) =>
                                Transform.scale(
                                  scale: 0.85,
                                  child: Switch(
                                    value: isEnabled,
                                    onChanged: (value) {
                                      isPriceFilterEnabledWidgetNotifier.value =
                                          value;
                                    },
                                    activeThumbColor: const Color(0xFF6132E4),
                                    activeTrackColor: const Color(
                                      0xFF6132E4,
                                    ).withOpacity(0.3),
                                    inactiveThumbColor: Colors.grey.shade400,
                                    inactiveTrackColor: Colors.grey.shade200,
                                  ),
                                ),
                          ),
                        ],
                      ),

                      // Price Range Content
                      ValueListenableBuilder<bool>(
                        valueListenable: isPriceFilterEnabledWidgetNotifier,
                        builder: (context, isEnabled, child) => AnimatedSize(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: isEnabled
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    // Max Price Editor
                                    Row(
                                      children: [
                                        const Text(
                                          'Maximum Price',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF6B6B6B),
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 130,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8F9FA),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: maxPriceController,
                                            keyboardType: TextInputType.number,
                                            onTapOutside: (_) {
                                              FocusScope.of(context).unfocus();
                                            },
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Inter',
                                            ),
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                              isDense: true,
                                              prefixText: '₹ ',
                                              prefixStyle: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF6132E4),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                final newMaxPrice =
                                                    double.tryParse(value);
                                                if (newMaxPrice != null) {
                                                  tempMaxPriceNotifier.value =
                                                      newMaxPrice;
                                                  if (tempPriceRange.value.end >
                                                      newMaxPrice) {
                                                    tempPriceRange.value =
                                                        RangeValues(
                                                          tempPriceRange
                                                                      .value
                                                                      .start >
                                                                  newMaxPrice
                                                              ? 0
                                                              : tempPriceRange
                                                                    .value
                                                                    .start,
                                                          newMaxPrice,
                                                        );
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // Price Range Display
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.1),
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF6132E4,
                                                ).withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.start.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.1),
                                                  const Color(
                                                    0xFF6132E4,
                                                  ).withOpacity(0.05),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: const Color(
                                                  0xFF6132E4,
                                                ).withOpacity(0.3),
                                              ),
                                            ),
                                            child: Text(
                                              range.end.toCurrency(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF6132E4),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    // Price Range Slider
                                    ValueListenableBuilder<RangeValues>(
                                      valueListenable: tempPriceRange,
                                      builder: (context, range, child) =>
                                          ValueListenableBuilder<double>(
                                            valueListenable:
                                                tempMaxPriceNotifier,
                                            builder: (
                                              context,
                                              currentMaxPrice,
                                              child,
                                            ) => SliderTheme(
                                              data: SliderThemeData(
                                                activeTrackColor:
                                                    const Color(0xFF6132E4),
                                                inactiveTrackColor:
                                                    Colors.grey.shade200,
                                                thumbColor: const Color(
                                                  0xFF6132E4,
                                                ),
                                                overlayColor: const Color(
                                                  0xFF6132E4,
                                                ).withOpacity(0.2),
                                                trackHeight: 4,
                                                thumbShape:
                                                    const RoundSliderThumbShape(
                                                      enabledThumbRadius: 8,
                                                    ),
                                                overlayShape:
                                                    const RoundSliderOverlayShape(
                                                      overlayRadius: 16,
                                                    ),
                                              ),
                                              child: RangeSlider(
                                                values: range,
                                                min: 0,
                                                max: currentMaxPrice,
                                                divisions: 20,
                                                onChanged:
                                                    (RangeValues newRange) {
                                                      tempPriceRange.value =
                                                          newRange;
                                                    },
                                              ),
                                            ),
                                          ),
                                    ),

                                    const SizedBox(height: 20),

                                    // Quick Filters
                                    const Text(
                                      'Quick Filters',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2D2D2D),
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    ValueListenableBuilder<double>(
                                      valueListenable: tempMaxPriceNotifier,
                                      builder: (context, currentMaxPrice, child) {
                                        final quickFilters =
                                            PaymentCalculator.generateQuickFilters(
                                              minPrice: 0,
                                              maxPrice: currentMaxPrice,
                                            );

                                        return Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: quickFilters
                                              .map(
                                                (filter) =>
                                                    _buildQuickFilterChip(
                                                      filter['label'],
                                                      filter['range'],
                                                      tempPriceRange,
                                                      (val) =>
                                                          tempPriceRange.value =
                                                              val,
                                                    ),
                                              )
                                              .toList(),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade200, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          tempSelectedSearchTypeIndex.value = 0;
                          tempSelectedServiceId.value = -1;
                          tempMaxPriceNotifier.value = _maxPriceNotifier.value;
                          maxPriceController.text = _maxPriceNotifier.value
                              .toInt()
                              .toString();
                          tempPriceRange.value = RangeValues(
                            0,
                            tempMaxPriceNotifier.value,
                          );
                          isPriceFilterEnabledWidgetNotifier.value = false;
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedServiceId = tempSelectedServiceId.value;
                            _selectedSearchTypeIndex.value =
                                tempSelectedSearchTypeIndex.value;
                            _priceRange.value = tempPriceRange.value;
                            _maxPriceNotifier.value =
                                tempMaxPriceNotifier.value;
                            _isPriceFilterEnabled.value =
                                isPriceFilterEnabledWidgetNotifier.value;
                            _updateSearchTypesForService(selectedServiceId);
                          });

                          Navigator.of(context).pop();

                          _applyProductFilters(
                            _selectedSearchTypeIndex.value,
                            _priceRange.value,
                            _isPriceFilterEnabled.value,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: const Color(0xFF6132E4),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor:
                              const Color(0xFF6132E4).withOpacity(0.3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Apply Filters',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFilterChip(
    String label,
    RangeValues range,
    ValueNotifier<RangeValues> currentRange,
    void Function(RangeValues) onChanged,
  ) => ValueListenableBuilder<RangeValues>(
    valueListenable: currentRange,
    builder: (context, current, child) {
      final isSelected =
          current.start == range.start && current.end == range.end;

      return GestureDetector(
        onTap: () {
          currentRange.value = range;
          onChanged(range);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF6132E4)
                  : Colors.grey.shade300,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.grey.shade700,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      );
    },
  );

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

    final searchType = BookingSearchRules.resolveSearchType(
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
