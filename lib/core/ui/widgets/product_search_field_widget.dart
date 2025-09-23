import 'package:bookie_buddy_web/core/app_icons.dart';
import 'package:bookie_buddy_web/core/app_input_validators.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/view_model/bloc_product_search/product_search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ProductSearchFieldWidget extends StatelessWidget {
  const ProductSearchFieldWidget({
    super.key,
    required this.nameController,
    required this.scrollController,
    this.onClear,
  });

  final TextEditingController nameController;
  final ScrollController scrollController;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductSearchBloc, ProductSearchState>(
      builder: (context, state) {
        return TypeAheadField<ProductModel>(
          controller: nameController,
          scrollController: scrollController,
          hideOnSelect: true,
          // listBuilder: (context, children) {
          //   return ListView.builder(
          //     controller: scrollController,
          //     itemCount: children.length,
          //     itemBuilder: (context, index) {
          //       final child = children[index];
          //       return child;
          //     },
          //   );
          // },
          decorationBuilder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: 10.radiusBorder,
                border: BoxBorder.all(
                  color: AppColors.grey300,
                ),
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
            );
          },
          builder: (context, controller, focusNode) {
            return CustomTextField(
              focusNode: focusNode,
              controller: controller,
              label: 'Product (optional)',
              hintText: 'Search product',
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(
                Icons.category_outlined,
              ),
              suffixIcon: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, searchValue, child) {
                    return searchValue.text.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              controller.clear();
                              context.read<ProductSearchBloc>().add(
                                  const ProductSearchEvent.clearSelected());
                              onClear?.call();
                            },
                            icon: const Icon(Icons.clear),
                          );
                  }),
              validator: (value) => AppInputValidators.basicText(
                value,
                isRequired: false,
              ),
              onChanged: (value) {
                final bloc = context.read<ProductSearchBloc>();
                final isLoading = state.maybeMap(
                  orElse: () => false,
                  initial: (value) => value.isLoading,
                );
                if (!isLoading)
                  bloc.add(ProductSearchEvent.searchQueryChanged(value));
              },
            );
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: 5.radiusBorder,
                  child: CustomNetworkImage(
                    imageUrl: suggestion.image ?? '',
                    errorWidget: (context, url, error) => Image.asset(
                      AppIcons.unknownProduct,
                    ),
                  ),
                ),
              ),
              title: Text(suggestion.name),
              subtitle: Text(
                suggestion.model?.toString() ??
                    suggestion.category?.toString() ??
                    suggestion.color?.toString() ??
                    '',
              ),
              trailing: Text(
                suggestion.price?.toCurrency() ?? '',
              ),
            );
          },
          suggestionsCallback: (pattern) async {
            return state.maybeMap(
              orElse: () => [],
              initial: (value) => value.suggestions,
            );
          },
          onSelected: (product) {
            context
                .read<ProductSearchBloc>()
                .add(ProductSearchEvent.productSelected(product));
          },
          emptyBuilder: (context) => const SizedBox(
            height: 100,
            child: Center(child: Text('No client found')),
          ),
          errorBuilder: (context, error) => SizedBox(
            height: 100,
            child: Center(child: Text(error.toString())),
          ),
          loadingBuilder: (context) => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
