import 'package:bookie_buddy_core/features/service/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/shop_entity/shop_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/update_shop_settings_request_entity/update_shop_settings_request_entity.dart';

abstract interface class IShopRepository {
  Future<List<ShopEntity>> getShops();

  Future<List<ServiceEntity>> getShopServices();

  /// PUTs [request] to `shop-settings/update-settings`. NOTE: unverified
  /// against the real backend — see `UpdateShopSettingsRequestModel`'s
  /// doc. Callers should refresh `UserCubit` (`loadUserData()`) after
  /// this succeeds, same as `TaxAndComplianceScreen` does after its own
  /// updates, since this doesn't return the fresh `UserEntity` itself.
  Future<void> updateShopSettings(UpdateShopSettingsRequestEntity request);
}
