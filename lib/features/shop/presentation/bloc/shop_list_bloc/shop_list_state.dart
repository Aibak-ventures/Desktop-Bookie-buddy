part of 'shop_list_bloc.dart';

@freezed
class ShopListState with _$ShopListState {
  const factory ShopListState.loading() = _Loading;
  const factory ShopListState.loaded({
    required List<ShopEntity> shops,
    required int? currentShopId,
  }) = _Loaded;
  const factory ShopListState.changeSuccess(ShopEntity newShop) = _ChangeSuccess;
  const factory ShopListState.error(String error) = _Error;
}
