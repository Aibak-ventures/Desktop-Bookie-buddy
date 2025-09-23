import 'package:bookie_buddy_web/core/utils/responsive_screen_mixin.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_card.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGridScreen extends StatefulWidget with ResponsiveScreenMixin {
  final int? serviceId;
  final String? name;
  final dynamic mainServiceType;
  
  const ProductGridScreen({
    super.key,
    this.serviceId,
    this.name,
    this.mainServiceType,
  });

  @override
  String get screenTitle => name ?? 'Products';

  @override
  IconData get screenIcon => Icons.inventory_2_outlined;

  @override
  Widget buildContent(BuildContext context) {
    return const _ProductGridContent();
  }

  @override
  List<Widget> getAppBarActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // Navigate to add product screen
        },
      ),
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          // Show search dialog
        },
      ),
    ];
  }

  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

class _ProductGridScreenState extends State<ProductGridScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final serviceId = widget.serviceId ?? 1; // Default service ID
    context.read<ProductBloc>().add(ProductEvent.loadProducts(serviceId));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      final serviceId = widget.serviceId ?? 1;
      context.read<ProductBloc>().add(ProductEvent.loadNextPageProducts(serviceId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildResponsiveScreen(context);
  }
}

class _ProductGridContent extends StatelessWidget {
  const _ProductGridContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return state.when(
          initial: () => const _LoadingGrid(),
          loading: () => const _LoadingGrid(),
          loaded: (products, nextPageUrl, isPaginating, isSearching, searchQuery, searchType, startPrice, endPrice) {
            if (products.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No products found'),
                  ],
                ),
              );
            }

            return _ProductGrid(
              products: products,
              hasNextPage: nextPageUrl != null,
              isPaginating: isPaginating,
            );
          },
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $message'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Retry loading
                    context.read<ProductBloc>().add(ProductEvent.loadProducts(1));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProductGrid extends StatefulWidget {
  final List products;
  final bool hasNextPage;
  final bool isPaginating;

  const _ProductGrid({
    required this.products,
    required this.hasNextPage,
    required this.isPaginating,
  });

  @override
  State<_ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<_ProductGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (widget.hasNextPage && !widget.isPaginating) {
        context.read<ProductBloc>().add(ProductEvent.loadNextPageProducts(1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth > 1200) {
      crossAxisCount = 4;
      childAspectRatio = 0.8;
    } else if (screenWidth > 768) {
      crossAxisCount = 3;
      childAspectRatio = 0.85;
    } else {
      crossAxisCount = 2;
      childAspectRatio = 0.9;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: widget.hasNextPage ? widget.products.length + 1 : widget.products.length,
        itemBuilder: (context, index) {
          if (index >= widget.products.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return ProductCard(
            product: widget.products[index],
            onTap: () {
              // Navigate to product details
            },
          );
        },
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 768) {
      crossAxisCount = 3;
    } else {
      crossAxisCount = 2;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
