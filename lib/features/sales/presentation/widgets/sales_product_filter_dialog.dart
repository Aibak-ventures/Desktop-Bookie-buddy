import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Result returned by [SalesProductFilterDialog] when the user taps Apply.
class SalesFilterResult {
  final int? serviceId;
  final MainServiceType? serviceType;
  final List<String> searchTypes;
  final int searchTypeIndex;
  final bool isPriceFilterEnabled;
  final RangeValues priceRange;
  final double maxPrice;

  const SalesFilterResult({
    required this.serviceId,
    required this.serviceType,
    required this.searchTypes,
    required this.searchTypeIndex,
    required this.isPriceFilterEnabled,
    required this.priceRange,
    required this.maxPrice,
  });
}

/// Product search & filter dialog for [EditSalesScreen].
///
/// Pops with a [SalesFilterResult] when the user taps Apply, or null on Cancel.
class SalesProductFilterDialog extends StatefulWidget {
  final int? initialServiceId;
  final MainServiceType? initialServiceType;
  final List<String> initialSearchTypes;
  final int initialSearchTypeIndex;
  final bool initialIsPriceFilterEnabled;
  final RangeValues initialPriceRange;
  final double initialMaxPrice;

  const SalesProductFilterDialog({
    super.key,
    required this.initialServiceId,
    required this.initialServiceType,
    required this.initialSearchTypes,
    required this.initialSearchTypeIndex,
    required this.initialIsPriceFilterEnabled,
    required this.initialPriceRange,
    required this.initialMaxPrice,
  });

  @override
  State<SalesProductFilterDialog> createState() =>
      _SalesProductFilterDialogState();
}

class _SalesProductFilterDialogState extends State<SalesProductFilterDialog> {
  late int? _serviceId;
  late MainServiceType? _serviceType;
  late List<String> _searchTypes;
  late final ValueNotifier<int> _searchTypeIndex;
  late final ValueNotifier<bool> _isPriceEnabled;
  late final ValueNotifier<RangeValues> _priceRange;
  late final ValueNotifier<double> _maxPrice;
  late final TextEditingController _maxPriceController;

  @override
  void initState() {
    super.initState();
    _serviceId = widget.initialServiceId;
    _serviceType = widget.initialServiceType;
    _searchTypes = List.of(widget.initialSearchTypes);
    _searchTypeIndex = ValueNotifier(widget.initialSearchTypeIndex);
    _isPriceEnabled = ValueNotifier(widget.initialIsPriceFilterEnabled);
    _priceRange = ValueNotifier(widget.initialPriceRange);
    _maxPrice = ValueNotifier(widget.initialMaxPrice);
    _maxPriceController =
        TextEditingController(text: widget.initialMaxPrice.toInt().toString());
  }

