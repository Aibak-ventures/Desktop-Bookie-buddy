part of 'all_shop_summary_cubit.dart';

@freezed
class AllShopSummaryState with _$AllShopSummaryState {
  const factory AllShopSummaryState.loading() = _Loading;
  const factory AllShopSummaryState.loaded({
    required AllShopSummaryModel shopSummary,
  }) = _Loaded;
  const factory AllShopSummaryState.error(String error) = _Error;
}
