import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_entity.freezed.dart';

@freezed
abstract class ShopEntity with _$ShopEntity {
  const factory ShopEntity({
    required int id,
    required String name,
    String? place,
    required String phone,
    String? email,
    required String address,
    String? pincode,
    String? subscriptionStatus,
    String? image,
  }) = _ShopEntity;
}
