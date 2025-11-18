import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_card.dart';
import 'package:bookie_buddy_web/core/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/features/product/view/product_info_screen.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product_info/product_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckAvailabilityScreen extends StatefulWidget {
  const CheckAvailabilityScreen({super.key});

  @override
  State<CheckAvailabilityScreen> createState() =>
      _CheckAvailabilityScreenState();
}

class _CheckAvailabilityScreenState extends State<CheckAvailabilityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductBloc _productBloc = ProductBloc();
  bool _hasSearched = false;

  @override
  void dispose() {
    _searchController.dispose();
    _productBloc.close();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      context.showSnackBar('Please enter a product name or code',
          isError: true);
      return;
    }

    setState(() {
      _hasSearched = true;
    });

    // Search across all services (serviceId: 1 is default, but search will work across all)
    _productBloc.add(
      ProductEvent.searchProducts(
        serviceId: 1,
        query: query,
        type: null,
        startPrice: null,
        endPrice: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      backgroundColor: isDesktop ? const Color(0xFFF5F7FA) : null,
      appBar: AppBar(
        title: const Text('Check Availability'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDesktop ? Colors.white : null,
        foregroundColor: isDesktop ? Colors.black87 : null,
      ),
      body: BlocProvider.value(
        value: _productBloc,
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 1000 : double.infinity,
            ),
            padding: EdgeInsets.all(isDesktop ? 24 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Section
                Container(
                  padding: EdgeInsets.all(isDesktop ? 24 : 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: const Color(0xFF667eea),
                            size: isDesktop ? 28 : 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Search Product',
                            style: TextStyle(
                              fontSize: isDesktop ? 20 : 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter product name, code, or category to check availability',
                        style: TextStyle(
                          fontSize: isDesktop ? 14 : 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: 'Product Name or Code',
                              controller: _searchController,
                              hintText: 'e.g., Shirt, ABC123, Blue Dress',
                              validator: (value) => null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _performSearch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF667eea),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isDesktop ? 32 : 24,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.search, size: 20),
                                  if (isDesktop) ...[
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Search',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Results Section
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => _buildEmptyState(isDesktop),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        loaded: (products,
                            nextPageUrl,
                            isPaginating,
                            isSearching,
                            searchQuery,
                            searchType,
                            startPrice,
                            endPrice) {
                          if (!_hasSearched) {
                            return _buildEmptyState(isDesktop);
                          }

                          if (products.isEmpty) {
                            return _buildNoResultsState(isDesktop);
                          }

                          return _buildResultsList(
                            context,
                            products,
                            isDesktop,
                          );
                        },
                        error: (message) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error: $message',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _performSearch,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDesktop) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: isDesktop ? 100 : 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Search for Products',
            style: TextStyle(
              fontSize: isDesktop ? 20 : 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter a product name or code to check availability',
            style: TextStyle(
              fontSize: isDesktop ? 14 : 13,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState(bool isDesktop) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: isDesktop ? 100 : 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          Text(
            'No Products Found',
            style: TextStyle(
              fontSize: isDesktop ? 20 : 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with a different name or code',
            style: TextStyle(
              fontSize: isDesktop ? 14 : 13,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _hasSearched = false;
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Clear Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF667eea),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(
    BuildContext context,
    List products,
    bool isDesktop,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isDesktop ? 20 : 16),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: const Color(0xFF10B981),
                  size: isDesktop ? 24 : 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '${products.length} Product${products.length > 1 ? 's' : ''} Found',
                  style: TextStyle(
                    fontSize: isDesktop ? 18 : 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(isDesktop ? 20 : 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: isDesktop ? 16 : 12,
                mainAxisSpacing: isDesktop ? 16 : 12,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) =>
                              ProductInfoBloc(repository: getIt.get())
                                ..add(ProductInfoEvent.loadProductInfo(
                                  product.id,
                                )),
                          child: ProductInfoScreen(
                            serviceId: 1,
                            productId: product.id,
                            mainServiceType: MainServiceType.others,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
