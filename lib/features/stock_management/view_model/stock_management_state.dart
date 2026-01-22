import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_management_state.freezed.dart';

@freezed
class StockManagementState with _$StockManagementState {
  const factory StockManagementState.initial() = _Initial;

  const factory StockManagementState.loading() = _Loading;

  const factory StockManagementState.loaded({
    required List<ProductModel> products,
    required int totalProducts,
    required int totalCategories,
    required String? nextPageUrl,
    required bool isPaginating,
    int?
        selectedServiceId, // Changed from String selectedCategory to int? selectedServiceId (-1 means All Services)
    required String searchQuery,
    int? selectedProductId, // For showing product details
  }) = _Loaded;

  const factory StockManagementState.error({
    required String message,
  }) = _Error;
}
