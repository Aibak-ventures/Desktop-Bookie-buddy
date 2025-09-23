// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,

    // user info
    @JsonKey(name: 'full_name') required String userName,
    required String phone,
    String? email,

    // Shop Info
    @JsonKey(name: 'shop_id') int? shopId,
    @JsonKey(
      name: 'shop_name',
      defaultValue: 'Shop',
    )
    required String shopName,
    @JsonKey(
      name: 'shop_phone',
      defaultValue: '9999999999',
    )
    required String shopPhone,
    @JsonKey(
      name: 'shop_address',
      defaultValue: 'Address',
    )
    required String shopAddress,
    @JsonKey(name: 'gst_number') String? gstNo,
    @JsonKey(name: 'shop_image') String? shopeImage,
    @JsonKey(name: 'terms_and_conditions')
    @Default(const [])
    List<String> termsAndConditions,

    // Account Control
    @JsonKey(defaultValue: false) required bool block,
    @JsonKey(
      name: 'multiple_shops',
      defaultValue: false,
    )
    required bool haveMultipleShops,
    String? role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

// class UserModel {
//   final int id;

//   // Personal
//   final String ownerName;
//   final String phone;
//   final String email;

//   // Shop Info
//   final String shopName;
//   final String shopPhone;
//   final String shopAddress;
//   final String? gstNo;
//   final String? shopeImage;

//   // Account Control
//   final bool block;

//   UserModel({
//     required this.id,
//     required this.phone,
//     required this.ownerName,
//     required this.email,
//     required this.shopName,
//     required this.shopPhone,
//     required this.shopAddress,
//     required this.block,
//     this.shopeImage,
//     this.gstNo,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     try {
//       return UserModel(
//         id: json['id'] as int,
//         phone: json['phone']?.toString() ?? '', // Handle potential null/number
//         ownerName: json['owner_name']?.toString() ?? '',
//         shopeImage: json['img4']?.toString(),
//         email: json['email']?.toString() ?? '',
//         shopName: json['shop_name']?.toString() ?? '',
//         shopPhone: json['shop_phone']?.toString() ?? '',
//         shopAddress: json['shop_address']?.toString() ?? '',
//         block: json['block'] as bool? ?? false,
//         gstNo: json['gst_number'] ?? "Not added",
//       );
//     } catch (e) {
//       rethrow;
//     }
//   }

//   @override
//   String toString() {
//     return 'UserModel(id: $id, ownerName: $ownerName, phone: $phone, email: $email, shopName: $shopName, shopPhone: $shopPhone, shopAddress: $shopAddress, gstNo: $gstNo, img4: $shopeImage, block: $block)';
//   }
// }