  @override
  void dispose() {
    _searchTypeIndex.dispose();
    _isPriceEnabled.dispose();
    _priceRange.dispose();
    _maxPrice.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _reset() {
    setState(() {
      _searchTypeIndex.value = 0;
      _isPriceEnabled.value = false;
      _maxPrice.value = widget.initialMaxPrice;
      _maxPriceController.text = widget.initialMaxPrice.toInt().toString();
      _priceRange.value = RangeValues(0, widget.initialMaxPrice);
    });
  }

  void _apply() {
    Navigator.of(context).pop(
      SalesFilterResult(
        serviceId: _serviceId,
        serviceType: _serviceType,
        searchTypes: _searchTypes,
        searchTypeIndex: _searchTypeIndex.value,
        isPriceFilterEnabled: _isPriceEnabled.value,
        priceRange: _priceRange.value,
        maxPrice: _maxPrice.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServiceSection(),
                    _buildSearchTypeSection(),
                    _buildPriceSection(),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6132E4).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune_rounded,
                color: Color(0xFF6132E4), size: 22),
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
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceSection() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, serviceState) {
        List<ServiceEntity> services = [];
        serviceState.whenOrNull(loaded: (s) => services = s);
        services = services
            .where((s) =>
                !s.mainServiceName.toLowerCase().contains('material'))
            .toList();

        if (services.isEmpty) return const SizedBox.shrink();

        final allOptions = [
          {'id': -1, 'name': 'All Services'},
          ...services.map((s) => {'id': s.id, 'name': s.name}),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category (Service)',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                  fontFamily: 'Inter'),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: allOptions.map((option) {
                final id = option['id'] as int;
                final name = option['name'] as String;
                final isSelected = _serviceId == id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _serviceId = id;
                      if (id == -1) {
                        _serviceType = null;
                        _searchTypes = ['Name', 'Category', 'Model', 'Color'];
                      } else {
                        final service = services.firstWhere(
                          (s) => s.id == id,
                          orElse: () => services.first,
                        );
                        _serviceType = MainServiceType.fromString(
                            service.mainServiceName);
                        final catLabel = _serviceType!.categoryFieldLabel;
                        final secLabel =
                            _serviceType!.secondaryAttributeLabel ?? 'Color';
                        if (_serviceType!.isMultiVariantProductType) {
                          _searchTypes = [
                            'Name',
                            catLabel,
                            secLabel,
                            _serviceType!.variantAttributeLabel,
                          ];
                        } else {
                          _searchTypes = ['Name', catLabel, secLabel, 'Color'];
                        }
                      }
                      if (_searchTypeIndex.value >= _searchTypes.length) {
                        _searchTypeIndex.value = 0;
                      }
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
                                color: const Color(0xFF6132E4)
                                    .withValues(alpha: 0.3),
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
                            child: Icon(Icons.check_circle_rounded,
                                color: Colors.white, size: 16),
                          ),
                        Text(
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
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            const Divider(height: 1),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildSearchTypeSection() {
    const searchTypes = ['Name', 'Category', 'Model', 'Color'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search Type',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
              fontFamily: 'Inter'),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _searchTypeIndex,
          builder: (context, selectedIndex, _) => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: searchTypes.asMap().entries.map((entry) {
              final index = entry.key;
              final type = entry.value;
              final isSelected = selectedIndex == index;
              return InkWell(
                onTap: () => _searchTypeIndex.value = index,
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
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
                              color: const Color(0xFF6132E4)
                                  .withValues(alpha: 0.3),
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
                          child: Icon(Icons.check_circle_rounded,
                              color: Colors.white, size: 16),
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
          ),
        ),
        const SizedBox(height: 24),
        const Divider(height: 1),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Price Range',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D2D2D),
                  fontFamily: 'Inter'),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _isPriceEnabled,
              builder: (_, isEnabled, __) => Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: isEnabled,
                  onChanged: (v) => _isPriceEnabled.value = v,
                  activeThumbColor: const Color(0xFF6132E4),
                  activeTrackColor:
                      const Color(0xFF6132E4).withValues(alpha: 0.3),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isPriceEnabled,
          builder: (_, isEnabled, __) => AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isEnabled
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text('Set Max Price',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D2D2D),
                              fontFamily: 'Inter')),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.grey.shade300),
                              ),
                              child: TextField(
                                controller: _maxPriceController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Enter max price',
                                  prefixText: '₹ ',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                ),
                                style: const TextStyle(
                                    fontSize: 14, fontFamily: 'Inter'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final newMax = double.tryParse(
                                  _maxPriceController.text.trim());
                              if (newMax != null && newMax > 0) {
                                _maxPrice.value = newMax;
                                _priceRange.value = RangeValues(0, newMax);
                                _maxPriceController.clear();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              backgroundColor: const Color(0xFF6132E4),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Set',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<RangeValues>(
                        valueListenable: _priceRange,
                        builder: (_, range, __) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text('₹${range.start.round()}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Inter')),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              child: Icon(Icons.arrow_forward,
                                  size: 18, color: Colors.grey.shade400),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  const Color(0xFF6132E4)
                                      .withValues(alpha: 0.1),
                                  const Color(0xFF6132E4)
                                      .withValues(alpha: 0.05),
                                ]),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0xFF6132E4)
                                        .withValues(alpha: 0.3)),
                              ),
                              child: Text('₹${range.end.round()}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6132E4),
                                      fontFamily: 'Inter')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      ValueListenableBuilder<RangeValues>(
                        valueListenable: _priceRange,
                        builder: (_, range, __) =>
                            ValueListenableBuilder<double>(
                          valueListenable: _maxPrice,
                          builder: (_, maxPrice, __) => SliderTheme(
                            data: SliderThemeData(
                              activeTrackColor: const Color(0xFF6132E4),
                              inactiveTrackColor: Colors.grey.shade200,
                              thumbColor: const Color(0xFF6132E4),
                              overlayColor: const Color(0xFF6132E4)
                                  .withValues(alpha: 0.2),
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8),
                              overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 16),
                            ),
                            child: RangeSlider(
                              values: range,
                              min: 0,
                              max: maxPrice,
                              divisions: 20,
                              onChanged: (v) => _priceRange.value = v,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(20)),
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _reset,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Reset',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                      fontFamily: 'Inter')),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _apply,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xFF6132E4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check, size: 18),
                  SizedBox(width: 8),
                  Text('Apply Filters',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
