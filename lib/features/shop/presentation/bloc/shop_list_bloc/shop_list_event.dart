part of 'shop_list_bloc.dart';

@freezed
abstract class ShopListEvent with _$ShopListEvent {
  const factory ShopListEvent.loadShops() = _LoadShops;
  const factory ShopListEvent.changeAccount(ShopEntity newShop) = _ChangeAccount;
}
