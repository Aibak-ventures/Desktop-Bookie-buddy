import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/bloc_select_product/select_product_bloc.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/view_model/cubit_selected_products/selected_products_cubit.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_card.dart';
import 'package:bookie_buddy_web/features/select_product_booking/view/widgets/select_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectProductGridViewWidget extends StatelessWidget {
  const SelectProductGridViewWidget({
    super.key,
    required this.gridPadding,
    required this.searchController,
    required this.serviceIdNotifier,
    required this.pickupDate,
    required this.returnDate,
    required this.mainServiceTypeNotifier,
    this.pickupTime,
    this.returnTime,
    required this.useAvailableProductsApi,
    required this.isSales,
    required this.availabilityCheckOnly,
  });

  final ValueNotifier<int> serviceIdNotifier;
  final String pickupDate;
  final String returnDate;
  final TimeOfDay? pickupTime;
  final TimeOfDay? returnTime;
  final double gridPadding;
  final TextEditingController searchController;
  final ValueNotifier<MainServiceType> mainServiceTypeNotifier;
  final bool isSales;
  final bool useAvailableProductsApi;
  final bool availabilityCheckOnly;

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    final gridSpacing = screenWidth * 0.02;
    int crossAxisCount = 2;
    double aspectRatio = availabilityCheckOnly ? 0.68 : 0.66;

    // Adjust layout for larger web screens
    if (context.isTablet) {
      crossAxisCount = 3;
      aspectRatio = 0.7;
    } else if (context.isDesktop) {
      crossAxisCount = 5; // Slightly wider for web
      aspectRatio = 0.8;
    }

    final cubit = context.read<SelectedProductsCubit>();

    return Expanded(
      child: RefreshIndicator.adaptive(
        onRefresh: () async => _onRefresh(context),
        child: BlocBuilder<SelectProductBloc, SelectProductState>(
          builder: (context, state) => state.when(
            loading: () => GridView.builder(
              padding: EdgeInsets.all(gridPadding),
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) =>
                  SelectProductCardShimmer(needAddButton: !availabilityCheckOnly),
            ),
            error: (error) => SingleChildScrollView(
              child: CustomErrorWidget(
                height: 0.25,
                errorText: error,
                onRetry: () => _onRefresh(context),
              ),
            ),
            loaded: (
              products,
              nextPageUrl,
              unused1,
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
              unused2,
              unused3,
            ) =>
                products.isEmpty
                    ? isSearching
                        ? const NoResultFoundAnimationWidget(adjustHeightTop: 0.15)
                        : const NoProductFoundAnimationWidget(adjustHeightTop: 0.15)
                    : NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 200 &&
                              nextPageUrl != null &&
                              !isPaginating) {
                            if (isSearching) {
                              context.read<SelectProductBloc>().add(
                                    const SelectProductEvent.loadNextSearchResults(),
                                  );
                            } else {
                              context.read<SelectProductBloc>().add(
                                    const SelectProductEvent.loadNextPageProducts(),
                                  );
                            }
                          }
                          return false;
                        },
                        child: GridView.builder(
                          key: const PageStorageKey('select-product-grid-list'),
                          padding: EdgeInsets.all(gridPadding),
                          itemCount: products.length + 1,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: gridSpacing,
                            mainAxisSpacing: gridSpacing,
                            childAspectRatio: aspectRatio,
                          ),
                          itemBuilder: (context, index) =>
                              BlocBuilder<SelectedProductsCubit, SelectedProductsState>(
                            builder: (context, state) {
                              final selectedProductsWithAmount = state.when(
                                selected: (selected) => selected,
                              );

                              if (index < products.length) {
                                final product = products[index];
                                final selectedVariants =
                                    selectedProductsWithAmount.where(
                                  (selected) => product.variants.any(
                                    (variant) => variant.id == selected.variant.variantId,
                                  ),
                                ).toList();

                                final isSelected = selectedVariants.isNotEmpty;

                                return ValueListenableBuilder(
                                  valueListenable: mainServiceTypeNotifier,
                                  builder: (context, mainServiceType, _) => SelectProductCard(
                                    isSelected: isSelected,
                                    mainServiceType: mainServiceType,
                                    needAddButton: !availabilityCheckOnly,
                                    product: product,
                                    onTap: () async {
                                      showSizeAmountDialog(
                                        context: context,
                                        isSales: isSales,
                                        alreadySelectedVariants: selectedVariants,
                                        mainServiceType: mainServiceType,
                                        productImageUrl: product.image!,
                                        initialAmount: product.price?.toString(),
                                        availableVariants: product.variants,
                                        onConfirm: (id, size, amount, quantity) {
                                          final attribute = size == null || size.isEmpty
                                              ? (product.variants.first.attribute.isEmpty
                                                  ? product.model
                                                  : product.variants.first.attribute)
                                              : size;

                                          cubit.addSelectedProduct(
                                            ProductInfoModel(
                                              id: id,
                                              variantId: id,
                                              productId: product.id,
                                              name: product.name,
                                              image: product.image,
                                              amount: amount.toInt(),
                                              category: product.category,
                                              color: product.color,
                                              model: product.model,
                                              mainServiceType: mainServiceType,
                                              variantAttribute: attribute,
                                              measurements: [],
                                              quantity: quantity,
                                            ),
                                            amount.toInt(),
                                            quantity,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                );
                              } else {
                                if (nextPageUrl == null || !isPaginating) {
                                  return const SizedBox();
                                }
                                return const SelectProductCardShimmer();
                              }
                            },
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    context.read<SelectProductBloc>().state.maybeMap(
      loaded: (value) {
        if ((value.searchQuery != null && value.searchQuery!.isNotEmpty && value.searchType != null) ||
            (value.startPrice != null || value.endPrice != null)) {
          context.read<SelectProductBloc>().add(
                SelectProductEvent.searchProducts(
                  serviceId: serviceIdNotifier.value,
                  pickupDate: pickupDate,
                  returnDate: returnDate,
                  pickupTime: pickupTime,
                  returnTime: returnTime,
                  query: value.searchQuery,
                  type: value.searchType,
                  endPrice: value.endPrice,
                  startPrice: value.startPrice,
                  useAvailableProductsApi: value.useAvailableProductsApi,
                  isSales: value.isSales,
                ),
              );
        } else {
          _fetchData(context);
        }
      },
      orElse: () => _fetchData(context),
    );
  }

  void _fetchData(BuildContext context) {
    context.read<SelectProductBloc>().add(
          SelectProductEvent.loadProducts(
            serviceId: serviceIdNotifier.value,
            pickupDate: pickupDate,
            returnDate: returnDate,
            pickupTime: pickupTime,
            returnTime: returnTime,
            useAvailableProductsApi: useAvailableProductsApi,
            isSales: isSales,
          ),
        );
  }
}
