import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_shop_entity.freezed.dart';

@freezed
abstract class UserShopEntity with _$UserShopEntity {
  const factory UserShopEntity({
    required int id,
    required String name,
    required String phone,
    String? phone2,
    required String address,
    String? gstNumber,
    String? image,
    String? place,
    String? email,
    String? city,
    String? state,
    String? pincode,
    required List<String> termsAndConditions,
  }) = _UserShopEntity;
}

extension UserShopEntityX on UserShopEntity {
  String get fullAddress {
    final parts = <String>[
      address,
      if (place != null && place!.trim().isNotEmpty) place!.trim(),
      if (city != null && city!.trim().isNotEmpty) city!.trim(),
      if (state != null && state!.trim().isNotEmpty) state!.trim(),
      if (pincode != null && pincode!.trim().isNotEmpty) pincode!.trim(),
    ];
    return parts.join(', ');
  }
}
