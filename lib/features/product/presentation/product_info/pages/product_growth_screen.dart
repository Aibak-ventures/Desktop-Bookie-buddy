import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/widgets/product_growth_list_tile.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_info/bloc/product_growth_bloc/product_growth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductGrowthScreen extends StatelessWidget {
  const ProductGrowthScreen({
    required this.productId,
    super.key,
  });
  final int productId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Monthly Growth'),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<ProductGrowthBloc>().add(
                  ProductGrowthEvent.loadProductGrowthData(productId),
                );
          },
          child: BlocBuilder<ProductGrowthBloc, ProductGrowthState>(
            builder: (context, state) {
              return state.when(
                loading: () => ListView.builder(
                  itemCount: 5,
                  padding: 16.padding,
                  itemBuilder: (context, index) {
                    return const ProductGrowthListTileShimmer();
                  },
                ),
                loaded: (monthlyData) {
                  return monthlyData.isEmpty
                      ? Center(
                          child: Text('No Data Available'),
                        )
                      : ListView.builder(
                          itemCount: monthlyData.length,
                          padding: 16.padding,
                          itemBuilder: (context, index) {
                            final monthData = monthlyData[index];
                            final isLoss =
                                monthData.totalExpense > monthData.totalEarned;
                            return ProductGrowthListTile(
                              monthData: monthData,
                              isLoss: isLoss,
                            );
                          },
                        );
                },
                error: (error) => CustomErrorWidget(
                  errorText: error,
                  onRetry: () {
                    context.read<ProductGrowthBloc>().add(
                          ProductGrowthEvent.loadProductGrowthData(productId),
                        );
                  },
                ),
              );
            },
          ),
        ));
  }
}
