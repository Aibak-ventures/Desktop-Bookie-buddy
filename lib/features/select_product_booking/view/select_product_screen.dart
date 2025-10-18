import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_product_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/price_filter_tool_tip_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/service_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/view/add_or_edit_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_grid_view_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/selected_product_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectProductScreen extends StatefulWidget {
  final int serviceId;
  final String pickupDate;
  final String returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final bool useAvailableProductsApi;
  final bool isSales;
  final List<ProductSelectedModel>? preSelectedData;
  final bool availabilityCheckOnly;

  const SelectProductScreen({
    super.key,
    required this.serviceId,
    required this.pickupDate,
    required this.returnDate,
    this.preSelectedData,
    this.pickupTime,
    this.returnTime,
    this.isSales = false,
    this.useAvailableProductsApi = true,
    this.availabilityCheckOnly = false,
  });

  @override
  State<SelectProductScreen> createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  final searchController = TextEditingController();
  late final ValueNotifier<int> selectedServiceIdNotifier;
  late final ValueNotifier<MainServiceType> selectedMainServiceTypeNotifier;
  final isPriceFilterEnabled = ValueNotifier<bool>(false);
  final priceRangeNotifier = ValueNotifier(const RangeValues(0, 80000));

  @override
  void initState() {
    super.initState();
    selectedServiceIdNotifier = ValueNotifier(widget.serviceId);
    final services = context.read<ServiceBloc>().getServices();
    selectedMainServiceTypeNotifier = ValueNotifier(
      MainServiceType.fromServiceList(services, widget.serviceId),
    );

    context.read<SelectedProductsCubit>().loadPreSelected(widget.preSelectedData);

    context.read<SelectProductBloc>().add(
          SelectProductEvent.loadProducts(
            serviceId: selectedServiceIdNotifier.value,
            pickupDate: widget.pickupDate,
            returnDate: widget.returnDate,
            pickupTime: widget.pickupTime,
            returnTime: widget.returnTime,
            useAvailableProductsApi: widget.useAvailableProductsApi,
            isSales: widget.isSales,
          ),
        );
  }

  @override
  void dispose() {
    searchController.dispose();
    selectedMainServiceTypeNotifier.dispose();
    isPriceFilterEnabled.dispose();
    priceRangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth.clamp(600.0, 1600.0);
      final horizontalPadding = constraints.maxWidth > 1200 ? 120.0 : 40.0;

      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text('Select Products'),
          centerTitle: true,
          actions: [
            _selectServiceButton(),
            8.width,
            _addProductButton(),
            16.width,
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(context),
                    16.height,
                    PriceFilterToolTipWidget(
                      isPriceFilterEnabled: isPriceFilterEnabled,
                      priceRangeNotifier: priceRangeNotifier,
                      onCloseTap: () {
                        context.read<SelectProductBloc>().add(
                              SelectProductEvent.loadProducts(
                                serviceId: selectedServiceIdNotifier.value,
                                pickupDate: widget.pickupDate,
                                returnDate: widget.returnDate,
                                pickupTime: widget.pickupTime,
                                returnTime: widget.returnTime,
                                useAvailableProductsApi: widget.useAvailableProductsApi,
                              ),
                            );
                      },
                    ),
                    12.height,
                    SelectedProductListViewWidget(
                      screenHeight: constraints.maxHeight,
                      gridPadding: 20,
                      screenWidth: constraints.maxWidth,
                    ),
                    20.height,
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: SelectProductGridViewWidget(
                        gridPadding: 20,
                        searchController: searchController,
                        serviceIdNotifier: selectedServiceIdNotifier,
                        pickupDate: widget.pickupDate,
                        returnDate: widget.returnDate,
                        mainServiceTypeNotifier: selectedMainServiceTypeNotifier,
                        pickupTime: widget.pickupTime,
                        returnTime: widget.returnTime,
                        useAvailableProductsApi: widget.useAvailableProductsApi,
                        isSales: widget.isSales,
                        availabilityCheckOnly: widget.availabilityCheckOnly,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.purple.lighten(0.2),
          onPressed: _onNextPressed,
          label: const Text(
            'Next',
            style: TextStyle(color: AppColors.white),
          ),
          icon: const Icon(Icons.arrow_forward, color: AppColors.white),
        ),
      );
    });
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: selectedMainServiceTypeNotifier,
            builder: (context, selectedMainService, _) {
              return CustomProductSearchField(
                searchController: searchController,
                mainServiceType: selectedMainService,
                isPriceFilterEnabled: isPriceFilterEnabled,
                priceRangeNotifier: priceRangeNotifier,
                onChanged: (query, selectedType, priceRange, isPriceEnabled) {
                  final bloc = context.read<SelectProductBloc>();
                  if (query.isNotEmpty) {
                    bloc.add(
                      SelectProductEvent.searchProducts(
                        serviceId: selectedServiceIdNotifier.value,
                        query: query,
                        type: selectedType,
                        pickupDate: widget.pickupDate,
                        returnDate: widget.returnDate,
                        pickupTime: widget.pickupTime,
                        returnTime: widget.returnTime,
                        startPrice: isPriceEnabled ? priceRange.start.toInt() : null,
                        endPrice: isPriceEnabled ? priceRange.end.toInt() : null,
                        useAvailableProductsApi: widget.useAvailableProductsApi,
                        isSales: widget.isSales,
                      ),
                    );
                  } else {
                    bloc.add(
                      SelectProductEvent.loadProducts(
                        serviceId: selectedServiceIdNotifier.value,
                        pickupDate: widget.pickupDate,
                        returnDate: widget.returnDate,
                        pickupTime: widget.pickupTime,
                        returnTime: widget.returnTime,
                        useAvailableProductsApi: widget.useAvailableProductsApi,
                      ),
                    );
                  }
                },
                onApply: (type, priceRange, isPriceEnabled, searchQuery, searchType) {
                  context.read<SelectProductBloc>().add(
                        SelectProductEvent.searchProducts(
                          serviceId: selectedServiceIdNotifier.value,
                          pickupDate: widget.pickupDate,
                          returnDate: widget.returnDate,
                          pickupTime: widget.pickupTime,
                          returnTime: widget.returnTime,
                          startPrice: isPriceEnabled ? priceRange.start.toInt() : null,
                          endPrice: isPriceEnabled ? priceRange.end.toInt() : null,
                          query: searchQuery,
                          type: searchType,
                          useAvailableProductsApi: widget.useAvailableProductsApi,
                        ),
                      );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onNextPressed() {
    final selectedProducts = context.read<SelectedProductsCubit>().state.when(
          selected: (selected) => selected,
        );
    
    // Check if any products are selected
    if (selectedProducts.isEmpty) {
      // Show a message if no products are selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one product to continue.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    // Return the selected products to the calling screen
    context.pop(selectedProducts);
  }

  Widget _addProductButton() => _iconButton(
        icon: Icons.add,
        label: 'Add',
        onTap: () async {
          final name = await context.push<String>(AddOrEditProductScreen(
            serviceId: selectedServiceIdNotifier.value,
          ));
          if (name != null) {
            searchController.text = name;
            context.read<SelectProductBloc>().add(
                  SelectProductEvent.searchProducts(
                    serviceId: selectedServiceIdNotifier.value,
                    query: name,
                    type: 'Name',
                    pickupDate: widget.pickupDate,
                    returnDate: widget.returnDate,
                    pickupTime: widget.pickupTime,
                    returnTime: widget.returnTime,
                    useAvailableProductsApi: widget.useAvailableProductsApi,
                  ),
                );
          }
        },
      );

  Widget _selectServiceButton() => _iconButton(
        icon: Icons.category_outlined,
        onTap: _showSelectBottomSheet,
      );

  Widget _iconButton({
    required IconData icon,
    String? label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.purpleLightShade,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: AppColors.black),
                if (label != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSelectBottomSheet() async {
    final services = context.read<ServiceBloc>().getServices();
    final id = await _showSelectBottomSheetBuilder(services);
    if (id != null) {
      selectedServiceIdNotifier.value = id;
      selectedMainServiceTypeNotifier.value =
          MainServiceType.fromServiceList(services, id);
      context.read<SelectProductBloc>().add(
            SelectProductEvent.loadProducts(
              serviceId: id,
              pickupDate: widget.pickupDate,
              returnDate: widget.returnDate,
              pickupTime: widget.pickupTime,
              returnTime: widget.returnTime,
              useAvailableProductsApi: widget.useAvailableProductsApi,
            ),
          );
    }
  }

  Future<int?> _showSelectBottomSheetBuilder(List<ServicesModel> services) {
    return showCustomBottomSheet<int>(
      context,
      child: Padding(
        padding: 14.padding,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select Service', style: TextStyle(fontSize: 22.sp)),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: services
                  .map(
                    (service) => ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 120, minHeight: 50),
                      child: ServiceCardMini(
                        serviceName: service.name,
                        onTap: () => context.pop(service.id),
                        icon: service.icon,
                        isSelected: selectedServiceIdNotifier.value == service.id,
                      ),
                    ),
                  )
                  .toList(),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
