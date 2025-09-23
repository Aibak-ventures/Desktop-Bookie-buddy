part of 'select_product_bloc.dart';

@freezed
class SelectProductState with _$SelectProductState {
  const factory SelectProductState.loading() = _Loading;
  const factory SelectProductState.loaded({
    required List<ProductModel> products,
    required String? nextPageUrl,
    required int serviceId,
    required String pickupDate,
    required String returnDate,
    @Default(false) bool isPaginating,
    @Default(false) bool isSearching,
    String? searchQuery,
    String? searchType,
    int? startPrice,
    int? endPrice,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    @Default(true) bool useAvailableProductsApi,
  }) = _Loaded;

  const factory SelectProductState.error(String error) = _Error;
}

extension SelectProductStateX on SelectProductState {
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
