import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_product_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/price_filter_tool_tip_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/service_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_service/service_bloc.dart';
import 'package:bookie_buddy_web/features/product/view/add_or_edit_product_screen.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_grid_view_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/selected_product_list_view_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view_model/cubit_selected_products/selected_products_cubit.dart';
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
  final List<ProductSelectedModel>? preSelectedData;
  const SelectProductScreen({
    super.key,
    required this.serviceId,
    required this.pickupDate,
    required this.returnDate,
    this.preSelectedData,
    this.pickupTime,
    this.returnTime,
    this.useAvailableProductsApi = true,
  });

  @override
  _SelectProductScreenState createState() => _SelectProductScreenState();
}

class _SelectProductScreenState extends State<SelectProductScreen> {
  final searchController = TextEditingController();
  late int selectedServiceId;
  late ValueNotifier<MainServiceType> selectedMainServiceTypeNotifier;
  final isPriceFilterEnabled = ValueNotifier<bool>(false);
  final priceRangeNotifier = ValueNotifier(const RangeValues(0, 80000));
  @override
  void initState() {
    super.initState();
    selectedServiceId = widget.serviceId;
    final services = context.read<ServiceBloc>().getServices();

    selectedMainServiceTypeNotifier = ValueNotifier(
      MainServiceType.fromServiceList(services, widget.serviceId),
    );

    context
        .read<SelectedProductsCubit>()
        .loadPreSelected(widget.preSelectedData);

    context.read<SelectProductBloc>().add(
          SelectProductEvent.loadProducts(
            serviceId: selectedServiceId,
            pickupDate: widget.pickupDate,
            returnDate: widget.returnDate,
            pickupTime: widget.pickupTime,
            returnTime: widget.returnTime,
            useAvailableProductsApi: widget.useAvailableProductsApi,
          ),
        );
  }

