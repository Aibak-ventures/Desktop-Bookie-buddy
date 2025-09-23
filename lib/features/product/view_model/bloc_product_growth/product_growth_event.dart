part of 'product_growth_bloc.dart';

@freezed
class ProductGrowthEvent with _$ProductGrowthEvent {
  const factory ProductGrowthEvent.loadProductGrowthData(int productId) =
      _LoadProductGrowthData;
}
