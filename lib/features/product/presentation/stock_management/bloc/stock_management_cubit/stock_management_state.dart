part of 'stock_management_cubit.dart';

@freezed
abstract class StockManagementState with _$StockManagementState {
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
