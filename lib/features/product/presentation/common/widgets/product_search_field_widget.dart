import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/features/product/presentation/common/bloc/product_search_cubit/product_search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ProductSearchFieldWidget extends StatelessWidget {
  const ProductSearchFieldWidget({
    super.key,
    required this.nameController,
    this.scrollController,
    this.onClear,
  });

  final TextEditingController nameController;
  final ScrollController? scrollController;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProductSearchCubit, ProductSearchState>(
        builder: (context, state) => TypeAheadField<ProductEntity>(
          controller: nameController,
          scrollController: scrollController,
          hideWithKeyboard: false,
          decorationBuilder: (context, child) => DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: 10.radiusBorder,
              border: BoxBorder.all(color: AppColors.grey300),
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey300,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: child,
          ),
          builder: (context, controller, focusNode) {
            focusNode.skipTraversal = true;
            return CustomTextField(
              focusNode: focusNode,
              controller: controller,
              label: 'Product (optional)',
              hintText: 'Search product',
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.category_outlined),
              suffixIcon: ValueListenableBuilder(
                valueListenable: controller,
                builder: (context, searchValue, child) =>
                    searchValue.text.isEmpty
                    ? const SizedBox.shrink()
                    : IconButton(
                        onPressed: () {
                          controller.clear();
                          context.read<ProductSearchCubit>().clearSelected();
                          onClear?.call();
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
              validator: (value) =>
                  AppInputValidators.basicText(value, isRequired: false),
            );
          },
          itemBuilder: (context, product) => _ItemListTile(product: product),
          suggestionsCallback: (query) async =>
              context.read<ProductSearchCubit>().searchProducts(query),
          onSelected: (product) {
            context.read<ProductSearchCubit>().selectProduct(product);
          },
          emptyBuilder: (context) => const SizedBox(
            height: 100,
            child: Center(child: Text('No product found')),
          ),
          errorBuilder: (context, error) => SizedBox(
            height: 100,
            child: Center(child: Text(error.toString())),
          ),
          loadingBuilder: (context) => const _LoadingBuilder(),
        ),
      );
}

class _ItemListTile extends StatelessWidget {
  const _ItemListTile({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => ListTile(
    leading: AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: 5.radiusBorder,
        child: CustomNetworkImage(
          imageUrl: product.image ?? '',
          errorWidget: (context, url, error) =>
              Image.asset(AppAssets.unknownProduct),
        ),
      ),
    ),
    title: Text(product.name),
    subtitle: Text(
      product.model?.toString() ??
          product.category?.toString() ??
          product.color?.toString() ??
          '',
    ),
    trailing: Text(product.price?.toCurrency() ?? ''),
  );
}

class _LoadingBuilder extends StatelessWidget {
  const _LoadingBuilder();

  @override
  Widget build(BuildContext context) => ListView.builder(
    shrinkWrap: true,
    itemCount: 4,
    itemBuilder: (context, index) => const ListTile(
      leading: CustomShimmerBox(width: 60, height: 60),
      title: CustomShimmerBox(width: 50, height: 15),
      subtitle: CustomShimmerBox(width: 30, height: 10),
      trailing: CustomShimmerBox(width: 35, height: 15),
    ),
  );
}
