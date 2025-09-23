part of 'product_info_bloc.dart';

@freezed
class ProductInfoState with _$ProductInfoState {
  const factory ProductInfoState.loading() = _Loading;
  const factory ProductInfoState.loaded(ProductModel productInfo) = _Loaded;
  const factory ProductInfoState.error(String error) = _Error;
  const factory ProductInfoState.failure(String message) = _Failure;
  const factory ProductInfoState.success(String message,
      [@Default(false) bool needPop]) = _Success;
}
