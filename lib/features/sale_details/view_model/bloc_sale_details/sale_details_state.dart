part of 'sale_details_bloc.dart';

@freezed
class SaleDetailsState with _$SaleDetailsState {
  const factory SaleDetailsState.loading() = _Loading;
  const factory SaleDetailsState.loaded({
    required SaleDetailsModel saleDetails,
    @Default(false) bool isDeleted,
  }) = _Loaded;
  const factory SaleDetailsState.error(String error) = _Error;
}
