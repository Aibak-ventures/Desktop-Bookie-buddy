part of 'sales_details_bloc.dart';

@freezed
class SalesDetailsState with _$SalesDetailsState {
  const factory SalesDetailsState.initial() = _Initial;
  const factory SalesDetailsState.loading() = _Loading;
  const factory SalesDetailsState.loaded({required SaleDetailsModel sale}) =
      _Loaded;
  const factory SalesDetailsState.error(String message) = _Error;
  const factory SalesDetailsState.success({
    required String message,
    @Default(false) bool didPop,
    @Default(false) bool needRefresh,
  }) = _Success;
}
