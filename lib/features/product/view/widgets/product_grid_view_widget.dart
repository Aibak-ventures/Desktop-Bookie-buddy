import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/no_result_found_animation_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_card.dart';
import 'package:bookie_buddy_web/features/product/view/product_info_screen.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product_info/product_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridViewWidget extends StatelessWidget {
  const ProductGridViewWidget({
    required this.serviceId,
    required this.mainServiceType,
    required this.scrollController,
    required this.searchController,
    super.key,
  });

  final int serviceId;
  final MainServiceType mainServiceType;
  final ScrollController scrollController;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator.adaptive(
      onRefresh: () async {
        _onRefresh(context);
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          int crossAxisCount = 2;
          double aspectRatio = 0.76;
          if (context.isTablet) {
            crossAxisCount = 3;
            aspectRatio = 0.8;
          } else if (context.isDesktop) {
            crossAxisCount = 6;
            aspectRatio = 0.84;
          }
          return state.when(
            initial: () => SingleChildScrollView(
              child: SizedBox(
                height: context.mediaQueryHeight(0.7),
                child: const Center(
                  child: Text('Products is empty'),
                ),
              ),
            ),
            loading: () => GridView.builder(
              padding: 10.padding,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: aspectRatio,
              ),
              itemCount: 16,
              itemBuilder: (context, index) {
                return const ProductCardShimmer();
              },
            ),
            error: (error) => CustomErrorWidget(
              errorText: error,
              onRetry: () => _onRefresh(context),
            ),
            loaded: (
              products,
              nextPageUrl,
              isPaginating,
              isSearching,
              searchQuery,
              searchType,
              startPrice,
              endPrice,
            ) {
              return products.isEmpty
                  ? isSearching
                      ? const NoResultFoundAnimationWidget(
                          adjustHeightTop: 0.15,
                        )
                      : const NoProductFoundAnimationWidget(
                          adjustHeightTop: 0.15,
                        )
                  : GridView.builder(
                      controller: scrollController, // Add scroll controller
                      padding: 10.padding,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: aspectRatio,
                      ),
                      itemCount: products.length + (isPaginating ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (products.length > index) {
                          final product = products[index];
                          return ProductCard(
                            product: product,
                            onTap: () {
                              context.push(
                                BlocProvider(
                                  create: (context) =>
                                      ProductInfoBloc(repository: getIt.get()),
                                  child: ProductInfoScreen(
                                    serviceId: serviceId,
                                    productId: product.id,
                                    mainServiceType: mainServiceType,
                                  ),
                                ),
                              );
                            },
                            onOptionSelected: (value) async {},
                          );
                        } else {
                          return const ProductCardShimmer();
                        }
                      },
                    );
            },
          );
        },
      ),
    ));
  }

  void _onRefresh(BuildContext context) {
    context.read<ProductBloc>().state.maybeMap(
      loaded: (value) {
        if (value.searchQuery != null &&
            value.searchQuery!.isNotEmpty &&
            value.searchType != null) {
          context.read<ProductBloc>().add(
                ProductEvent.searchProducts(
                  serviceId: serviceId,
                  query: value.searchQuery,
                  type: value.searchType,
                  startPrice: value.startPrice,
                  endPrice: value.endPrice,
                ),
              );
        } else {
          _fetchData(context);
        }
      },
      orElse: () {
        _fetchData(context);
      },
    );
  }

  void _fetchData(BuildContext context) {
    context.read<ProductBloc>().add(
          ProductEvent.loadProducts(serviceId),
        );
  }
}
