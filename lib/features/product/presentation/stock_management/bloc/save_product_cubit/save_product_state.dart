part of 'save_product_cubit.dart';

@freezed
abstract class SaveProductState with _$SaveProductState {
  const factory SaveProductState.initial() = _Initial;
  const factory SaveProductState.submitted() = _Submitted;
  const factory SaveProductState.success() = _Success;
  const factory SaveProductState.error(String error) = _Error;
}
