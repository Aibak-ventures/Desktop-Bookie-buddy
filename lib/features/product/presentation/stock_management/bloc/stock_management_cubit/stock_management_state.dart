part of 'stock_management_cubit.dart';

@freezed
abstract class StockManagementState with _$StockManagementState {
  const factory StockManagementState.initial() = _Initial;

  const factory StockManagementState.loading() = _Loading;

  const factory StockManagementState.loaded({
    required List<ProductEntity> products,
    required int totalProducts,
    required int totalCategories,
    required String? nextPageUrl,
    required bool isPaginating,
    int? selectedServiceId,
    required String searchQuery,
    int? selectedProductId,
  }) = _Loaded;

  const factory StockManagementState.error({
    required String message,
  }) = _Error;
}
