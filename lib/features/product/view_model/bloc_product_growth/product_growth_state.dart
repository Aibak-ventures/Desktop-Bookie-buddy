part of 'product_growth_bloc.dart';

@freezed
class ProductGrowthState with _$ProductGrowthState {
  const factory ProductGrowthState.loading() = _Loading;
  const factory ProductGrowthState.loaded(
      List<ProductMonthlyDataModel> monthlyData) = _Loaded;
  const factory ProductGrowthState.error(String error) = _Error;
}