  @override
  void dispose() {
    searchController.dispose();

    // value notifiers
    selectedMainServiceTypeNotifier.dispose();
    isPriceFilterEnabled.dispose();
    priceRangeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = context.screenWidth;
    final screenHeight = context.screenHeight;

    // Calculate responsive values
    final gridPadding = screenWidth * 0.03;

    final bloc = context.read<SelectProductBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Products'),
        actions: [
          _selectServiceButton(),
          4.width,
          _addProductButton(),
        ],
      ),
      body: Column(
        children: [
          // Search field
          ValueListenableBuilder(
              valueListenable: selectedMainServiceTypeNotifier,
              builder: (context, selectedMainService, _) {
                return CustomProductSearchField(
                  searchController: searchController,
                  mainServiceType: selectedMainService,
                  isPriceFilterEnabled: isPriceFilterEnabled,
                  priceRangeNotifier: priceRangeNotifier,
                  onChanged: (query, selectedType, priceRange, isPriceEnabled) {
                    if (query.isNotEmpty) {
                      bloc.add(
                        SelectProductEvent.searchProducts(
                          serviceId: selectedServiceId,
                          query: query,
                          type: selectedType,
                          pickupDate: widget.pickupDate,
                          returnDate: widget.returnDate,
                          pickupTime: widget.pickupTime,
                          returnTime: widget.returnTime,
                          startPrice:
                              isPriceEnabled ? priceRange.start.toInt() : null,
                          endPrice:
                              isPriceEnabled ? priceRange.end.toInt() : null,
                          useAvailableProductsApi:
                              widget.useAvailableProductsApi,
                        ),
                      );
                    } else {
                      bloc.add(
                        SelectProductEvent.loadProducts(
                          serviceId: selectedServiceId,
                          pickupDate: widget.pickupDate,
                          returnDate: widget.returnDate,
                          pickupTime: widget.pickupTime,
                          returnTime: widget.returnTime,
                          useAvailableProductsApi:
                              widget.useAvailableProductsApi,
                        ),
                      );
                    }
                  },
                  onApply: (type, priceRange, isPriceEnabled, searchQuery,
                      searchType) {
                    bloc.add(
                      SelectProductEvent.searchProducts(
                        serviceId: selectedServiceId,
                        pickupDate: widget.pickupDate,
                        returnDate: widget.returnDate,
                        pickupTime: widget.pickupTime,
                        returnTime: widget.returnTime,
                        startPrice:
                            isPriceEnabled ? priceRange.start.toInt() : null,
                        endPrice:
                            isPriceEnabled ? priceRange.end.toInt() : null,
                        query: searchQuery,
                        type: searchType,
                        useAvailableProductsApi: widget.useAvailableProductsApi,
                      ),
                    );
                  },
                );
              }),

          PriceFilterToolTipWidget(
            isPriceFilterEnabled: isPriceFilterEnabled,
            priceRangeNotifier: priceRangeNotifier,
            onCloseTap: () {
              context.read<SelectProductBloc>().add(
                    SelectProductEvent.loadProducts(
                      serviceId: selectedServiceId,
                      pickupDate: widget.pickupDate,
                      returnDate: widget.returnDate,
                      pickupTime: widget.pickupTime,
                      returnTime: widget.returnTime,
                      useAvailableProductsApi: widget.useAvailableProductsApi,
                    ),
                  );
            },
          ),

          // Selected product list view builder
          SelectedProductListViewWidget(
            screenHeight: screenHeight,
            gridPadding: gridPadding,
            screenWidth: screenWidth,
          ),

          // Grid View with responsive sizing
          SelectProductGridViewWidget(
            gridPadding: gridPadding,
            searchController: searchController,
            serviceId: selectedServiceId,
            pickupDate: widget.pickupDate,
            returnDate: widget.returnDate,
            mainServiceTypeNotifier: selectedMainServiceTypeNotifier,
            pickupTime: widget.pickupTime,
            returnTime: widget.returnTime,
            useAvailableProductsApi: widget.useAvailableProductsApi,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purple.lighten(0.2),
        onPressed: () {
          final selectedProductsWithAmount =
              context.read<SelectedProductsCubit>().state.when(
                    selected: (selected) => selected,
                  );

          context.pop(selectedProductsWithAmount);
        },
        child: const Icon(
          Icons.arrow_forward,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _addProductButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.purpleLightShade,
        borderRadius: 5.radiusBorder,
      ),
      padding: 8.padding,
      child: Row(
        children: [
          const Icon(
            Icons.add,
          ),
          4.width,
          Text(
            'Add',
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    ).onTap(
      () async {
        final name = await context.push<String>(AddOrEditProductScreen(
          serviceId: selectedServiceId,
        ));
        log('name: $name');
        if (name != null) {
          searchController.text = name;
          context.read<SelectProductBloc>().add(
                SelectProductEvent.searchProducts(
                  serviceId: selectedServiceId,
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
  }

  Widget _selectServiceButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.purpleLightShade,
        borderRadius: 5.radiusBorder,
      ),
      padding: 8.padding,
      child: const Icon(
        Icons.category_outlined,
      ),
    ).onTap(
      _showSelectBottomSheet,
    );
  }

  void _showSelectBottomSheet() async {
    final services = context.read<ServiceBloc>().getServices();
    final id = await _showSelectBottomSheetBuilder(services);

    if (id != null) {
      selectedServiceId = id;

      selectedMainServiceTypeNotifier.value =
          MainServiceType.fromServiceList(services, selectedServiceId);
      log(selectedMainServiceTypeNotifier.value.toString());
      context.read<SelectProductBloc>().add(
            SelectProductEvent.loadProducts(
              serviceId: selectedServiceId,
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
            Text(
              'Select Service',
              style: TextStyle(
                fontSize: 22.sp,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                children: services
                    .map(
                      (service) => ServiceCardMini(
                        serviceName: service.name,
                        onTap: () => context.pop(service.id),
                        icon: service.icon,
                        isSelected: selectedServiceId == service.id,
                      ),
                    )
                    .toList(),
              ),
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}
