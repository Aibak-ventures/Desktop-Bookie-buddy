import 'package:bookie_buddy_web/features/shop/domain/entities/shop_entity/shop_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_model.freezed.dart';
part 'shop_model.g.dart';

@freezed
abstract class ShopModel with _$ShopModel {
  const factory ShopModel({
    required int id,
    required String name,
    String? place,
    required String phone,
    String? email,
    @JsonKey(
      defaultValue: 'Address not available',
    )
    required String address,
    @JsonKey(name: 'pincode') String? pincode,
    @JsonKey(name: 'subscription_status') String? subscriptionStatus,
    @JsonKey(name: 'img') String? image,
  }) = _ShopModel;

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);
}

extension ShopModelMapper on ShopModel {
  ShopEntity toEntity() => ShopEntity(
        id: id,
        name: name,
        place: place,
        phone: phone,
        email: email,
        address: address,
        pincode: pincode,
        subscriptionStatus: subscriptionStatus,
        image: image,
      );
}
