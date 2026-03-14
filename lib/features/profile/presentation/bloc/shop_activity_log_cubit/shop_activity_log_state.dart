part of 'shop_activity_log_cubit.dart';

@freezed
class ShopActivityLogState with _$ShopActivityLogState {
  const factory ShopActivityLogState.initial() = _Initial;
  const factory ShopActivityLogState.loading() = _Loading;
  const factory ShopActivityLogState.loaded({
    required List<ShopActivityModel> activities,
    required String? nextPageUrl,
    required bool isPaginating,
  }) = _Loaded;
  const factory ShopActivityLogState.error(String message) = _Error;
}
